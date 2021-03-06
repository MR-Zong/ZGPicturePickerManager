//
//  ZGPicturePickerManager.h
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/25.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGEditImageController.h"

@interface ZGPicturePickerManager : NSObject


+ (instancetype)sharedPicturePickerManager;

/**
 * 是否保存到相册
 */
@property (nonatomic, assign) BOOL isSaveToAlbum;

/**
 * 裁剪矩形
 */
@property (nonatomic, assign) CGSize clipSize;
/**
 * 裁剪矩形的圆角
 */
@property (nonatomic, assign) CGFloat cornerRadius;
/**
 * 是否需要遮罩
 */
@property (nonatomic, assign) BOOL noClipMask;

/*!
 * @brief 此方法为调起选择图片或者拍照的入口，当选择图片或者拍照后选择使用图片后，回调completion，
 *        当用户点击取消后，回调cancelBlock
 * @param inView UIActionSheet呈现到inView这个视图上
 * @param fromController 用于呈现UIImagePickerController的控制器
 * @param completion 当选择图片或者拍照后选择使用图片后，回调completion
 * @param cancelBlock 当用户点击取消后，回调cancelBlock
 */
- (void)showActionSheetInView:(UIView *)inView
               fromController:(UIViewController *)fromController
                   completion:(ZGPickerCompletionBlock)completion
                  cancelBlock:(ZGPickerCancelBlock)cancelBlock;

@end
