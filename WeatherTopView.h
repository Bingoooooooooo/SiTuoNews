//
//  WeatherTopView.h
//  SituoNews
//
//  Created by huanhuan on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface WeatherTopView : UIView
@property (nonatomic , strong)WeatherModel *weatherModel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImgView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;




@end
