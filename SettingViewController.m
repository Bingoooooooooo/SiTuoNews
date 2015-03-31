//
//  SettingViewController.m
//  SituoNews
//
//  Created by hwwp on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "SettingViewController.h"
#import "SDImageCache.h"
#import "FontViewController.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_titles;
    NSArray *_imageNames;
}

@end

@implementation SettingViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 返回按钮
    [self _customNavigationBackButton];

    self.title = @"设置";

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _loadTableView];
    
    // 数据
    _titles = @[@[@"正文字号",@"离线阅读",@"清除缓存"],
                @[@"意见反馈",@"免责声明", @"关于"]];
    _imageNames = @[@[@"set_zh.png",@"set_lx.png", @"set_qc.png"],
                @[@"set_fk.png",@"set_sm.png", @"set_about.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回按钮
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 私有方法
- (void)_loadTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0, kScreenWidth, kScreenHeight)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}


#pragma mark - UITableView DataSource
//多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titles.count;
}

//每组有多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titles[section] count];
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"set_cell_iden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        if (indexPath.section == 0 && indexPath.row == 2) {
            // 清除缓存
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 110, 11, 100, 20)];
            label.tag = 7788;
            label.textAlignment = NSTextAlignmentRight;
            label.font = [UIFont boldSystemFontOfSize:14];
            label.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label];

        }
    }
    
    // 缓存的大小
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:7788];
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    CGFloat cacheSize = size / 1000;
    label.text = [NSString stringWithFormat:@"缓存%.1fM",cacheSize];
    
    
    cell.textLabel.text = _titles[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_imageNames[indexPath.section][indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
//单元格选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 设置字体
        FontViewController *fontVC = [[FontViewController alloc] init];
        [self.navigationController pushViewController:fontVC animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        //
        
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        // 清除缓存
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"缓存已经清除" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        UILabel *label = (UILabel *)[self.view viewWithTag:7788];
        label.text = [NSString stringWithFormat:@"缓存0M"];

        [[SDImageCache sharedImageCache] cleanDisk];
        
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        //
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        //
    }else if (indexPath.section == 1 && indexPath.row == 2) {
        //
    }
}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

//头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

@end
