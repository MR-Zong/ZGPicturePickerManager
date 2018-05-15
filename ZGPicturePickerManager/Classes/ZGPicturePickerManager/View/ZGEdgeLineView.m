//
//  ZGEdgeLineView.m
//  ZGPicturePickerManager
//
//  Created by 徐宗根 on 2018/5/5.
//  Copyright © 2018年 Zong. All rights reserved.
//

#import "ZGEdgeLineView.h"

CGFloat const ZGEdgeLineHeight = 1.0;
CGFloat const ZGEdgeLineViewWidth = 2*ZGClipEdgeUserInteractiveSpaceUnit + 1;
CGFloat const ZGEdgeLineViewHeight = ZGEdgeLineViewWidth;

@interface ZGEdgeLineView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) ZGEdgeLineViewType type;

@end


@implementation ZGEdgeLineView

- (instancetype)initWithType:(ZGEdgeLineViewType)type frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _type = type;
        
        if (type == ZGEdgeLineViewTypeHorizontal) {
            
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ZGClipEdgeUserInteractiveSpaceUnit, self.bounds.size.width, ZGEdgeLineHeight)];
        }else {
            _lineView = [[UIView alloc] initWithFrame:CGRectMake(ZGClipEdgeUserInteractiveSpaceUnit, 0, 1, self.bounds.size.height)];
        }
        _lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_lineView];

    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (self.type == ZGEdgeLineViewTypeHorizontal) {
        
        _lineView.frame = CGRectMake(0, ZGClipEdgeUserInteractiveSpaceUnit, self.bounds.size.width, ZGEdgeLineHeight);
    }else {
        _lineView.frame = CGRectMake(ZGClipEdgeUserInteractiveSpaceUnit, 0, 1, self.bounds.size.height);
    }
}

@end
