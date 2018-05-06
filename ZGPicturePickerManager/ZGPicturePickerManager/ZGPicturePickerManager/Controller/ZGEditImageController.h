//
//  ZGEditImageViewController.h
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/26.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

/**
 * @pragma photoAsset : 如果 isSaveToAlbum == YES 并且，保存相册成功，就会有返回值
 */
typedef void(^ZGPickerCompletionBlock)(UIImage *image, NSDictionary *info, PHAsset *photoAsset);
typedef void (^ZGPickerCancelBlock)(void);

@interface ZGEditImageController : UIViewController

@property (nonatomic, strong) NSDictionary *info;
@property (strong, nonatomic) UIImage *image;

/**
 * 是否保存到相册
 */
@property (nonatomic, assign) BOOL isSaveToAlbum;
@property (nonatomic, assign) BOOL noClipMask;
@property (nonatomic, assign) CGSize clipSize;
@property (nonatomic, assign) CGFloat cornerRadius;

@property (copy, nonatomic) ZGPickerCompletionBlock completionBlock;
@property (copy, nonatomic) ZGPickerCancelBlock cancelBlock;


@end
