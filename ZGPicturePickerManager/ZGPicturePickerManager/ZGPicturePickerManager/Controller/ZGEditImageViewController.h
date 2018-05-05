//
//  ZGEditImageViewController.h
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/26.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ZGPickerCompletionBlock)(UIImage *image, NSDictionary *info);
typedef void (^ZGPickerCancelBlock)(void);

@interface ZGEditImageViewController : UIViewController

@property (nonatomic, strong) NSDictionary *info;
@property (strong, nonatomic) UIImage *image;

@property (nonatomic, assign) BOOL noClipMask;
@property (nonatomic, assign) CGSize clipSize;
@property (nonatomic, assign) CGFloat cornerRadius;

@property (copy, nonatomic) ZGPickerCompletionBlock completionBlock;
@property (copy, nonatomic) ZGPickerCancelBlock cancelBlock;


@end
