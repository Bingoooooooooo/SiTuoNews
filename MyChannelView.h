//
//  MyChannelView.h
//  SituoNews
//
//  Created by hwwp on 15-3-24.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MY_CLASSBUTTON [NSMutableArray arrayWithArray:([[NSUserDefaults standardUserDefaults] objectForKey:@"kMyClass"])]
#define OPTIONAL_CLASSBUTTON [NSMutableArray arrayWithArray:([[NSUserDefaults standardUserDefaults] objectForKey:@"kNoMyClass"])]

#define NOMALKEY   @"normalKey"
#define HEIGHTKEY  @"helightKey"
#define TITLEKEY   @"titleKey"
#define TITLEWIDTH @"titleWidth"
#define TOTALWIDTH @"totalWidth"
#define CATID      @"catid"

@interface MyChannelView : UIView
{
    UILabel *_optionalLabel;          //可添加类别的label
    

}

@property (nonatomic, strong) NSMutableArray *myClassArr;          //我的类别

@property (nonatomic, strong) NSMutableArray *optionalClassArr;    //可添加的类别

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame buttonInfo:(NSArray *)array;

#pragma mark - 布局可添加的类别按钮
- (void)showOptionalClassButtonWithButtonArr:(NSMutableArray *)array;

#pragma mark - 布局已订阅的类别按钮
- (void)showMyClassButtonWithButtonArr:(NSMutableArray *)array;

@end
