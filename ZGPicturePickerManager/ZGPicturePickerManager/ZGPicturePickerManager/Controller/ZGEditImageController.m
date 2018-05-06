//
//  ZGEditImageViewController.m
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/26.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGEditImageController.h"
#import "ZGClipView.h"

#define ZGSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define ZGSCREENWIDTH [UIScreen mainScreen].bounds.size.width


@interface ZGEditImageController () <UIScrollViewAccessibilityDelegate,UIScrollViewDelegate,ZGClipViewDelegate>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) ZGClipView *clipView;
@property (nonatomic,assign) CGRect clipRect;

@end

@implementation ZGEditImageController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews
{
    _containView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_containView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    //隐藏滚动条
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor blackColor];
    [_containView addSubview:_scrollView];
    
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:_imageView];
    _imageView.image = self.image;
    
    
    // 设置_imgView的位置大小
    CGRect frame ;
    frame.size.width = _scrollView.frame.size.width;
    frame.size.height =frame.size.width*(_image.size.height/_image.size.width);
    _imageView.frame = frame;
    _imageView.center= _scrollView.center;
    
    //设置最大放大比例、内容大小和代理
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.contentSize=_imageView.frame.size;
    
    // clipRect
    if (self.cornerRadius < 0) {
        self.cornerRadius = 0;
    }

    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    if (self.clipSize.width > 0 && self.clipSize.height > 0) {
        self.clipRect = CGRectMake((width-self.clipSize.width)/2.0, (height - self.clipSize.height)/2.0, self.clipSize.width, self.clipSize.height);
    }else {
        self.clipRect = CGRectMake(20, (height - 200) / 2.0, width - 2 * 20, 200);
    }

    // MaskView
    if (self.noClipMask == NO) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        // 必须设置为NO
        _maskView.userInteractionEnabled = NO;
        [_maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        [self.view addSubview:_maskView];
        [self especialMaskView:_maskView transparentRect:self.clipRect cornerRadius:self.cornerRadius];
    }
    
    // clipView
    _clipView = [[ZGClipView alloc] initWithClipTargetFrame:self.clipRect];
    _clipView.delegate = self;
    [self.view addSubview:_clipView];

    
    // 底部操作按钮
    [self addBottomButtons];
}

#pragma mark - <UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    [self.imageView setCenter:CGPointMake(xcenter, ycenter)];
}


#pragma mark - ZGClipViewDelegate
- (void)clipView:(ZGClipView *)clipView didPanEndWithClipViewRect:(CGRect)clipViewRect
{
    self.clipRect = CGRectInset(clipViewRect, ZGClipEdgeUserInteractiveSpaceUnit, ZGClipEdgeUserInteractiveSpaceUnit);
    [self especialMaskView:self.maskView transparentRect:self.clipRect cornerRadius:self.cornerRadius];
}


#pragma mark - addMask
/**
 * @pramga transparentRect : 透明的rect
 * @pramga cornerRadius : 圆角半径
 */
- (void)especialMaskView:(UIView *)maskView transparentRect:(CGRect)transparentRect cornerRadius:(CGFloat)cornerRadius
{
    CGFloat width = maskView.bounds.size.width;
    CGFloat height = maskView.bounds.size.height;
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, height)];
    
    //    // MARK: circlePath
    //    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, 200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    // MARK: roundRectanglePath
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:transparentRect
                                                 cornerRadius:cornerRadius] bezierPathByReversingPath]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [maskView.layer setMask:shapeLayer];
    
}


#pragma mark -
- (void)addBottomButtons
{
    /**
     * 添加:完成按钮 取消按钮
     */
    UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    completeButton.frame = CGRectMake(self.view.bounds.size.width - 60 - 20, self.view.bounds.size.height - 40 - 40, 60, 40);
    [self.view addSubview:completeButton];
    [completeButton addTarget:self action:@selector(completeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(20, self.view.bounds.size.height - 40 - 40, 60, 40);
    [self.view addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - button click
- (void)completeButtonClick:(UIButton *)btn
{
    if (self.completionBlock) {
       
        
        if (self.noClipMask) {
            self.completionBlock(self.image,self.info, nil);
        }else {
            [self imageByClip:self.image completeBlock:^(UIImage *image, PHAsset *photoAsset) {
                NSLog(@"thread %@",[NSThread currentThread]);
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.completionBlock(image, self.info, photoAsset);
                });
            }];
        }
        
        
       
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelButtonClick
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    UIImagePickerController *imagePickerController = (UIImagePickerController *)self.navigationController;
    if (imagePickerController.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - clipImage
- (void)imageByClip:(UIImage *)image completeBlock:(void(^)(UIImage *image, PHAsset *photoAsset))completeBlock
{
    UIImage* doneImage = nil;
    UIGraphicsBeginImageContext(self.containView.bounds.size);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect clipRect = CGRectMake(self.clipRect.origin.x, self.clipRect.origin.y, self.clipRect.size.width, self.clipRect.size.height);
        CGContextAddRect(context, clipRect);
        CGContextClip(context);
        
        [self.containView.layer renderInContext: UIGraphicsGetCurrentContext()];
        
        doneImage = UIGraphicsGetImageFromCurrentImageContext();
        CGImageRef imgRef = CGImageCreateWithImageInRect(doneImage.CGImage, clipRect);
        doneImage = [UIImage imageWithCGImage:imgRef];
        
    }
    UIGraphicsEndImageContext();
    
    // 是否保存到相册
    if (self.isSaveToAlbum) {
        [self saveImageInAlbum:doneImage completeBlock:^(PHAsset *photoAsset) {
            if (completeBlock) {
                completeBlock(doneImage, photoAsset);
            }
        }];
    }else {
        if (completeBlock) {
            completeBlock(doneImage,nil);
        }
    }
    
}

#pragma mark - 保存到相册
- (void)saveImageInAlbum:(UIImage *)image completeBlock:(void(^)(PHAsset *photoAsset))completeBlock
{
    
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        //记录本地标识，等待完成后取到相册中的图片对象
        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success = %d, error = %@", success, error);
        if (success)
        {
            //成功后取相册中的图片对象
            __block PHAsset *imageAsset = nil;
            PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageIds options:nil];
            [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                imageAsset = obj;
                *stop = YES;
            }];
            
            if (imageAsset) {
                
                if (completeBlock) {
                    completeBlock(imageAsset);
                }
                //                //加载图片数据
                //                [[PHImageManager defaultManager] requestImageDataForAsset:imageAsset
                //                                                                  options:nil
                //                                                            resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                //                                                                NSLog(@"imageData = %@", imageData);
                //                                                            }];
                
                
                
            }
            
            
            
        }else {
            if (completeBlock) {
                completeBlock(nil);
            }
        }
    }];
    
}

#pragma mark - 直接从UIScrollView截图 ,缩小时候会解决不了
//- (UIImage *)imageByClip:(UIImage *)image
//{
////    NSLog(@"contentOffset %@",NSStringFromCGPoint(self.scrollView.contentOffset));
////     NSLog(@"contentSize %@",NSStringFromCGSize(self.scrollView.contentSize));
//    UIImage* doneImage = nil;
//    UIGraphicsBeginImageContext(self.scrollView.contentSize);
//    {
//        CGPoint savedContentOffset = self.scrollView.contentOffset;
//        self.scrollView.contentOffset = CGPointZero;
//        self.scrollView.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
//
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGRect clipRect = CGRectMake(savedContentOffset.x + self.clipRect.origin.x, savedContentOffset.y + self.clipRect.origin.y, self.clipRect.size.width, self.clipRect.size.height);
//        CGContextAddRect(context, clipRect);
//        CGContextClip(context);
//
//        [self.scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
//
//        doneImage = UIGraphicsGetImageFromCurrentImageContext();
//        CGImageRef imgRef = CGImageCreateWithImageInRect(doneImage.CGImage, clipRect);
//        doneImage = [UIImage imageWithCGImage:imgRef];
//
//        self.scrollView.contentOffset = savedContentOffset;
//    }
//    UIGraphicsEndImageContext();
//
//    /** test
//     // write image to file
//     NSData *imgData = UIImagePNGRepresentation(doneImage);
//     [imgData writeToFile:@"/Users/kgfanxing/Desktop/doneImage.png" atomically:YES];
//     */
//
//    return doneImage;
//}

@end
