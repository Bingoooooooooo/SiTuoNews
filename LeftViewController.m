//
//  LeftViewController.m
//  SituoNews
//
//  Created by hwwp on 15-3-21.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "LeftViewController.h"
#import "SettingViewController.h"

@interface LeftViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_titleNames;
    NSArray *_imageNames;
}

@end

@implementation LeftViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景图片
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"newbg"];
    [self.view addSubview:bgView];
    
    // 图片
    _titleNames = @[@"新闻",@"微博",@"图片",@"专题"];
    _imageNames = @[@"guoji.png",@"keji.png",@"bottom_pic_btn_press.png",@"set_sm@2x.png"];
    
    // 表视图
    [self _loadTableView];
    
    // 设置按钮
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(60, _tableView.bottom, 80, 30);
    [setBtn setImage:[UIImage imageNamed:@"navigation_top_bar_setting_btn"] forState:UIControlStateNormal];
    [setBtn setTitle:@"设置" forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(settingPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 私有方法
- (void)_loadTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, kScreenHeight * 0.1, 200, kScreenHeight * 0.8)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableView DataSource
//每组有多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleNames.count;
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"iden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        
        cell.backgroundView = nil;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        // 图片
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(50, 10, 30, 30)];
        image.backgroundColor = [UIColor lightGrayColor];
        image.tag = 102;
        [cell.contentView addSubview:image];
        
        // 文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(image.right + 5, 10, 50, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 103;
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:label];
    }
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:102];
    imageView.image = [UIImage imageNamed:_imageNames[indexPath.row]];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:103];
    label.text = _titleNames[indexPath.row];
    
    return cell;
}

#pragma mark - 设置按钮
- (void)settingPage
{
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    UINavigationController *naviCtrl = [[UINavigationController alloc] initWithRootViewController:settingVC];
    [self.view.window.rootViewController presentViewController:naviCtrl animated:YES completion:nil];
}


@end
