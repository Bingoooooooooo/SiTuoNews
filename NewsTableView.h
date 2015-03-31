//
//  NewsTableView.h
//  SituoNews
//
//  Created by hwwp on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollPageView.h"

@interface NewsTableView : UITableView

@property (nonatomic, strong) NSArray *adDataList; // 广告视图的数据

@property (nonatomic, strong) NSArray *dataList; // 数据

@property (nonatomic, weak) id<ScrollPageViewDelegate> refreshDelegate;

@end
