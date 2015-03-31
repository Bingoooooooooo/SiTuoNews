//
//  WeatherModel.h
//  SituoNews
//
//  Created by huanhuan on 15-3-23.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "BaseModel.h"

@interface WeatherModel : BaseModel

@property (nonatomic, copy) NSString *city;//城市名
@property (nonatomic, copy) NSString *cityid;//城市ID
@property (nonatomic, copy) NSString *date_l;//农历日期
@property (nonatomic, copy) NSString *week;//星期几
@property (nonatomic, copy) NSString *img1;//今天天气图片
@property (nonatomic, copy) NSString *img3;//第二天天气图片
@property (nonatomic, copy) NSString *img5;//第三天天气图片
@property (nonatomic, copy) NSString *img7;//第四天天气图片
@property (nonatomic, copy) NSString *img9;//第五天天气图片
@property (nonatomic, copy) NSString *img11;//第六天气图片
@property (nonatomic, copy) NSString *weather1;//今天天气
@property (nonatomic, copy) NSString *weather2;//第二天天气
@property (nonatomic, copy) NSString *weather3;//第三天天气
@property (nonatomic, copy) NSString *weather4;//第四天天气
@property (nonatomic, copy) NSString *weather5;//第五天天气
@property (nonatomic, copy) NSString *weather6;//第六天天气
@property (nonatomic, copy) NSString *wind1;//今天风的情况
@property (nonatomic, copy) NSString *wind2;//第二天风的情况
@property (nonatomic, copy) NSString *wind3;//第三天风的情况
@property (nonatomic, copy) NSString *wind4;//第四天风的情况
@property (nonatomic, copy) NSString *wind5;//第五天风的情况
@property (nonatomic, copy) NSString *wind6;//第六天风的情况
@property (nonatomic, copy) NSString *temp1;//今天温度
@property (nonatomic, copy) NSString *temp2;//第二天温度
@property (nonatomic, copy) NSString *temp3;//第三天温度
@property (nonatomic, copy) NSString *temp4;//第四天温度
@property (nonatomic, copy) NSString *temp5;//第五天温度
@property (nonatomic, copy) NSString *temp6;//第六天温度
@end
