//
//  AppDelegate.m
//  SituoNews
//
//  Created by hwwp on 15-3-21.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "CenterViewController.h"
#import "RightViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    // 左侧的偏移量
    [LRSliderViewController sharedSliderViewController].leftContentOffset = 200;
    [LRSliderViewController sharedSliderViewController].leftContentScale = 0.8;
    
    //右侧的偏移量
    [LRSliderViewController sharedSliderViewController].rightContentOffset = 280;
    [LRSliderViewController sharedSliderViewController].rightContentScale = 0.9;
    
    // 设置控制器
    [LRSliderViewController sharedSliderViewController].leftViewController = [[LeftViewController alloc] init];
    [LRSliderViewController sharedSliderViewController].rightViewController = [[RightViewController alloc] init];
    
    BaseNavigationController *navCtrl = [[BaseNavigationController alloc] initWithRootViewController:[[CenterViewController alloc] init]];
    [LRSliderViewController sharedSliderViewController].centerViewController = navCtrl;
    
    self.window.rootViewController = [LRSliderViewController sharedSliderViewController];
    return YES;
}

@end
