//
//  NewsDetailViewController.m
//  SituoNews
//
//  Created by hwwp on 15-3-24.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController () <UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation NewsDetailViewController

#pragma mark - 初始化方法
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self _customNavigationBackButton];
    [self _initViews];
    
    /*
     modelid 为1     显示评论数
     modelid 为8     投票的         进去是显示导航栏
     modelid 为10    专题           进去是显示导航栏
     modelid 为4     视频
     modelid 为2     图片
     modelid 为7     活动
     */
    
    [self _requestDataWithContentID:_model.contentid];
    
    /*
     {
     data =     {
     comments = 0;
     contentid = 456;
     data =         (
     {
     catname = "\U4e13\U9898\U680f\U76ee";
     data =                 (
     {
     comments = 0;
     contentid = 469;
     description = "\U89c6\U9891\U76f4\U64ad\U6d4b\U8bd5";
     modelid = 4;
     shareurl = "http://m.cmstop.net/video/469";
     sorttime = 0;
     thumb = "http://upload.cmstop.net/remote2local/d/dd/thumb_160_120_dde746adab911809519cde831429810d.jpg";
     title = "\U623f\U95f4\U5b9e\U62cd";
     },
     {
     comments = 8;
     contentid = 452;
     description = "\U592e\U5e7f\U7f51\U5357\U5b8110\U670814\U65e5\U6d88\U606f \U636e\U4e2d\U56fd\U4e4b\U58f0\U300a\U65b0\U95fb\U7eb5\U6a2a\U300b\U62a5\U9053\Uff0c\U5357\U5b81\U5e02\U65e5\U524d\U901a\U62a5\U4e86\U4e00\U8d77\U4e25\U91cd\U7792\U62a5\U4e8b\U6545\Uff0c10\U67087\U65e5\U7ea621\U65f650\U5206";
     modelid = 1;
     shareurl = "http://m.cmstop.net/article/452";
     sorttime = 0;
     thumb = "";
     title = "\U5357\U5b81\U5730\U94c1\U65bd\U5de5\U574d\U584c\U81f41\U6b7b2\U5931\U8e2a \U65bd\U5de5\U65b9\U4e25\U91cd\U7792\U62a5";
     },
     {
     comments = 5;
     contentid = 451;
     description = "\U5982\U679c\U8bf4\Uff0c\U4e00\U5f00\U59cb\U975e\U6cd5\U201c\U5360\U4e2d\U201d\U884c\U5f84\U88c5\U626e\U51fa\U6765\U7684\U9762\U8c8c\U662f\U201c\U8857\U5934\U653f\U6cbb\U201d\U2014\U2014\U901a\U8fc7\U6781\U7aef\U7684\U610f\U89c1\U8868\U8fbe\U65b9\U5f0f\U6765\U8868\U8fbe\U6781\U7aef\U610f\U89c1\U8bc9\U6c42\U7684\U8bdd\Uff0c\U90a3\U4e48\Uff0c\U968f\U7740\U201c\U5360\U4e2d\U201d\U771f\U9762\U76ee\U7684";
     modelid = 1;
     shareurl = "http://m.cmstop.net/article/451";
     sorttime = 0;
     thumb = "http://upload.cmstop.net/2014/1014/thumb_160_120_1413250768884.png";
     title = "\U56fd\U5e73\Uff1a\U6e2f\U7248\U201c\U989c\U8272\U9769\U547d\U201d\U6ce8\U5b9a\U8981\U5931\U8d25";
     }
     );
     }
     );
     description = "\U4eca\U5e74\U4e0a\U534a\U5e74\Uff0c\U4e2d\U56fd\U5b8c\U6210\U8f6f\U4ef6\U8457\U4f5c\U6743\U767b\U8bb058333\U4ef6\Uff0c\U540c\U6bd4\U589e\U957f\U8d8530%\Uff0c\U5448\U73b0\U9ad8\U901f\U589e\U957f\U6001\U52bf\Uff0c\U4e0e\U4e91\U8ba1\U7b97\U3001\U7269\U8054\U7f51\U7b49\U65b0\U5174\U6280\U672f\U76f8\U5173\U7684\U8f6f\U4ef6\U767b\U8bb0\U91cf\U5ef6\U7eed\U4e86\U53bb\U5e74\U7684\U5feb\U901f\U589e\U957f\U3002";
     image = "http://upload.cmstop.net/2014/1118/thumb_720_540_1416292739794.jpg";
     modelid = 10;
     shareurl = "http://m.cmstop.net/special/456";
     sorttime = 1416808366;
     thumb = "http://upload.cmstop.net/2014/1118/thumb_160_120_1416292739794.jpg";
     title = "\U4e60\U8fd1\U5e73\Uff1a\U51b3\U4e0d\U80fd\U5728\U6839\U672c\U95ee\U9898\U4e0a\U51fa\U73b0\U98a0\U8986\U6027\U9519\U8bef";
     };
     state = 1;
     }

     */
}


#pragma mark - 私有方法
/**
 *  初始化视图
 */
- (void)_initViews
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    
    
}

- (void)_requestDataWithContentID:(NSNumber *)contentid
{
    NSString *urlStr = @"http://api.cmstop.net/mobile/index.php";
    // 请求参数
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:@"mobile" forKey:@"app"];
    [paraDic setObject:@"special" forKey:@"controller"];
    [paraDic setObject:@"content" forKey:@"action"];
    [paraDic setObject:contentid forKey:@"contentid"];
    
    // 发送请求
    [WebDataService requestWithURL:urlStr params:paraDic requestHeader:nil httpMethod:@"GET" block:^(id result) {
        
//        NSLog(@"result : %@",result);
        
        NSDictionary *data = result[@"data"];
        NSString *shareurl = data[@"shareurl"];
//        NSLog(@"shareurl : %@",shareurl);
        //设置请求
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:shareurl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
        [_webView loadRequest:request];

        
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"error : %@",error);
    }];

}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error : %@",error);
}


@end
