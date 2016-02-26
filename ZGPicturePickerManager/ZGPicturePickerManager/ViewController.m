//
//  ViewController.m
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/25.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ViewController.h"
#import "ZGPicturePickerManager/ZGPicturePickerManager.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

  
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[ZGPicturePickerManager sharedPicturePickerManager] showActionSheetInView:self.view fromController:self completion:^(UIImage *image) {
        
        NSLog(@"选择完成");
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
