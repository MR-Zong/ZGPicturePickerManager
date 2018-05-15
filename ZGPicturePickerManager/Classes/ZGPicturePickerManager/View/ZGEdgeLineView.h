//
//  ZGEdgeLineView.h
//  ZGPicturePickerManager
//
//  Created by 徐宗根 on 2018/5/5.
//  Copyright © 2018年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGClipEdgeSpaceDefine.h"

UIKIT_EXTERN CGFloat const ZGEdgeLineViewWidth;
UIKIT_EXTERN CGFloat const ZGEdgeLineViewHeight;


typedef NS_ENUM(NSInteger,ZGEdgeLineViewType) {
    ZGEdgeLineViewTypeHorizontal,
    ZGEdgeLineViewTypeVertical,
};
@interface ZGEdgeLineView : UIView

- (instancetype)initWithType:(ZGEdgeLineViewType)type frame:(CGRect)frame;

@end
