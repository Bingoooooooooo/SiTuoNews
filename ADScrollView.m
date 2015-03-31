//
//  ADScrollView.m
//  SituoNews
//
//  Created by hwwp on 15-3-24.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "ADScrollView.h"

#define NSTIMERINTERVAL 2

@interface ADScrollView () <UIScrollViewDelegate>

@end

@implementation ADScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化
        [self comInit];
    }
    return self;
}

- (void)comInit
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.width - 100, self.height - 20, 100, 20)];
        [self addSubview:_pageControl];
    }
}

#pragma mark - setter / getter
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    if (_pageIndicatorTintColor != pageIndicatorTintColor) {
        _pageIndicatorTintColor = pageIndicatorTintColor;
        
        _pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
    }
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    if (_currentPageIndicatorTintColor != currentPageIndicatorTintColor) {
        _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
        
        _pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
    }
}

- (void)setH_ADImages:(NSArray *)h_ADImages
{
    if (_h_ADImages != h_ADImages) {
        _h_ADImages = h_ADImages;
        
        _scrollView.contentSize = CGSizeMake(self.width * (h_ADImages.count + 2), 0);
        _pageControl.numberOfPages = h_ADImages.count;
        
        UIImageView *firstView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height)];
        UIImageView *lastView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * _h_ADImages.count + self.width, 0, self.width, self.height)];
        
        //将滑动视图的偏移量设置到中间
        [_scrollView setContentOffset:CGPointMake(self.width, 0)];
        _count = 0;
        
        [_scrollView addSubview:firstView];
        [_scrollView addSubview:contentView];
        [_scrollView addSubview:lastView];
        
        //添加图片
        for (int i = 0; i < _h_ADImages.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.width, 0, self.width, self.height)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_h_ADImages[i]] placeholderImage:nil];
            [contentView addSubview:imageView];
            
            if (i == 0) {
                [lastView sd_setImageWithURL:[NSURL URLWithString:_h_ADImages[i]] placeholderImage:nil];
            }
            
            if (i == _h_ADImages.count - 1) {
                [firstView sd_setImageWithURL:[NSURL URLWithString:_h_ADImages[i]] placeholderImage:nil];
            }
        }
        
        //创建定时器
        [self createTimer];
    }
}

#pragma mark - 创建定时器
- (void)createTimer
{
    if (_timer != nil) {
        return;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:NSTIMERINTERVAL target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    //NSLog(@"创建定时器");
}

#pragma mark - 定时器方法
- (void)timerAction
{
    _count ++;
    _pageControl.currentPage = _count % _h_ADImages.count;
    _isTimer = YES;
    
    if (_scrollView.contentOffset.x == 0) {
        [_scrollView setContentOffset:CGPointMake(self.width * _h_ADImages.count, 0) animated:NO];
        
    }else if (_scrollView.contentOffset.x == self.width * (_h_ADImages.count + 1)){
        [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
        //NSLog(@"_scrollView.contentOffest.x %f",_scrollView.contentOffset.x);
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + self.width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //销毁定时器
    [_timer invalidate];
    _timer = nil;
    _isTimer = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_isTimer) {
        
        if (_scrollView.contentOffset.x == 0) {
            [_scrollView setContentOffset:CGPointMake(self.width * _h_ADImages.count, 0) animated:NO];
            
        }else if (_scrollView.contentOffset.x == self.width * (_h_ADImages.count + 1)){
            [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
            //NSLog(@"_scrollView.contentOffest.x %f",_scrollView.contentOffset.x);
        }
        //NSLog(@"huadong : %d",(int)(_scrollView.contentOffset.x / _scrollView.width));
        _pageControl.currentPage = (NSInteger)(_scrollView.contentOffset.x / _scrollView.width) % [_h_ADImages count];
        
        _count = _pageControl.currentPage;

    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //创建定时器
    [self createTimer];
}

@end
