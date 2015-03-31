//
//  WeatherViewController.h
//  SituoNews
//
//  Created by huanhuan on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "BaseViewController.h"

@interface WeatherViewController : BaseViewController
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) NSString *weatherID;
@end
