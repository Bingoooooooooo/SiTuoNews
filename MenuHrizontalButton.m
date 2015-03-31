//
//  MenuHrizontalButton.m
//  SituoNews
//
//  Created by hwwp on 15-3-23.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "MenuHrizontalButton.h"

@implementation MenuHrizontalButton

#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (_buttonArray == nil) {
            _buttonArray = [NSMutableArray array];
        }
        
        if (_itemInfoArray == nil) {
            _itemInfoArray = [NSMutableArray array];
        }
        
        if (_scrollView == nil) {
            _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
            _scrollView.showsHorizontalScrollIndicator = NO;
        }
        
        [_itemInfoArray removeAllObjects];
    }
    return self;
}

#pragma mark - 设置按钮
- (void)setItemsArray:(NSArray *)itemsArray
{
    
    if (_itemsArray != itemsArray) {
        _itemsArray = itemsArray;
    }
    [self createMenuItems:_itemsArray];
}

#pragma mark - 创建菜单按钮
- (void)createMenuItems:(NSArray *)itemsArray
{
    int i = 0;
    float menuWidth = 0.0;
    
    for (UIView *subview in [_scrollView subviews]) {
        
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
        }
    }
    
    [_buttonArray removeAllObjects];
    
    for (NSDictionary *dic in itemsArray) {
        
        // button的属性
        NSString *heligtImageStr = [dic objectForKey:HEIGHTKEY];
        NSString *titleStr = [dic objectForKey:TITLEKEY];
        float buttonWidth = [[dic objectForKey:TITLEWIDTH] floatValue];
        
        // 创建button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:heligtImageStr] forState:UIControlStateSelected];
        [button setTitle:titleStr forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button setTag:i];
        [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(menuWidth, 0, buttonWidth, self.height)];
        
        [_scrollView addSubview:button];
        [_buttonArray addObject:button];
        
        menuWidth += buttonWidth;
        i++;
        
        //保存button资源信息，同时增加button.oringin.x的位置，方便点击button时，移动位置。
        NSMutableDictionary *newDic = [dic mutableCopy];
        [newDic setObject:[NSNumber numberWithFloat:menuWidth] forKey:TOTALWIDTH];
        [_itemInfoArray addObject:newDic];
    }
    
    [_scrollView setContentSize:CGSizeMake(menuWidth, self.height)];
    [self addSubview:_scrollView];
    // 保存menu总长度，如果小于320则不需要移动，方便点击button时移动位置的判断
    mTotalWidth = menuWidth;

}

#pragma mark - 选中某个button
- (void)clickButtonAtIndex:(NSInteger)index
{
    UIButton *button = _buttonArray[index];
    [self menuButtonClicked:button];
}

#pragma mark - 点击事件
-(void)menuButtonClicked:(UIButton *)sender
{
    [self changeButtonStateAtIndex:sender.tag];
    
    if ([_delegate respondsToSelector:@selector(didMenuHrizontalClickedButtonAtIndex:)]) {
        [_delegate didMenuHrizontalClickedButtonAtIndex:sender.tag];
    }
}

#pragma mark - 改变第几个button为选中状态
- (void)changeButtonStateAtIndex:(NSInteger)index
{
    UIButton *button = _buttonArray[index];
    [self changeButtonToNormalState];
    button.selected = YES;
    [self moveScrollViewWithIndex:index];
}

#pragma mark - 取消所有button的选中状态
- (void)changeButtonToNormalState
{
    for (UIButton *button in _buttonArray) {
        button.selected = NO;
    }
}

#pragma mark - 移动button到可视区域
- (void)moveScrollViewWithIndex:(NSInteger)index
{
    // 容错
    if (_itemInfoArray.count < index) {
        return;
    }
    
    // 宽度小于屏幕的宽也不需要移动,30为控制按钮的宽度
    if (mTotalWidth < kScreenWidth - 30) {
        return;
    }
    
    NSDictionary *dic = [_itemInfoArray objectAtIndex:index];
    float buttonOrigin = [[dic objectForKey:TOTALWIDTH] floatValue];
    
    if (self.width - buttonOrigin <= 60) {

        [_scrollView setContentOffset:CGPointMake(buttonOrigin - 100, 0)];
        
        if ((_scrollView.contentSize.width - _scrollView.contentOffset.x) - self.width <= 0) {
            [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width - self.width, 0)];
        }
        
    }else {
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        return;
    }
    
}


@end
