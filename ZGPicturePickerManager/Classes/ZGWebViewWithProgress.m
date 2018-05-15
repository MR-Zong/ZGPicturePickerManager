//
//  ZGWebViewWithProgress.m
//  ZGPicturePickerManager
//
//  Created by Zong on 16/2/26.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGWebViewWithProgress.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@implementation ZGWebViewWithProgress
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupNJKWebViewProgress];
    }
    return self;
}


- (void)setupNJKWebViewProgress
{
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
}

- (void)setupNJKWebViewProgressView
{
    CGFloat progressBarHeight = 2.f;
    CGRect barFrame = CGRectMake(0, 0, self.frame.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupNJKWebViewProgressView];
}

@end
