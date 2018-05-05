//
//  ZGEdgeLineView.m
//  ZGPicturePickerManager
//
//  Created by 徐宗根 on 2018/5/5.
//  Copyright © 2018年 Zong. All rights reserved.
//

#import "ZGEdgeLineView.h"

CGFloat const ZGEdgeLineHeight = 1;
CGFloat const ZGEdgeLineViewUserInteractiveSpaceUnit = 10.0;
CGFloat const ZGEdgeLineViewWidth = 2*ZGEdgeLineViewUserInteractiveSpaceUnit + 1;
CGFloat const ZGEdgeLineViewHeight = ZGEdgeLineViewWidth;

@interface ZGEdgeLineView ()

@property (nonatomic, strong) UIView *lineView;

@end


@implementation ZGEdgeLineView

- (instancetype)initWithType:(ZGEdgeLineViewType)type frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        if (type == ZGEdgeLineViewTypeHorizontal) {
            
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ZGEdgeLineViewUserInteractiveSpaceUnit, self.bounds.size.width, ZGEdgeLineHeight)];
        }else {
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(ZGEdgeLineViewUserInteractiveSpaceUnit, 0, 1, self.bounds.size.height)];
        }
        _lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_lineView];

    }
    return self;
}

@end
