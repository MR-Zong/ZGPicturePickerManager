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

CGFloat const ZGCornerViewLineSpace = 2;
// 注意，是不包含 ZGCornerViewLineSpace 的长度
CGFloat const ZGCornerViewLineLength = 10;
CGFloat const ZGCornerViewWidth = ZGClipEdgeUserInteractiveSpaceUnit * 3 + ZGCornerViewLineSpace;
CGFloat const ZGCornerViewHeight = ZGCornerViewWidth;


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
            _hView = [[UIView alloc] initWithFrame:CGRectMake(unit -space, unit-space, len+space, space)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(unit -space, unit, space, len)];
            
        }else if (type == ZGCornerViewTypeBottomLeft) {
            
            _hView = [[UIView alloc] initWithFrame:CGRectMake(unit-space, height - unit, len+space, space)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(unit-space, _hView.frame.origin.y - len, space, len)];
            
        }else if (type == ZGCornerViewTypeTopRight) {
            
            _hView = [[UIView alloc] initWithFrame:CGRectMake(width - unit - len, unit - space, len+space, space)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(width - unit, unit, space, len)];
            
        }else if (type == ZGCornerViewTypeBottomRight) {
            
            _hView = [[UIView alloc] initWithFrame:CGRectMake(width - unit - len, height - unit, len+space, space)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(width - unit, _hView.frame.origin.y - len, space, len )];
            
        }
        
        _hView.backgroundColor = [UIColor whiteColor];
        _vView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_hView];
        [self addSubview:_vView];
    }
    return self;
}
@end
