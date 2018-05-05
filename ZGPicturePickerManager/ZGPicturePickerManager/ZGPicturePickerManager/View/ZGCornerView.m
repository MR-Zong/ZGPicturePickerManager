//
//  ZGCornerView.m
//  ZGPicturePickerManager
//
//  Created by 徐宗根 on 2018/5/5.
//  Copyright © 2018年 Zong. All rights reserved.
//

#import "ZGCornerView.h"

CGFloat const ZGCornerViewLineSpace = 3;
CGFloat const ZGCornerViewWidth = 20;
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
        
        if (type == ZGCornerViewTypeTopLeft) {
            _hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, ZGCornerViewLineSpace)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(0, ZGCornerViewLineSpace, ZGCornerViewLineSpace, height - ZGCornerViewLineSpace)];
            
        }else if (type == ZGCornerViewTypeBottomLeft) {
            
            _hView = [[UIView alloc] initWithFrame:CGRectMake(0, height - ZGCornerViewLineSpace, width, ZGCornerViewLineSpace)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZGCornerViewLineSpace, height - ZGCornerViewLineSpace)];
            
        }else if (type == ZGCornerViewTypeTopRight) {
            
            _hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, ZGCornerViewLineSpace)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(width - ZGCornerViewLineSpace, 0, ZGCornerViewLineSpace, height - ZGCornerViewLineSpace)];
            
        }else if (type == ZGCornerViewTypeBottomRight) {
            
            _hView = [[UIView alloc] initWithFrame:CGRectMake(0, height - ZGCornerViewLineSpace, width, ZGCornerViewLineSpace)];
            _vView = [[UIView alloc] initWithFrame:CGRectMake(width - ZGCornerViewLineSpace, 0, ZGCornerViewLineSpace, height - ZGCornerViewLineSpace)];
            
        }
        
        _hView.backgroundColor = [UIColor whiteColor];
        _vView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_hView];
        [self addSubview:_vView];
    }
    return self;
}
@end
