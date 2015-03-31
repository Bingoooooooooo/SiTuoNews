//
//  ScrollPageView.m
//  SituoNews
//
//  Created by hwwp on 15-3-23.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "ScrollPageView.h"
#import "NewsTableView.h"

@implementation ScrollPageView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        needUseDelegate = YES;
        // 初始化
        [self comInit];
    }
    return self;
}

- (void)comInit
{
    if (_contentItems == nil) {
        _contentItems = [NSMutableArray array];
    }

    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    [self addSubview:_scrollView];
}

#pragma mark - 添加ScrollowViewd的ContentVie
-(void)setContentOfTables:(NSInteger)aNumerOfTables
{
    for (UIView *subview in _scrollView.subviews) {
        if ([subview isKindOfClass:[NewsTableView class]]) {
            [subview removeFromSuperview];
        }
    }
    
    [_contentItems removeAllObjects];
    
    for (int i = 0; i < aNumerOfTables; i++) {
        // 循环创建表视图
        NewsTableView *newsTable = [[NewsTableView alloc] initWithFrame:CGRectMake(i * self.width, 0, self.width, self.height) style:UITableViewStyleGrouped];
        [_scrollView addSubview:newsTable];
        [_contentItems addObject:newsTable];
    }
    _scrollView.contentSize = CGSizeMake(self.width * aNumerOfTables, self.height);
}

#pragma mark 滑动到某个页面
-(void)moveScrollowViewAthIndex:(NSInteger)aIndex
{
    needUseDelegate = NO;
    
    CGRect moveRect = CGRectMake(self.width * aIndex, 0, self.width, self.height);
    // 让scrollView滑动到指定的位置
    [_scrollView scrollRectToVisible:moveRect animated:YES];
    // 当前的页码
    currentPage = aIndex;
}

#pragma mark 刷新某个页面
-(void)freshContentTableAtIndex:(NSInteger)aIndex
{
    // 容错
    if (_contentItems.count < aIndex) {
        return;
    }
    // 刷新表视图
//    NewsTableView *newsTable = _contentItems[aIndex];
//    newsTable
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    needUseDelegate = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = _scrollView.contentOffset.x / kScreenWidth;
    if (currentPage == page) {
        return;
    }
    currentPage = page;
    
    if ([_delegate respondsToSelector:@selector(didScrollPageViewChangedPage:)] && needUseDelegate) {
        [_delegate didScrollPageViewChangedPage:currentPage];
    }
}

#pragma mark - 重写代理的set方法，把代理给tableView
- (void)setDelegate:(id<ScrollPageViewDelegate>)delegate
{
    if (_delegate != delegate) {
        _delegate = delegate;
        
        // 把代理对象(CenterViewController)给tableView
        for (NewsTableView *tableView in _contentItems) {
            tableView.refreshDelegate = _delegate;   
        }
    }
}


@end









