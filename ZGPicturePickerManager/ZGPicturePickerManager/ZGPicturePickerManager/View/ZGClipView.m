//
//  ZGClipView.m
//  ZGPicturePickerManager
//
//  Created by 徐宗根 on 2018/5/5.
//  Copyright © 2018年 Zong. All rights reserved.
//

#import "ZGClipView.h"
#import "ZGCornerView.h"

@interface ZGClipView ()

// edge line
@property (nonatomic, strong) ZGEdgeLineView *topELine;
@property (nonatomic, strong) ZGEdgeLineView *leftELine;
@property (nonatomic, strong) ZGEdgeLineView *bottomELine;
@property (nonatomic, strong) ZGEdgeLineView *rightELine;

// corner view
@property (nonatomic, strong) ZGCornerView *tlCornerView; // 左上
@property (nonatomic, strong) ZGCornerView *blCornerView; // 左下
@property (nonatomic, strong) ZGCornerView *trCornerView; // 右上
@property (nonatomic, strong) ZGCornerView *brCornerView; // 右下

// indicate line
@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vLine2;
@property (nonatomic, strong) UIView *hLine1;
@property (nonatomic, strong) UIView *hLine2;



@end




@implementation ZGClipView

- (instancetype)initWithClipTargetFrame:(CGRect)clipTargetFrame
{
    if (self = [super initWithFrame:CGRectInset(clipTargetFrame, -ZGEdgeLineViewUserInteractiveSpaceUnit, -ZGEdgeLineViewUserInteractiveSpaceUnit)]) {
        
        CGFloat unit = ZGEdgeLineViewUserInteractiveSpaceUnit;
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        
        // edge line
        _topELine = [[ZGEdgeLineView alloc] initWithType:ZGEdgeLineViewTypeHorizontal frame:CGRectMake(unit, 0, width - 2*unit, ZGEdgeLineViewHeight)];
        [self addSubview:_topELine];
        
        _leftELine = [[ZGEdgeLineView alloc] initWithType:ZGEdgeLineViewTypeVertical frame:CGRectMake(0, unit, ZGEdgeLineViewWidth, height - 2*unit)];
        [self addSubview:_leftELine];
        
        _bottomELine = [[ZGEdgeLineView alloc] initWithType:ZGEdgeLineViewTypeHorizontal frame:CGRectMake(unit, height - ZGEdgeLineViewHeight, width - 2*unit, ZGEdgeLineViewHeight)];
        [self addSubview:_bottomELine];
        
        _rightELine = [[ZGEdgeLineView alloc] initWithType:ZGEdgeLineViewTypeVertical frame:CGRectMake(width - ZGEdgeLineViewWidth, unit, ZGEdgeLineViewWidth, height - 2*unit)];
        [self addSubview:_rightELine];
        
        
        // corner view
        CGFloat space = ZGCornerViewLineSpace;
        _tlCornerView = [[ZGCornerView alloc] initWithType:ZGCornerViewTypeTopLeft frame:CGRectMake(unit - space , unit - space, ZGCornerViewWidth, ZGCornerViewHeight)];
        [self addSubview:_tlCornerView];
        
        _blCornerView = [[ZGCornerView alloc] initWithType:ZGCornerViewTypeBottomLeft frame:CGRectMake(unit - space, height - ZGCornerViewHeight - unit + space, ZGCornerViewWidth, ZGCornerViewHeight)];
        [self addSubview:_blCornerView];
        
        _trCornerView = [[ZGCornerView alloc] initWithType:ZGCornerViewTypeTopRight frame:CGRectMake(width - ZGCornerViewWidth - unit + space, unit - space, ZGCornerViewWidth, ZGCornerViewHeight)];
        [self addSubview:_trCornerView];
        
        _brCornerView = [[ZGCornerView alloc] initWithType:ZGCornerViewTypeBottomRight frame:CGRectMake(width - ZGCornerViewWidth - unit + space, height - ZGCornerViewHeight - unit + space, ZGCornerViewWidth, ZGCornerViewHeight)];
        [self addSubview:_brCornerView];
        
        // indicate line
        _vLine1 = [[UIView alloc] initWithFrame:CGRectMake(width / 3.0, unit, 0.5, height - 2*unit)];
        _vLine1.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vLine1];
        
        _vLine2 = [[UIView alloc] initWithFrame:CGRectMake(width*(2 / 3.0), unit, 0.5, height - 2*unit)];
        _vLine2.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vLine2];
        
        _hLine1 = [[UIView alloc] initWithFrame:CGRectMake(unit, height / 3.0, width - 2*unit, 0.5)];
        _hLine1.backgroundColor = [UIColor whiteColor];
        [self addSubview:_hLine1];
        
        _hLine2 = [[UIView alloc] initWithFrame:CGRectMake(unit, height* (2 / 3.0), width - 2*unit, 0.5)];
        _hLine2.backgroundColor = [UIColor whiteColor];
        [self addSubview:_hLine2];
        
    }
    return self;
}


@end
