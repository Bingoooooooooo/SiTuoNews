//
//  AppDelegate.h
//  SituoNews
//
//  Created by hwwp on 15-3-21.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

/*
 POST 右侧控制器界面 URL http://api.cmstop.net/mobile/index.php?app=mobile&controller=index&action=app&type=mobile&version=4.5.0
 
 
 POST 评论列表 http://api.cmstop.net/mobile/index.php?app=mobile&controller=comment&action=index&topicid=465&page=1&time=2015-03-20%2018:27:47
 
 GET 首页 上面的scrollView http://api.cmstop.net/mobile/index.php?app=mobile&controller=content&action=slide&catid=0&time=1389322157.json 请求出来之后，拿到ID，拼接参数为contentid   topicid
 
 
 POST scrollView点击（第一个）弹出WebView  http://api.cmstop.net/mobile/index.php?app=mobile&controller=article&action=content&contentid=323  再抓shareurl  http://m.cmstop.net/article/323
 
 点击scrollView，得到JSON 取shareurl这个key 是web view的url
 
 http://api.cmstop.net/mobile/index.php?app=mobile&controller=comment&action=index&topicid=604&page=1&time=2015-03-20%2018:36:59   参数topicid 是从上面的数据JSON中拿到的
 
 http://api.cmstop.net/mobile/index.php?app=mobile&controller=article&action=content&contentid=178
 
 GET 首页tableView的数据 http://api.cmstop.net/mobile/index.php?app=mobile&controller=content&action=index&catid=0&keyword=&page=0&time=0
 
 POST右侧控制器 天气 http://api.cmstop.net/mobile/index.php?app=mobile&controller=weather&action=weather&weatherid=0&cityname=
 
 GET 首页 我的频道 http://api.cmstop.net/mobile/index.php?app=mobile&controller=content&action=category   返回的结果中 catid 作为参数请求tableView 的数据
 
 
 POST 首页的详情数据  http://api.cmstop.net/mobile/index.php?app=mobile&controller=special&action=content&contentid=456
 
 
 GET 科技的数据 http://api.cmstop.net/mobile/index.php?app=mobile&controller=content&action=index&catid=1&keyword=&page=1&time=0
 
 
 http://api.cmstop.net/mobile/index.php?app=mobile&controller=content&action=index&catid=9&keyword=&page=1&time=0
 */