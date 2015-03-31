//
//  LRSliderViewController.h
//  LeftAndRightSlider
//
//  Created by hwwp on 15-3-21.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRSliderViewController : UIViewController

@property (nonatomic, strong)UIViewController *leftViewController; //optional
@property (nonatomic, strong)UIViewController *rightViewController; //optional
@property (nonatomic, strong)UIViewController *centerViewController; //required

//left or right Offset
@property(nonatomic,assign)CGFloat leftContentOffset;
@property(nonatomic,assign)CGFloat rightContentOffset;
//left or right scale
@property(nonatomic,assign)CGFloat leftContentScale;
@property(nonatomic,assign)CGFloat rightContentScale;

+ (LRSliderViewController*)sharedSliderViewController;//instantiationWay

- (void)showMainViewController;
- (void)showLeftViewController;
- (void)showRightViewController;

@end
