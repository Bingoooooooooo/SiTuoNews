//
//  FontViewController.m
//  SituoNews
//
//  Created by hwwp on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "FontViewController.h"

@interface FontViewController ()
{
    UIImageView *_imageView;
}

@end

@implementation FontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置字体";
    
    // 返回按钮
    [self _customNavigationBackButton];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titles = @[@"小号", @"中号", @"大号"];
    
    for (int i = 0; i <titles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.backgroundColor = [UIColor colorWithWhite:0.891 alpha:1.000];
        btn.layer.cornerRadius = 5;
        btn.frame = CGRectMake(10, i * (40 + 10) + 10, kScreenWidth - 20, 40);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:<#(NSString *)#>] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(changeFont:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_left_column_seleced_btn"]];
    // 从本地取
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kFontSize] == nil) {
       _imageView.frame = CGRectMake(kScreenWidth / 2 + 40, 50 + 15, 30, 30);
        
    }else {
        int size = [[[NSUserDefaults standardUserDefaults] objectForKey:kFontSize] intValue];
      _imageView.frame = CGRectMake(kScreenWidth / 2 + 40, size * 50 + 15, 30, 30);
    }
    
    [self.view addSubview:_imageView];

}

- (void)changeFont:(UIButton *)button
{
    [[NSUserDefaults standardUserDefaults] setObject:@(button.tag) forKey:kFontSize];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _imageView.frame = CGRectMake(kScreenWidth / 2 + 40, button.tag * 50 + 15, 30, 30);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
