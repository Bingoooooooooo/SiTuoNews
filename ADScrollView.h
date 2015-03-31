//
//  ADScrollView.h
//  SituoNews
//
//  Created by hwwp on 15-3-24.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADScrollView : UIView 
{
    UIScrollView    *_scrollView;   //滑动视图
    UIPageControl   *_pageControl;  //页码控制器
    NSTimer         *_timer;        //定时器
    NSInteger       _count;         //定时器执行的次数
    BOOL            _isTimer;       //定时器是否存在
}

@property (nonatomic, strong) NSArray *h_ADImages; //广告图片的数组
@property (nonatomic, strong) UIColor *pageIndicatorTintColor; //页码控制器的颜色
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor; //当前页的颜色

@end
