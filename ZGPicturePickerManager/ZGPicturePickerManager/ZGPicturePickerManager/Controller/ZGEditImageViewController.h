//
//  ZGEditImageViewController.h
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/26.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZGPickerCompletionBlock)(UIImage *image);
typedef void(^ZGPickerCancelBlock)();

@interface ZGEditImageViewController : UIViewController

@property (strong, nonatomic) UIImage *image;

@property (copy, nonatomic) ZGPickerCompletionBlock completionBlock;

@property (copy, nonatomic) ZGPickerCancelBlock cancelBlock;

@end
