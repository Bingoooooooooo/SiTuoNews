//
//  MyChannelView.m
//  SituoNews
//
//  Created by hwwp on 15-3-24.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "MyChannelView.h"

@implementation MyChannelView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame buttonInfo:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //数组的初始化
        _myClassArr = [NSMutableArray arrayWithArray:array];
        _optionalClassArr = [NSMutableArray array];
        
        [self initViews];
        
        [self createMyClassButtonWithButtonInfo:_myClassArr];
    }
    return self;
}

- (void)initViews
{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:20];
    label1.text = @"我的频道";
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.right, 13, 120, 20)];
    label2.textColor = [UIColor grayColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:12];
    label2.text = @"可拖动排序和删除";
    [self addSubview:label2];
    
    _optionalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, kScreenWidth, 25)];
    _optionalLabel.backgroundColor = [UIColor lightGrayColor];
    _optionalLabel.textColor = [UIColor blackColor];
    _optionalLabel.textAlignment = NSTextAlignmentCenter;
    _optionalLabel.font = [UIFont systemFontOfSize:16];
    _optionalLabel.text = @"点击添加更多栏目";
    [self addSubview:_optionalLabel];
}

#pragma mark - 创建我的类别按钮
- (void)createMyClassButtonWithButtonInfo:(NSArray *)array
{
    CGFloat btnWidth = (kScreenWidth - 80) / 3;
    for (int i = 0; i < array.count; i++) {
        
        // button的属性
        NSDictionary *dic = array[i];
        NSString *normalImageStr = [dic objectForKey:NOMALKEY];
        NSString *heligtImageStr = [dic objectForKey:HEIGHTKEY];
        NSString *titleStr = [dic objectForKey:TITLEKEY];
        NSString *catid = [dic objectForKey:CATID];
        
        UIButton *classButton = [UIButton buttonWithType:UIButtonTypeCustom];
        classButton.frame = CGRectMake((btnWidth + 20) * (i % 3) + 20, (i / 3) * (30 + 10) + 40 + 10, btnWidth, 30);
        // 属性
        [classButton setBackgroundImage:[UIImage imageNamed:normalImageStr] forState:UIControlStateNormal];
        [classButton setBackgroundImage:[UIImage imageNamed:heligtImageStr] forState:UIControlStateHighlighted];
        [classButton setTitle:titleStr forState:UIControlStateNormal];
        [classButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [classButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [classButton addTarget:self action:@selector(classButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        classButton.layer.cornerRadius = 5;
        classButton.tag = [catid intValue] + 100;
        
        // 添加长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
        [classButton addGestureRecognizer:longPress];
        
        [self addSubview:classButton];

    }
}

#pragma mark - 类别按钮的点击方法
- (void)classButtonClicked:(UIButton *)button
{
    NSMutableArray *myClassArr = [NSMutableArray array];
    NSMutableArray *optionalClassArr = [NSMutableArray array];
    if (MY_CLASSBUTTON.count == 0) {
        myClassArr = _myClassArr;
        
    }else {
        myClassArr = MY_CLASSBUTTON;
        
    }
    
    if (OPTIONAL_CLASSBUTTON.count == 0) {
        optionalClassArr = _optionalClassArr;
        
    }else {
        optionalClassArr = OPTIONAL_CLASSBUTTON;
    }
    
    //判断是已经订阅的类别还是可选的类别
    if (button.bottom < _optionalLabel.top) {
        //保留信息
        NSDictionary *infoDic = nil;
        
        if (myClassArr.count == 1) {
            return;
        }
        
        //(1)从我的订阅中删除
        for (NSDictionary *dic in myClassArr) {
            int catid = [[dic objectForKey:CATID] intValue];
            if (button.tag - 100 == catid) {
                //保留信息
                infoDic = dic;
                [myClassArr removeObject:dic];
                break;
            }
        }
        
        //本地化保存我的栏目
        [[NSUserDefaults standardUserDefaults] setObject:myClassArr forKey:kMyClass];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        
        //(2)添加到可订阅的类别中
        NSLog(@"op : %d",[optionalClassArr isKindOfClass:[NSMutableArray class]]);
        [optionalClassArr addObject:infoDic];
        
        //本地化保存可订阅的栏目
        [[NSUserDefaults standardUserDefaults] setObject:optionalClassArr forKey:kNoMyClass];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //(3)移动button的位置
        [self showOptionalClassButtonWithButtonArr:optionalClassArr];
        
        //(4)从新布局已订阅的按钮
        [self showMyClassButtonWithButtonArr:myClassArr];
        
    }else {
        //保留信息
        NSDictionary *infoDic = nil;
        //(1)从可订阅中删除
        for (NSDictionary *dic in optionalClassArr) {
            int catid = [[dic objectForKey:CATID] intValue];
            if (button.tag - 100 == catid) {
                //保留信息
                infoDic = dic;
                [optionalClassArr removeObject:dic];
                break;
            }
        }
        //本地化保存可订阅的栏目
        [[NSUserDefaults standardUserDefaults] setObject:optionalClassArr forKey:kNoMyClass];
        [[NSUserDefaults standardUserDefaults] synchronize];

        //(2)添加到我的类别中
        [myClassArr addObject:infoDic];
        
        //本地化保存我的栏目
        [[NSUserDefaults standardUserDefaults] setObject:myClassArr forKey:kMyClass];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //(3)移动button的位置
        [self showMyClassButtonWithButtonArr:myClassArr];
        
        //(4)从新布局可订阅的按钮
        [self showOptionalClassButtonWithButtonArr:optionalClassArr];
        
    }
}

#pragma mark - 长按手势
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)longPress
{
    
}

#pragma mark - 布局可添加的类别按钮
- (void)showOptionalClassButtonWithButtonArr:(NSMutableArray *)array
{
    CGFloat btnWidth = (kScreenWidth - 80) / 3;
    for (int i = 0; i < array.count; i++) {
        // button的属性
        NSDictionary *dic = array[i];
        int catid = [[dic objectForKey:CATID] intValue];
        //根据tag值取到button
        UIButton *classBtn = (UIButton *)[self viewWithTag:catid + 100];
        [self showCenterLabel];
        [UIView animateWithDuration:.2 animations:^{
            
            classBtn.frame = CGRectMake((i % 3) * (btnWidth + 20) + 20, (i / 3) * (30 + 10) + _optionalLabel.bottom + 10, btnWidth, 30);
        }];
    }
}

#pragma mark - 布局已订阅的类别按钮
- (void)showMyClassButtonWithButtonArr:(NSMutableArray *)array
{
    CGFloat btnWidth = (kScreenWidth - 80) / 3;
    for (int i = 0; i < array.count; i++) {
        // button的属性
        NSDictionary *dic = array[i];
        int catid = [[dic objectForKey:CATID] intValue];
        //根据tag值取到button
        UIButton *classBtn = (UIButton *)[self viewWithTag:catid + 100];
        [self showCenterLabel];
        [UIView animateWithDuration:.2 animations:^{
            
            classBtn.frame =CGRectMake((btnWidth + 20) * (i % 3) + 20, (i / 3) * (30 + 10) + 40 + 10, btnWidth, 30);
        }];
    }

}

#pragma mark - 布局中间的label
- (void)showCenterLabel
{
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:kMyClass];
    if (array.count <= 3) {
            [UIView animateWithDuration:.2 animations:^{
    
                _optionalLabel.frame = CGRectMake(0, 90, kScreenWidth, 25);
            }];
    
        }else if (array.count <= 6) {
            [UIView animateWithDuration:.2 animations:^{
    
                _optionalLabel.frame = CGRectMake(0, 130, kScreenWidth, 25);
            }];
    
        }else {
            [UIView animateWithDuration:.2 animations:^{
    
                _optionalLabel.frame = CGRectMake(0, 170, kScreenWidth, 25);
            }];
        }
}

@end


