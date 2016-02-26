//
//  ZGEditImageViewController.m
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/26.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGEditImageViewController.h"

#define ZGSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define ZGSCREENWIDTH [UIScreen mainScreen].bounds.size.width


@interface ZGEditImageViewController () <UIScrollViewAccessibilityDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *scrollView;

@property (weak,nonatomic) UIImageView *imageView;

@property (nonatomic,assign) CGFloat maximumZoomScale;


@end

@implementation ZGEditImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initView];
}

- (void)initView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scrollView];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [self.scrollView addSubview:imageView];
    imageView.image = self.image;
    // 必须设置imageView.frame
    CGRect tmpFrame = imageView.frame;
    tmpFrame.size.width = self.image.size.width;
    tmpFrame.size.height = self.image.size.height;
    
    CGFloat scaleWidth = ZGSCREENWIDTH;
    // 重新你设置imageView.frame 压缩图片大小
    tmpFrame.size.width = scaleWidth;
    
    imageView.frame = tmpFrame;

    self.maximumZoomScale = tmpFrame.size.width / scaleWidth;
    
    tmpFrame.origin.x = 0;
    
    if (imageView.image.size.height >= ZGSCREENHEIGHT) {
        
        tmpFrame.origin.y = 0;
        self.scrollView.contentSize = imageView.frame.size;
    }else {
        CGPoint tmpPoint = imageView.center;
        tmpPoint.y = ZGSCREENHEIGHT * 0.5;
        imageView.center = tmpPoint;
        
    }
    
    imageView.frame = tmpFrame;
    
    if (self.maximumZoomScale > 1) {
        self.scrollView.maximumZoomScale = self.maximumZoomScale;
    }
    
    [self addMaskForView:self.view];
    
    [self addBottomButtons];
}

#pragma mark - <UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"imageView %@",self.imageView);
    return self.imageView;
    
}


#pragma mark - addMask
- (void)addMaskForView:(UIView *)view
{
    CGFloat width = view.bounds.size.width;
    CGFloat height = view.bounds.size.height;
    
    UIView * maskView = [[UIView alloc] init];
    // 必须设置为NO
    maskView.userInteractionEnabled = NO;
    [maskView setFrame:CGRectMake(0, 0, width, height)];
    [maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [self.view addSubview:maskView];
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, height)];
    
//    // MARK: circlePath
//    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, 200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    // MARK: roundRectanglePath
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, (height - 200) / 2.0, width - 2 * 20, 200) cornerRadius:15] bezierPathByReversingPath]];
    
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
    completeButton.frame = CGRectMake(self.view.bounds.size.width - 40 - 20, self.view.bounds.size.height - 23 - 40, 40, 23);
    [self.view addSubview:completeButton];
    [completeButton addTarget:self action:@selector(completeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(20, self.view.bounds.size.height - 23 - 40, 40, 23);
    [self.view addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - button click
- (void)completeButtonClick:(UIButton *)btn
{
    if (self.completionBlock) {
        self.completionBlock(self.image);
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelButtonClick
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
