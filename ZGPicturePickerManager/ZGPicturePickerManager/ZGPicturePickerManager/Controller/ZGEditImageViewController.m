//
//  ZGEditImageViewController.m
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/26.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGEditImageViewController.h"
#import "ZGClipView.h"

#define ZGSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define ZGSCREENWIDTH [UIScreen mainScreen].bounds.size.width


@interface ZGEditImageViewController () <UIScrollViewAccessibilityDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) ZGClipView *clipView;
@property (nonatomic,assign) CGRect clipRect;

@end

@implementation ZGEditImageViewController


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
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.frame = self.view.bounds;
    //隐藏滚动条
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_scrollView];
    
    
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
    
    // 遮罩
    if (self.noClipMask == NO) {
        [self addMaskView];
    }
    
    // clipView
    _clipView = [[ZGClipView alloc] initWithClipTargetFrame:self.clipRect];
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



#pragma mark - addMask
- (void)addMaskView
{
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    UIView * maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    // 必须设置为NO
    maskView.userInteractionEnabled = NO;
    [maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [self.view addSubview:maskView];
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, height)];
    
    //    // MARK: circlePath
    //    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, 200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    // MARK: roundRectanglePath
    if (self.clipSize.width > 0 && self.clipSize.height > 0) {
        self.clipRect = CGRectMake((width-self.clipSize.width)/2.0, (height - self.clipSize.height)/2.0, self.clipSize.width, self.clipSize.height);
    }else {
        self.clipRect = CGRectMake(20, (height - 200) / 2.0, width - 2 * 20, 200);
    }
    if (self.cornerRadius < 0) {
        self.cornerRadius = 0;
    }
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:self.clipRect
                                                 cornerRadius:self.cornerRadius] bezierPathByReversingPath]];
    
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
        UIImage *resultImage = nil;
        if (self.noClipMask) {
            resultImage = self.image;
        }else {
            resultImage = [self imageByClip:self.image];
        }
        self.completionBlock(resultImage,self.info);
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
- (UIImage *)imageByClip:(UIImage *)image
{
    UIImage* doneImage = nil;
    UIGraphicsBeginImageContext(self.scrollView.contentSize);
    {
        CGPoint savedContentOffset = self.scrollView.contentOffset;
        CGRect savedFrame = self.scrollView.frame;
        self.scrollView.contentOffset = CGPointZero;
        self.scrollView.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect clipRect = CGRectMake(savedContentOffset.x + self.clipRect.origin.x, savedContentOffset.y + self.clipRect.origin.y, self.clipRect.size.width, self.clipRect.size.height);
        CGContextAddRect(context, clipRect);
        CGContextClip(context);
        
        [self.scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        
        doneImage = UIGraphicsGetImageFromCurrentImageContext();
        CGImageRef imgRef = CGImageCreateWithImageInRect(doneImage.CGImage, clipRect);
        doneImage = [UIImage imageWithCGImage:imgRef];
        
        self.scrollView.contentOffset = savedContentOffset;
        self.scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    /** test
     // write image to file
     NSData *imgData = UIImagePNGRepresentation(doneImage);
     [imgData writeToFile:@"/Users/kgfanxing/Desktop/doneImage.png" atomically:YES];
     */
    
    return doneImage;
}

@end
