//
//  ZGClipView.h
//  ZGPicturePickerManager
//
//  Created by 徐宗根 on 2018/5/5.
//  Copyright © 2018年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGEdgeLineView.h"

@class ZGClipView;

@protocol ZGClipViewDelegate <NSObject>

- (void)clipView:(ZGClipView *)clipView didPanEndWithClipViewRect:(CGRect)clipViewRect;

@end

@interface ZGClipView : UIView

- (instancetype)initWithClipTargetFrame:(CGRect)clipTargetFrame;
@property (nonatomic, weak) id <ZGClipViewDelegate> delegate;

@end
