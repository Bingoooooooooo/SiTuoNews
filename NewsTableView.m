//
//  NewsTableView.m
//  SituoNews
//
//  Created by hwwp on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "NewsTableView.h"
#import "NewsCell.h"
#import "OtherTypeNewsCell.h"
#import "ADScrollView.h"
#import "NewsDetailViewController.h"

static NSString *identifier1 = @"identifier1";
static NSString *identifier2 = @"identifier2";

@interface NewsTableView () <UITableViewDataSource, UITableViewDelegate>
{
    NSInteger countPage;
    ADScrollView *_adScrollView;
}
@end

@implementation NewsTableView

#pragma mark - 生命周期
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentInset = UIEdgeInsetsMake(0, 0, 25, 0);
        // 初始化代码
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 90;
        
        // 注册两种cell
        [self registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:identifier1];
        [self registerNib:[UINib nibWithNibName:@"OtherTypeNewsCell" bundle:nil] forCellReuseIdentifier:identifier2];
        
        // 添加下拉刷新和上拉加载更多
        [self addHeaderWithTarget:self action:@selector(loadNewData)];
        [self addFooterWithTarget:self action:@selector(loadMoreData)];
        
        countPage = 1;
        
    }
    return self;
}

#pragma mark - UITableView DataSource
//多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//每组有多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *newsModel = self.dataList[indexPath.row];
    // 根据model中有木有图片取不同的单元格
    if ([newsModel.thumb isEqualToString:@""]) {
        // 没有图片
        OtherTypeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2 forIndexPath:indexPath];
        cell.newsModel = self.dataList[indexPath.row];
        return cell;
        
    }else{
        // 有图片
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1 forIndexPath:indexPath];
        cell.newsModel = self.dataList[indexPath.row];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0;
//}

//单元格选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *newsModel = self.dataList[indexPath.row];
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc] init];
    newsDetailVC.model = newsModel;
    [self.ViewController.navigationController pushViewController:newsDetailVC animated:YES];
}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_adDataList != nil) {
        
        if (_adScrollView == nil) {
            _adScrollView = [[ADScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
            _adScrollView.currentPageIndicatorTintColor = [UIColor redColor];
            _adScrollView.pageIndicatorTintColor = [UIColor grayColor];
        }
        
        NSMutableArray *imageNameArr = [NSMutableArray array];
        NSMutableArray *description_news_s = [NSMutableArray array];
        
        for (NewsModel *adSModel in _adDataList) {
            NSString *thumb = adSModel.thumb;
            NSString *description_news = adSModel.description_news;
            [imageNameArr addObject:thumb];
            [description_news_s addObject:description_news];
        }
        // 把图片的URL给AdScrollView
        _adScrollView.h_ADImages = imageNameArr;
        return _adScrollView;
    }else {
        return nil;
    }
        
//    // 把标题给AdScrollView
//    scrollView.adTitleArray = description_news_s;
//    scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
//    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
//    
//    // 半透明的黑条
//    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0 , 120, kScreenWidth, 30)];
//    bg.backgroundColor = [UIColor colorWithWhite:0.223 alpha:0.700];
//    [self addSubview:bg];
    
//
    
}

//头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_adDataList == nil) {
        return 0.1;
    }else {
        return 150;
    }
}

#pragma mark - 上拉和下拉方法
- (void)loadNewData
{
    //下拉
    if ([_refreshDelegate respondsToSelector:@selector(refreshDataWithPage:)]) {
        [_refreshDelegate refreshDataWithPage:0];
    }
}

- (void)loadMoreData
{
    //上拉
    if ([_refreshDelegate respondsToSelector:@selector(refreshDataWithPage:)]) {
        countPage +=1;
        [_refreshDelegate refreshDataWithPage:countPage];
    }
}

#pragma mark - setter / getter 
- (void)setAdDataList:(NSArray *)adDataList
{
    if(_adDataList != adDataList) {
        _adDataList = adDataList;
    }
}

@end



