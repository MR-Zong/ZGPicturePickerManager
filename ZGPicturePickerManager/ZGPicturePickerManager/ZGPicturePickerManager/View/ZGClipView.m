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
    if (self = [super initWithFrame:CGRectInset(clipTargetFrame, -ZGClipEdgeUserInteractiveSpaceUnit, -ZGClipEdgeUserInteractiveSpaceUnit)]) {
        
        CGFloat unit = ZGClipEdgeUserInteractiveSpaceUnit;
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        
        // edge line
        _topELine = [[ZGEdgeLineView alloc] initWithType:ZGEdgeLineViewTypeHorizontal frame:CGRectMake(unit, 0, width - 2*unit, ZGEdgeLineViewHeight)];
        UIPanGestureRecognizer *telPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didTelPan:)];
        [_topELine addGestureRecognizer:telPan];
        [self addSubview:_topELine];
        
        _leftELine = [[ZGEdgeLineView alloc] initWithType:ZGEdgeLineViewTypeVertical frame:CGRectMake(0, unit, ZGEdgeLineViewWidth, height - 2*unit)];
        UIPanGestureRecognizer *lelPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didLelPan:)];
        [_leftELine addGestureRecognizer:lelPan];
        [self addSubview:_leftELine];
        
        _bottomELine = [[ZGEdgeLineView alloc] initWithType:ZGEdgeLineViewTypeHorizontal frame:CGRectMake(unit, height - ZGEdgeLineViewHeight, width - 2*unit, ZGEdgeLineViewHeight)];
        UIPanGestureRecognizer *belPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didBelPan:)];
        [_bottomELine addGestureRecognizer:belPan];
        [self addSubview:_bottomELine];
        
        _rightELine = [[ZGEdgeLineView alloc] initWithType:ZGEdgeLineViewTypeVertical frame:CGRectMake(width - ZGEdgeLineViewWidth, unit, ZGEdgeLineViewWidth, height - 2*unit)];
        UIPanGestureRecognizer *relPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didRelPan:)];
        [_rightELine addGestureRecognizer:relPan];
        [self addSubview:_rightELine];
        
        
        // corner view
        _tlCornerView = [[ZGCornerView alloc] initWithType:ZGCornerViewTypeTopLeft frame:CGRectMake(0 , 0, ZGCornerViewWidth, ZGCornerViewHeight)];
        UIPanGestureRecognizer *tlCornerPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didTlCornerViewPan:)];
        [_tlCornerView addGestureRecognizer:tlCornerPan];
        [self addSubview:_tlCornerView];
        
        _blCornerView = [[ZGCornerView alloc] initWithType:ZGCornerViewTypeBottomLeft frame:CGRectMake(0, height - ZGCornerViewHeight, ZGCornerViewWidth, ZGCornerViewHeight)];
        UIPanGestureRecognizer *blCornerPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didBlCornerViewPan:)];
        [_blCornerView addGestureRecognizer:blCornerPan];
        [self addSubview:_blCornerView];
        
        _trCornerView = [[ZGCornerView alloc] initWithType:ZGCornerViewTypeTopRight frame:CGRectMake(width - ZGCornerViewWidth, 0, ZGCornerViewWidth, ZGCornerViewHeight)];
        UIPanGestureRecognizer *tRCornerPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didTrCornerViewPan:)];
        [_trCornerView addGestureRecognizer:tRCornerPan];
        [self addSubview:_trCornerView];
        
        _brCornerView = [[ZGCornerView alloc] initWithType:ZGCornerViewTypeBottomRight frame:CGRectMake(width - ZGCornerViewWidth, height - ZGCornerViewHeight, ZGCornerViewWidth, ZGCornerViewHeight)];
        UIPanGestureRecognizer *brCornerPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didBrCornerViewPan:)];
        [_brCornerView addGestureRecognizer:brCornerPan];
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


- (void)updateSubviewsFrame
{
    CGFloat unit = ZGClipEdgeUserInteractiveSpaceUnit;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    // edge line
    _topELine.frame = CGRectMake(unit, 0, width - 2*unit, ZGEdgeLineViewHeight);
    
    _leftELine.frame = CGRectMake(0, unit, ZGEdgeLineViewWidth, height - 2*unit);
    
    _bottomELine.frame = CGRectMake(unit, height - ZGEdgeLineViewHeight, width - 2*unit, ZGEdgeLineViewHeight);
    
    _rightELine.frame = CGRectMake(width - ZGEdgeLineViewWidth, unit, ZGEdgeLineViewWidth, height - 2*unit);
    
    
    // corner view
    _tlCornerView.frame = CGRectMake(0 , 0, ZGCornerViewWidth, ZGCornerViewHeight);
    
    _blCornerView.frame = CGRectMake(0, height - ZGCornerViewHeight, ZGCornerViewWidth, ZGCornerViewHeight);
    
    _trCornerView.frame = CGRectMake(width - ZGCornerViewWidth, 0, ZGCornerViewWidth, ZGCornerViewHeight);
    
    _brCornerView.frame = CGRectMake(width - ZGCornerViewWidth, height - ZGCornerViewHeight, ZGCornerViewWidth, ZGCornerViewHeight);
    
    // indicate line
    _vLine1.frame = CGRectMake(width / 3.0, unit, 0.5, height - 2*unit);
    
    _vLine2.frame = CGRectMake(width*(2 / 3.0), unit, 0.5, height - 2*unit);
    
    
    _hLine1.frame = CGRectMake(unit, height / 3.0, width - 2*unit, 0.5);
    
    _hLine2.frame = CGRectMake(unit, height* (2 / 3.0), width - 2*unit, 0.5);
    
}

#pragma mark Gesture
// topEdgeLine
- (void)didTelPan:(UIPanGestureRecognizer *)pan
{
    CGPoint translate = [pan translationInView:self];
//    NSLog(@"translate %@",NSStringFromCGPoint(translate));
    if (pan.state == UIGestureRecognizerStateBegan) {
        
//        CGRect tmpFrame = self.frame;
//        tmpFrame.origin.y += translate.y;
//        tmpFrame.size.height -= translate.y;
//        self.frame = tmpFrame;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGRect tmpFrame = self.frame;
        tmpFrame.origin.y += translate.y;
        tmpFrame.size.height -= translate.y;
        self.frame = tmpFrame;
        
        [self updateSubviewsFrame];
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }

    }else if(pan.state == UIGestureRecognizerStateCancelled){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

// leftEdgeLine
- (void)didLelPan:(UIPanGestureRecognizer *)pan
{
    CGPoint translate = [pan translationInView:self];
    //    NSLog(@"translate %@",NSStringFromCGPoint(translate));
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //        CGRect tmpFrame = self.frame;
        //        tmpFrame.origin.y += translate.y;
        //        tmpFrame.size.height -= translate.y;
        //        self.frame = tmpFrame;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGRect tmpFrame = self.frame;
        tmpFrame.origin.x += translate.x;
        tmpFrame.size.width -= translate.x;
        self.frame = tmpFrame;
        
        [self updateSubviewsFrame];
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
        
    }else if(pan.state == UIGestureRecognizerStateCancelled){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

// bottomEdgeLine
- (void)didBelPan:(UIPanGestureRecognizer *)pan
{
    CGPoint translate = [pan translationInView:self];
    //    NSLog(@"translate %@",NSStringFromCGPoint(translate));
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //        CGRect tmpFrame = self.frame;
        //        tmpFrame.origin.y += translate.y;
        //        tmpFrame.size.height -= translate.y;
        //        self.frame = tmpFrame;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGRect tmpFrame = self.frame;
        tmpFrame.size.height += translate.y;
        self.frame = tmpFrame;
        
        [self updateSubviewsFrame];
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
        
    }else if(pan.state == UIGestureRecognizerStateCancelled){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

// rightEdgeLine
- (void)didRelPan:(UIPanGestureRecognizer *)pan
{
    CGPoint translate = [pan translationInView:self];
    //    NSLog(@"translate %@",NSStringFromCGPoint(translate));
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //        CGRect tmpFrame = self.frame;
        //        tmpFrame.origin.y += translate.y;
        //        tmpFrame.size.height -= translate.y;
        //        self.frame = tmpFrame;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGRect tmpFrame = self.frame;
        tmpFrame.size.width += translate.x;
        self.frame = tmpFrame;
        
        [self updateSubviewsFrame];
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
        
    }else if(pan.state == UIGestureRecognizerStateCancelled){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

#pragma mark - pan cornerView
// tlCornerView
- (void)didTlCornerViewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint translate = [pan translationInView:self];
    //    NSLog(@"translate %@",NSStringFromCGPoint(translate));
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //        CGRect tmpFrame = self.frame;
        //        tmpFrame.origin.y += translate.y;
        //        tmpFrame.size.height -= translate.y;
        //        self.frame = tmpFrame;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGRect tmpFrame = self.frame;
        tmpFrame.origin.x += translate.x;
        tmpFrame.origin.y += translate.y;
        tmpFrame.size.width -= translate.x;
        tmpFrame.size.height -= translate.y;
        self.frame = tmpFrame;
        
        [self updateSubviewsFrame];
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
        
    }else if(pan.state == UIGestureRecognizerStateCancelled){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

// BlCornerViewPan
- (void)didBlCornerViewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint translate = [pan translationInView:self];
    //    NSLog(@"translate %@",NSStringFromCGPoint(translate));
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //        CGRect tmpFrame = self.frame;
        //        tmpFrame.origin.y += translate.y;
        //        tmpFrame.size.height -= translate.y;
        //        self.frame = tmpFrame;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGRect tmpFrame = self.frame;
        tmpFrame.origin.x += translate.x;
        tmpFrame.size.width -= translate.x;
        tmpFrame.size.height += translate.y;
        self.frame = tmpFrame;
        
        [self updateSubviewsFrame];
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
        
    }else if(pan.state == UIGestureRecognizerStateCancelled){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

// TRCornerViewPan
- (void)didTrCornerViewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint translate = [pan translationInView:self];
    //    NSLog(@"translate %@",NSStringFromCGPoint(translate));
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //        CGRect tmpFrame = self.frame;
        //        tmpFrame.origin.y += translate.y;
        //        tmpFrame.size.height -= translate.y;
        //        self.frame = tmpFrame;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGRect tmpFrame = self.frame;
        tmpFrame.origin.y += translate.y;
        tmpFrame.size.width += translate.x;
        tmpFrame.size.height -= translate.y;
        self.frame = tmpFrame;
        
        [self updateSubviewsFrame];
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
        
    }else if(pan.state == UIGestureRecognizerStateCancelled){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

// BRCornerViewPan
- (void)didBrCornerViewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint translate = [pan translationInView:self];
    //    NSLog(@"translate %@",NSStringFromCGPoint(translate));
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //        CGRect tmpFrame = self.frame;
        //        tmpFrame.origin.y += translate.y;
        //        tmpFrame.size.height -= translate.y;
        //        self.frame = tmpFrame;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGRect tmpFrame = self.frame;
        tmpFrame.size.width += translate.x;
        tmpFrame.size.height += translate.y;
        self.frame = tmpFrame;
        [self updateSubviewsFrame];
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
        
    }else if(pan.state == UIGestureRecognizerStateCancelled){
        if (self.delegate && [self.delegate respondsToSelector:@selector(clipView:didPanEndWithClipViewRect:)]) {
            [self.delegate clipView:self didPanEndWithClipViewRect:self.frame];
        }
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}



#pragma mark - hittest
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *v = [super hitTest:point withEvent:event];
    if (v == self) {
        return nil;
    }else {
        return v;
    }
}


@end
