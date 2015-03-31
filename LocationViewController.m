//
//  LocationViewController.m
//  SituoNews
//
//  Created by huanhuan on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "LocationViewController.h"
#import "WeatherViewController.h"
static NSString *tableViewCellIdentifier = @"tableViewCellIdentifier";
@interface LocationViewController ()

{
    
    NSString *_cityWeatherName;
}
@end

@implementation LocationViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"城市天气切换";
    
    [self _loadData];
    [self _customNavigationBackButton];
    [self _initTableView];
}

- (void)_loadData {
    
    NSString *URLPath = @"http://api.cmstop.net/mobile/index.php?app=mobile&controller=weather&action=index&triple=2";
    [WebDataService requestWithURL:URLPath params:nil requestHeader:nil httpMethod:@"POST" block:^(id result) {
        
        NSArray *data = result[@"data"];
        NSMutableArray *letterArray = [NSMutableArray array];
        NSMutableDictionary *cityDic = [NSMutableDictionary dictionary];
        for (NSDictionary *cityData in data) {
            
            NSString *letter = cityData[@"name"];
            NSArray *citysArray = cityData[@"citys"];
            [letterArray addObject:letter];
            [cityDic setObject:citysArray forKey:letter];
            
        }
        
        self.citySequence = letterArray;
        self.cityIDAndName = cityDic;
        [_tableView reloadData];

        
    } errorBlock:^(NSError *error) {
        
    }];
}


- (void)_initTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
}
#pragma mark - TableView DataSource
//1.表视图中有多少组（section）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.citySequence.count;
}

//2.表视图每组有多少单元格（行, row）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *letter = [self.citySequence objectAtIndex:section];
    
    NSArray *citys   = [self.cityIDAndName objectForKey:letter];
    
    return citys.count;
    

}

//3.创建每一个单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
        
    }
    
    NSString *letter = [self.citySequence objectAtIndex:indexPath.section];
    
    NSArray *citys = [self.cityIDAndName objectForKey:letter];
    NSMutableArray *cityArray = [NSMutableArray array];
    NSMutableDictionary *cityDiction = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in citys) {
        
        NSString *cityName = dic[@"name"];
        NSString *weatherID = dic[@"weatherid"];
        [cityArray addObject:cityName];
        
        [cityDiction setObject:weatherID forKey:cityName];
        
    }
    self.cityDictionarys = cityDiction;
    cell.textLabel.text = cityArray[indexPath.row];
    return cell;
    
    

    
}

#pragma mark - TableView Delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //(1)省份的名字
    NSString *letter = [self.citySequence objectAtIndex:section];
    
    return letter;

}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return self.citySequence;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _cityWeatherName = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
//    NSLog(@"_weatherVC :%@",_cityWeatherName);
//    _weatherVC.cityLabel.text = _cityWeatherName;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"城市天气切换" message:@"确定要切换城市" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

    [alertView show];
    


}

#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        _weatherVC.weatherID = [self.cityDictionarys objectForKey:_cityWeatherName];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_weatherVC.weatherID forKey:@"weatherID"];
        [userDefaults synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
    
        return;
    }
    
    
}

#pragma mark - 返回按钮
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
