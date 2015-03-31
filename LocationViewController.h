//
//  LocationViewController.h
//  SituoNews
//
//  Created by huanhuan on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "BaseViewController.h"
@class WeatherViewController;
@interface LocationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

{

    UITableView *_tableView;
}

@property (nonatomic, strong) WeatherViewController *weatherVC;
@property (nonatomic, strong) NSArray *citySequence;//城市排序字母
@property (nonatomic, strong) NSArray *dataList;//城市名
@property (nonatomic, strong) NSDictionary *cityIDAndName;//城市名
@property (nonatomic, strong) NSDictionary *cityDictionarys;//城市名
@end
