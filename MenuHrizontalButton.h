//
//  MenuHrizontalButton.h
//  SituoNews
//
//  Created by hwwp on 15-3-23.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NOMALKEY   @"normalKey"
#define HEIGHTKEY  @"helightKey"
#define TITLEKEY   @"titleKey"
#define TITLEWIDTH @"titleWidth"
#define TOTALWIDTH @"totalWidth"
#define CATID      @"catid"

//点击按钮的协议方法
@protocol MenuHrizontalDelegate <NSObject>

- (void)didMenuHrizontalClickedButtonAtIndex:(NSInteger)page;

@end


@interface MenuHrizontalButton : UIView
{
    NSMutableArray *_buttonArray;
    NSMutableArray *_itemInfoArray;
    UIScrollView   *_scrollView;
    float          mTotalWidth;
}

@property (nonatomic, weak) id<MenuHrizontalDelegate> delegate;

@property (nonatomic, strong) NSArray *itemsArray;

#pragma mark 初始化菜单
//- (id)initWithFrame:(CGRect)frame ButtonItems:(NSArray *)itemsArray;

#pragma mark - 改变第几个button为选中状态
- (void)changeButtonStateAtIndex:(NSInteger)index;

#pragma mark - 选中某个button
- (void)clickButtonAtIndex:(NSInteger)index;


@end


