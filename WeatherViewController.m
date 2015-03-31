//
//  WeatherViewController.m
//  SituoNews
//
//  Created by huanhuan on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherTopView.h"
#import "LocationViewController.h"
#import "WeatherDayView.h"
#import "WeatherModel.h"
@interface WeatherViewController ()
{

    WeatherTopView *_weatherTopView;
    WeatherDayView *_weatherDayView;
    WeatherModel *_weatherModel;
    NSString *_URLPath;
    
}
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self _initBaseView];
    [self _initUpView];
    [self _initDownView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
//    _cityLabel.text = _weatherModel.city;
    [self _loadData];

}
- (void)_loadData {
    
    _URLPath = @"http://api.cmstop.net/mobile/index.php?";
    
    NSMutableDictionary *pamaras = [NSMutableDictionary dictionary];
    [pamaras setObject:@"mobile" forKey:@"app"];
    [pamaras setObject:@"weather" forKey:@"controller"];
    [pamaras setObject:@"weather" forKey:@"action"];
    [pamaras setObject:@"" forKey:@"cityname"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *weatherID = [userDefaults objectForKey:@"weatherID"];
    if (!weatherID) {
       
        weatherID = @"0";
    }
    [pamaras setObject:weatherID forKey:@"weatherid"];

    
    [WebDataService requestWithURL:_URLPath params:nil requestHeader:nil httpMethod:@"POST" block:^(id result) {
        
        NSDictionary *dataDic = result[@"data"];
        
        _weatherModel = [[WeatherModel alloc]initWithContentsOfDic:dataDic];
        
        _weatherTopView.weatherModel = _weatherModel;
        _weatherDayView.weatherModel = _weatherModel;
        _cityLabel.text = _weatherModel.city;
        
        [self updataTime];
        [_weatherDayView.updataTimeImageView stopAnimating];

        
    } errorBlock:^(NSError *error) {
        
    }];
    
}
- (void)_initBaseView {

    //背景视图
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.image = [UIImage imageNamed:@"newbg@2x.png"];
    [self.view addSubview:imgView];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 20, 80, 44);
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    [backButton setImage:[UIImage imageNamed:@"item_cancel@2x.png"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //城市名
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 50, 20, 100, 44)];
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    _cityLabel.font = [UIFont boldSystemFontOfSize:22];
    _cityLabel.backgroundColor = [UIColor clearColor];
    _cityLabel.textColor = [UIColor whiteColor];
//    _cityLabel.text = @"北京";
    [self.view addSubview:_cityLabel];

    //换城市
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    locationButton.frame = CGRectMake(kScreenWidth - 64, 20, 44, 44);
    [locationButton setImage:[UIImage imageNamed:@"map.png"] forState:UIControlStateNormal];
    [locationButton addTarget:self
                   action:@selector(locationButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationButton];
    

}

- (void)_initUpView {


    
    _weatherTopView = [[[NSBundle mainBundle] loadNibNamed:@"WeatherTopView" owner:self options:nil]lastObject];
    _weatherTopView.frame = CGRectMake(20, 100, 280, 150);

    [self.view addSubview:_weatherTopView];
}

- (void)_initDownView {
    
    _weatherDayView = [[[NSBundle mainBundle] loadNibNamed:@"WeatherDayView" owner:self options:nil]lastObject];
    _weatherDayView.frame = CGRectMake(10, _weatherTopView.bottom - 10, 300, 300);
    [self.view addSubview:_weatherDayView];
    _weatherDayView.updataTimeImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [_weatherDayView.updataTimeImageView addGestureRecognizer:singleTap];
}

#pragma mark - Action Methods
- (void)backAction:(UIButton *)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)locationButtonAction:(UIButton *)sender {
    
    LocationViewController *locationVC = [[LocationViewController alloc] init];
    locationVC.weatherVC = self;
    UINavigationController *baseNV = [[UINavigationController alloc] initWithRootViewController:locationVC];
    locationVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:baseNV animated:YES completion:nil];
    
    
}

- (void)singleTapAction:(UITapGestureRecognizer *)sender {

    [self updataTime];
    NSMutableArray *imgArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 12; i++) {
        
        NSString *imgName = [NSString stringWithFormat:@"%ldup.png",i+1];
        UIImage *image = [UIImage imageNamed:imgName];
        [imgArray addObject:image];
    }
    _weatherDayView.updataTimeImageView.animationImages = imgArray;
    _weatherDayView.updataTimeImageView.animationDuration = 1;
    _weatherDayView.updataTimeImageView.animationRepeatCount = HUGE_VALF;
    [_weatherDayView.updataTimeImageView startAnimating];
    
    [self _loadData];
    
}

- (void)updataTime {
    
    NSDate *myDate = [NSDate date];
    NSString *dateString = [NSString stringWithFormat:@"%@",myDate];
    NSString *monthString = [dateString substringWithRange:NSMakeRange(5, 2)];
    NSString *dayString = [dateString substringWithRange:NSMakeRange(8, 2)];
    
    NSInteger beginHour = [[dateString substringWithRange:NSMakeRange(11, 2)] integerValue];
    NSString *hourString = [NSString stringWithFormat:@"%ld",beginHour + 8];
    NSString *minuteString = [dateString substringWithRange:NSMakeRange(14, 2)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //更新月日
    _weatherDayView.updataDayTime.text         = [NSString stringWithFormat:@"%@/%@",monthString,dayString];
    _weatherDayView.updataHourTime.text  = [NSString stringWithFormat:@"%@:%@",hourString,minuteString];
    //本地化
    [userDefaults setObject:_weatherDayView.updataDayTime.text forKey:@"upDataDayTime"];
    [userDefaults setObject:_weatherDayView.updataHourTime.text forKey:@"upDataHourTime"];
    [userDefaults synchronize];

}








@end
