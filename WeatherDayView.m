//
//  WeatherDayView.m
//  SituoNews
//
//  Created by huanhuan on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "WeatherDayView.h"

@implementation WeatherDayView

- (void)setWeatherModel:(WeatherModel *)weatherModel {
    
    if (_weatherModel != weatherModel) {
        _weatherModel = weatherModel;
        
        //星期
        if ([_weatherModel.week isEqualToString:@"星期一"]) {
            
            _secondDay.text = @"周二";
            _thirdDay.text = @"周三";
            _fourthDay.text = @"周四";
            _fifthDay.text = @"周五";
            _sixthDay.text = @"周六";
        }else if ([_weatherModel.week isEqualToString:@"星期二"]) {
            
            _secondDay.text = @"周三";
            _thirdDay.text = @"周四";
            _fourthDay.text = @"周五";
            _fifthDay.text = @"周六";
            _sixthDay.text = @"周日";

            
        }else if ([_weatherModel.week isEqualToString:@"星期三"]) {
            
            _secondDay.text = @"周四";
            _thirdDay.text = @"周五";
            _fourthDay.text = @"周六";
            _fifthDay.text = @"周日";
            _sixthDay.text = @"周一";
            
            
        }else if ([_weatherModel.week isEqualToString:@"星期四"]) {
            
            _secondDay.text = @"周五";
            _thirdDay.text = @"周六";
            _fourthDay.text = @"周日";
            _fifthDay.text = @"周一";
            _sixthDay.text = @"周二";
            
            
        }else if ([_weatherModel.week isEqualToString:@"星期五"]) {
            
            _secondDay.text = @"周六";
            _thirdDay.text = @"周日";
            _fourthDay.text = @"周一";
            _fifthDay.text = @"周二";
            _sixthDay.text = @"周三";
            
            
        }else if ([_weatherModel.week isEqualToString:@"星期六"]) {
            
            _secondDay.text = @"周日";
            _thirdDay.text = @"周一";
            _fourthDay.text = @"周二";
            _fifthDay.text = @"周三";
            _sixthDay.text = @"周四";
            
            
        }else {
            
            _secondDay.text = @"周一";
            _thirdDay.text = @"周二";
            _fourthDay.text = @"周三";
            _fifthDay.text = @"周四";
            _sixthDay.text = @"周五";
            
            
        }
        
        //每天天气情况
        
        //天气图片
        _secondWeatherImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_weatherModel.img3]];
        _thirdWeatherImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_weatherModel.img5]];
        _fourthWeatherImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_weatherModel.img7]];
        _fifthWeatherImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_weatherModel.img9]];
        _sixthWeatherImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_weatherModel.img11]];

        //天气Label
        _secondWeatherLabel.text = _weatherModel.weather2;
        _thirdWeatherLabel.text  = _weatherModel.weather3;
        _fourthWeatherLabel.text = _weatherModel.weather4;
        _fifthWeatherLabel.text  = _weatherModel.weather5;
        _sixthWeatherLabel.text  = _weatherModel.weather6;
        
        //风
        _secondWindLabel.text = _weatherModel.wind2;
        _thirdWindLabel.text  = _weatherModel.wind3;
        _fourthWindLabel.text = _weatherModel.wind4;
        _fifthWindLabel.text  = _weatherModel.wind5;
        _sixthWindLabel.text  = _weatherModel.wind6;
        
        //温度
        _secondTemperatureLabel.text = _weatherModel.temp2;
        _thirdTemperatureLabel.text  = _weatherModel.temp3;
        _fourthTemperatureLabel.text = _weatherModel.temp4;
        _fifthTemperatureLabel.text  = _weatherModel.temp5;
        _sixthTemperatureLabel.text  = _weatherModel.temp6;
     
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        //更新月日
        NSString *updataDayTime = [userDefaults objectForKey:@"upDataDayTime"];
        NSString *updataHourTime = [userDefaults objectForKey:@"upDataHourTime"];
        if (updataDayTime != nil && updataHourTime != nil) {
            
            _updataDayTime.text = updataDayTime;
            _updataHourTime.text = updataHourTime;
        }
    }
}
@end
