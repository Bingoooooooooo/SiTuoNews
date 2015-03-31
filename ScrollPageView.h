//
//  ScrollPageView.h
//  SituoNews
//
//  Created by hwwp on 15-3-23.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollPageViewDelegate <NSObject>

- (void)didScrollPageViewChangedPage:(NSInteger)page; // 滑动scrollView的代理方法

/**
 *  上拉下拉刷新表视图
 *
 *  @param page 请求的参数。page。
 */
- (void)refreshDataWithPage:(NSInteger)page; 

@end

@interface ScrollPageView : UIView <UIScrollViewDelegate>
{
    NSUInteger currentPage;
    BOOL needUseDelegate; // 标识。是否使用代理(当点击button的时候不用使用代理)
}

//代理
@property (nonatomic, weak) id<ScrollPageViewDelegate> delegate;
//滑动视图
@property (nonatomic, strong) UIScrollView *scrollView;
//内容(表视图)
@property (nonatomic, strong) NSMutableArray *contentItems;

#pragma mark - 添加ScrollowViewd的ContentVie
-(void)setContentOfTables:(NSInteger)aNumerOfTables;

#pragma mark 滑动到某个页面
-(void)moveScrollowViewAthIndex:(NSInteger)aIndex;

#pragma mark 刷新某个页面
-(void)freshContentTableAtIndex:(NSInteger)aIndex;

@end



