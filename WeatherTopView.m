//
//  WeatherTopView.m
//  SituoNews
//
//  Created by huanhuan on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "WeatherTopView.h"
@implementation WeatherTopView


- (void)setWeatherModel:(WeatherModel *)weatherModel {
  
    if (_weatherModel != weatherModel) {
        
        _weatherModel = weatherModel;
     
        NSDate *myDate = [NSDate date];
        NSString *dateString = [NSString stringWithFormat:@"%@",myDate];
        NSString *monthString = [dateString substringWithRange:NSMakeRange(5, 2)];
        NSString *dayString = [dateString substringWithRange:NSMakeRange(8, 2)];
        self.dayLabel.text         = [NSString stringWithFormat:@"%@/%@",monthString,dayString];
        NSString *week = [_weatherModel.week substringWithRange:NSMakeRange(2, 1)];
        self.weekLabel.text        = [NSString stringWithFormat:@"周%@",week];
        self.weatherImgView.image  = [UIImage imageNamed:_weatherModel.img1];
        self.monthLabel.text       = _weatherModel.date_l;
        self.temperatureLabel.text = _weatherModel.temp1;
        self.weatherLabel.text     = _weatherModel.weather1;
    }
    
}


@end
