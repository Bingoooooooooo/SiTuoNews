//
//  BaseViewController.m
//  SituoNews
//
//  Created by hwwp on 15-3-21.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* (1)导航栏 */
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.055 green:0.473 blue:0.998 alpha:1.000];
    self.navigationController.navigationBar.translucent = NO;
}

// 自定义导航栏
- (void)_customNavigationItemButton
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(showLeftVC:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setImage:[UIImage imageNamed:@"top_app_btn"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(showRightVC:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

}

// 自定义返回按钮
- (void)_customNavigationBackButton
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setImage:[UIImage imageNamed:@"item_cancel"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

#pragma mark - 设置标题
- (void)setTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - 返回按钮
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 导航栏按钮的方法
- (void)showLeftVC:(UIButton *)sender
{
    if (!sender.selected) {
        
        [[LRSliderViewController sharedSliderViewController] showLeftViewController];
        
    }else {
        
        [[LRSliderViewController sharedSliderViewController] showMainViewController];
    }
    
    sender.selected = !sender.selected;
}

- (void)showRightVC:(UIButton *)sender
{
    if (!sender.selected) {
        
        [[LRSliderViewController sharedSliderViewController] showRightViewController];
        
    }else {
        
        [[LRSliderViewController sharedSliderViewController] showMainViewController];
    }
    
    sender.selected = !sender.selected;
    
}

@end
