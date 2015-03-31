//
//  WeatherDayView.h
//  SituoNews
//
//  Created by huanhuan on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"
@interface WeatherDayView : UIView

@property (nonatomic , strong)WeatherModel *weatherModel;

//第二天
@property (weak, nonatomic) IBOutlet UILabel *secondDay;
@property (weak, nonatomic) IBOutlet UIImageView *secondWeatherImgView;
@property (weak, nonatomic) IBOutlet UILabel *secondWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondWindLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTemperatureLabel;
//第三天
@property (weak, nonatomic) IBOutlet UILabel *thirdDay;
@property (weak, nonatomic) IBOutlet UIImageView *thirdWeatherImgView;
@property (weak, nonatomic) IBOutlet UILabel *thirdWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdWindLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdTemperatureLabel;
//第四天
@property (weak, nonatomic) IBOutlet UILabel *fourthDay;
@property (weak, nonatomic) IBOutlet UIImageView *fourthWeatherImgView;
@property (weak, nonatomic) IBOutlet UILabel *fourthWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthWindLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthTemperatureLabel;
//第五天
@property (weak, nonatomic) IBOutlet UILabel *fifthDay;
@property (weak, nonatomic) IBOutlet UIImageView *fifthWeatherImgView;
@property (weak, nonatomic) IBOutlet UILabel *fifthWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *fifthWindLabel;
@property (weak, nonatomic) IBOutlet UILabel *fifthTemperatureLabel;
//第六天
@property (weak, nonatomic) IBOutlet UILabel *sixthDay;
@property (weak, nonatomic) IBOutlet UIImageView *sixthWeatherImgView;
@property (weak, nonatomic) IBOutlet UILabel *sixthWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *sixthWindLabel;
@property (weak, nonatomic) IBOutlet UILabel *sixthTemperatureLabel;

//更新

@property (weak, nonatomic) IBOutlet UIImageView *updataTimeImageView;

@property (weak, nonatomic) IBOutlet UILabel *updataDayTime;
@property (weak, nonatomic) IBOutlet UILabel *updataHourTime;










@end
