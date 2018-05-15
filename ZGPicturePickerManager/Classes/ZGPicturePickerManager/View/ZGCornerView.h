//
//  ZGCornerView.h
//  ZGPicturePickerManager
//
//  Created by 徐宗根 on 2018/5/5.
//  Copyright © 2018年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const ZGCornerViewWidth;
UIKIT_EXTERN CGFloat const ZGCornerViewHeight;

typedef NS_ENUM(NSInteger,ZGCornerViewType) {
    ZGCornerViewTypeTopLeft,
    ZGCornerViewTypeBottomLeft,
    ZGCornerViewTypeTopRight,
    ZGCornerViewTypeBottomRight,
};


@interface ZGCornerView : UIView

- (instancetype)initWithType:(ZGCornerViewType)type frame:(CGRect)frame;


@end
