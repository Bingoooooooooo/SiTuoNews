//
//  RightViewController.m
//  SituoNews
//
//  Created by hwwp on 15-3-21.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "RightViewController.h"
#import "RightCollectionViewCell.h"
#import "QRViewController.h"
#import "WeatherViewController.h"
#import "LRSliderViewController.h"

static NSString *rightVCCollectionViewCellIdentifier = @"rightVCCollectionViewCellIdentifier";
@interface RightViewController ()
{

    XRUnderlineButton *_loadButton;
    UICollectionView *_collectionView;
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleNames = @[@"报料",@"二维码",@"投票",@"调查",@"视频",@"活动",@"直播",@"图片",@"温度猫",@"电子报",@"空气质量",@"测试",@"收藏",@"搜索",@"天气"];
    self.titleImageNames = @[@"app_bl_btn.png",@"app_ewm_btn.png",@"app_tp_btn.png",@"app_dc_btn.png",@"app_sp_btn.png",@"app_hd_btn.png",@"app_zb.png",@"app_tps_btn.png",@"温度猫.png",@"hq.png",@"1399874198736.png",@"测试.jpg",@"收藏.png",@"sousuo.png",@"天气.png"];
    
    [self _initBackImageView];
    [self _creatHeaderView];
    [self _creatCollectionView];
}

#pragma mark - 创建背景视图
- (void)_initBackImageView {
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.image = [UIImage imageNamed:@"newbg@2x.png"];
    [self.view addSubview:imgView];
}

#pragma mark - 创建登录头像
- (void)_creatHeaderView {
    
    UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headerButton.frame = CGRectMake(140, 50, 80, 80);
    [headerButton setImage:[UIImage imageNamed:@"defaultAvatar@2x.png"] forState:UIControlStateNormal];
    [headerButton addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headerButton];
    
    _loadButton = [XRUnderlineButton underlinedButton];
    _loadButton.frame = CGRectMake(140, headerButton.bottom, 80, 30);
    [_loadButton setTitle:@"立即登录" forState:UIControlStateNormal];
    [_loadButton addTarget:self action:@selector(loadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loadButton];
}

#pragma mark - 创建collectionView
- (void)_creatCollectionView {
    
    //设置布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(60, 60);//cell的大小
    layout.sectionInset = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);//上下间隔
    //(3)行内每一个单元格之间最小的距离
    layout.minimumInteritemSpacing = 10;
    //(4)行与行之间最小的距离
    layout.minimumLineSpacing = 10;
    
    //(5)滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建collection视图
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(70.f, _loadButton.bottom + 5, 220, kScreenHeight * 0.9 - _loadButton.bottom - 5) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
    //注册单元格
    [_collectionView registerNib:[UINib nibWithNibName:@"RightCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:rightVCCollectionViewCellIdentifier];


}

#pragma mark - CollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.titleNames.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:rightVCCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.titleName.text = self.titleNames[indexPath.row];
    cell.titleImageView.image = [UIImage imageNamed:self.titleImageNames[indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        NSLog(@"%ld",indexPath.row);
        
    }else if (indexPath.row == 1) {
    
        QRViewController *QRVC = [[QRViewController alloc] init];
        
        [self.view.window.rootViewController presentViewController:QRVC
                                                         animated:YES completion:nil];
        
    }else if (indexPath.row == 2) {
    
        NSLog(@"%ld",indexPath.row);
    }else if (indexPath.row == 3) {
    
        NSLog(@"%ld",indexPath.row);
    
    }else if (indexPath.row == 4) {
    
                NSLog(@"%ld",indexPath.row);
    
    }else if (indexPath.row == 5) {
    
                NSLog(@"%ld",indexPath.row);
    }else if (indexPath.row == 6) {
    
                NSLog(@"%ld",indexPath.row);
    }else if (indexPath.row == 7) {
    
                NSLog(@"%ld",indexPath.row);
    }else if (indexPath.row == 8) {
            NSLog(@"%ld",indexPath.row);
        
    }else if (indexPath.row == 9) {
            NSLog(@"%ld",indexPath.row);
    }else if (indexPath.row == 10) {
            NSLog(@"%ld",indexPath.row);
    }else if (indexPath.row == 11) {
            NSLog(@"%ld",indexPath.row);
    }else if (indexPath.row == 12) {
            NSLog(@"%ld",indexPath.row);
    }else {
        WeatherViewController *weatherVC = [[WeatherViewController alloc] init];
        weatherVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.view.window.rootViewController presentViewController:weatherVC animated:YES completion:nil];
    
    }
    
    
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

}

#pragma mark - 头像点击事件
- (void)headerButtonAction:(UIButton *)sender {
    

}

#pragma mark - 登录点击事件
- (void)loadButtonAction:(UIButton *)sender {



}


@end
