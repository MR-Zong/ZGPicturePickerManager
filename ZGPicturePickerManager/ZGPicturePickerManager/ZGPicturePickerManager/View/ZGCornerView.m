//
//  ZGCornerView.m
//  ZGPicturePickerManager
//
//  Created by 徐宗根 on 2018/5/5.
//  Copyright © 2018年 Zong. All rights reserved.
//

#import "ZGCornerView.h"
#import "ZGEdgeLineView.h"
#import "ZGClipEdgeSpaceDefine.h"

CGFloat const ZGCornerViewLineSpace = 3;
CGFloat const ZGCornerViewWidth = ZGClipEdgeUserInteractiveSpaceUnit * 3 + ZGCornerViewLineSpace;
CGFloat const ZGCornerViewHeight = ZGCornerViewWidth;
CGFloat const ZGCornerViewLineLength = ZGCornerViewWidth - ZGClipEdgeUserInteractiveSpaceUnit + ZGCornerViewLineSpace;


@interface ZGCornerView ()

@property (nonatomic, strong) UIView *hView; // 水平
@property (nonatomic, strong) UIView *vView; // 垂直

@end


@implementation ZGCornerView

- (instancetype)initWithType:(ZGCornerViewType)type frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        
        CGFloat unit = ZGClipEdgeUserInteractiveSpaceUnit;
        CGFloat len = ZGCornerViewLineLength;
        CGFloat space = ZGCornerViewLineSpace;
        
        if (type == ZGCornerViewTypeTopLeft) {
            _hView = [[UIView alloc] initWithFrame:CGRectMake(unit -space, unit-space, len, space)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(unit -space, unit, space, len - space)];
            
        }else if (type == ZGCornerViewTypeBottomLeft) {
            
            _hView = [[UIView alloc] initWithFrame:CGRectMake(unit-space, height - unit, len, space)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(unit-space, 0, space, len -space)];
            
        }else if (type == ZGCornerViewTypeTopRight) {
            
            _hView = [[UIView alloc] initWithFrame:CGRectMake(0, unit - space, len, space)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(width - unit, unit, space, len - space)];
            
        }else if (type == ZGCornerViewTypeBottomRight) {
            
            _hView = [[UIView alloc] initWithFrame:CGRectMake(0, height - unit, len, space)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(width - unit, 0, space, len - space)];
            
        }
        
        _hView.backgroundColor = [UIColor whiteColor];
        _vView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_hView];
        [self addSubview:_vView];
    }
    return self;
}
@end
