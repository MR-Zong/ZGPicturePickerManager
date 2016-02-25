//
//  ZGPicturePickerManager.m
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/25.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGPicturePickerManager.h"

@interface ZGPicturePickerManager () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) UIViewController *fromController;

@property (weak, nonatomic) UIView *inView;

@property (copy, nonatomic) ZGPickerCompletionBlock completionBlock;

@property (copy, nonatomic) ZGPickerCancelBlock cancelBlock;

@end

@implementation ZGPicturePickerManager

+ (instancetype)sharedPicturePickerManager
{
    static ZGPicturePickerManager *_pickerManager_ = nil;
    static dispatch_once_t onceToken;
    if (!_pickerManager_) {
        
        dispatch_once(&onceToken, ^{
            _pickerManager_ = [[ZGPicturePickerManager alloc] init];
        });
    }
    
    return _pickerManager_;
}

- (void)showActionSheetInView:(UIView *)inView fromController:(UIViewController *)fromController completion:(ZGPickerCompletionBlock)completion cancelBlock:(ZGPickerCancelBlock)cancelBlock
{
    self.inView = inView;
    self.fromController = fromController;
    self.completionBlock = completion;
    self.cancelBlock = cancelBlock;
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照获取",@"从相册选择一张" ,nil];
    
    [actionSheet showInView:inView];
}

#pragma mark - <UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.delegate = self;
    
    switch (buttonIndex) {
        case 0:
        {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
        case 1:
        {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        default:
            break;
    }
    
    [self.fromController presentViewController:imagePickerVC animated:YES completion:nil];
}

@end
