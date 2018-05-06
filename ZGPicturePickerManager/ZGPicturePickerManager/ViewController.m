//
//  ViewController.m
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/25.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ViewController.h"
#import "ZGPicturePickerManager.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initView];
  
}

- (void)initView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.frame = self.view.bounds;
    imageView.contentMode = UIViewContentModeCenter;
    imageView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"选择图片" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 50 - 20, 80, 50);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick
{
    __weak typeof(self) weakSelf = self;
    ZGPicturePickerManager *pickerM = [ZGPicturePickerManager sharedPicturePickerManager];
    pickerM.isSaveToAlbum = YES;
    pickerM.clipSize = CGSizeMake(280, 260);
//    pickerM.cornerRadius = pickerM.clipSize.height / 2.0;
    [pickerM showActionSheetInView:self.view fromController:self completion:^(UIImage *image, NSDictionary *info, PHAsset *photoAsset) {
        
        NSLog(@"选择完成");
        NSLog(@"weakSelf %@",weakSelf);
        NSLog(@"weakSelf.imageView %@",weakSelf.imageView);
        NSLog(@"image %@",image);
        NSString *filename = [photoAsset valueForKey:@"filename"];
        NSLog(@"filename:%@",filename);
        weakSelf.imageView.image = image;
    } cancelBlock:nil];

}

- (void)test
{
    UIView *overLayView = [[UIView alloc] init];
    overLayView.frame = self.view.bounds;
    overLayView.backgroundColor = [UIColor blackColor];
    overLayView.alpha = 1;
    [self.view addSubview:overLayView];
    
    
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 30, 100);
    CGPathAddLineToPoint(path, NULL, 300, 100);
    CGPathAddLineToPoint(path, NULL, 300, 300);
    CGPathAddLineToPoint(path, NULL, 30, 300);
    CGPathCloseSubpath(path);
    CGPathAddArc(path, NULL, 200, 150, 100, 0, 2*M_PI, NO);


    maskLayer.path = path;
    maskLayer.opacity = 1;
    
    overLayView.layer.mask = maskLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
