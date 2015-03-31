//
//  CenterViewController.m
//  SituoNews
//
//  Created by hwwp on 15-3-21.
//  Copyright (c) 2015年 思拓. All rights reserved.
//
#warning 解决超出边界不响应事件
/*
 - (UIView *) hitTest:(CGPoint) point withEvent:(UIEvent *)event {
 if (point in rect_you_want) {
 for subview in subviews
 if (point in subview)
 return subview
 retunr self;
 }
 return nil;
 }
 */

#import "CenterViewController.h"
#import "NewsTableView.h"
#import "MyChannelView.h"
#import "NewsModel.h"
#define Duration 0.2

#import "MenuHrizontalButton.h"
#import "ScrollPageView.h"

@interface CenterViewController () <MenuHrizontalDelegate, ScrollPageViewDelegate>
{
    BOOL contain;
    CGPoint startPoint;
    CGPoint originPoint;
    NSInteger index;
    
    MenuHrizontalButton *_menuHrizontalButton;
    ScrollPageView      *_scrollPageView;
    MyChannelView       *_myChannelView;             // 类别视图
    NSArray             *_buttonItemArray;
    NSInteger            _catid;
    NSInteger            _classPage;
}

@property (nonatomic, strong, readonly) UIView *myChannelView; // 我的频道视图

@end

@implementation CenterViewController

#pragma mark - 视图控制器的生命周期
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // 初始化可变数组
        _dataList = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"思拓新闻";

    // 1.初始化子视图
    [self _initViews];
    
    // 第一次进来请求首页的数据
    //先判断是否本地化
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kMyClass] == nil) {
        
        [self requestNewsDataWithPage:1 catid:0 classPage:0];
        [self requestScrollViewData];
        
    }else {
        NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:kMyClass];
        NSDictionary *buttonInfoDic = arr[0];
        int catid =[buttonInfoDic[CATID] intValue];
        //NSLog(@"catid : %d",catid);
        if (catid == 0) {
            [self requestScrollViewData];
            [self requestNewsDataWithPage:1 catid:catid classPage:0];
        }else {
            NewsTableView *newsTableView = (NewsTableView *)_scrollPageView.contentItems[0];
            newsTableView.adDataList = nil;
            [newsTableView reloadData];
            [self requestNewsDataWithPage:1 catid:catid classPage:0];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)dealloc
{
    NSLog(@"---CenterViewController dealloc---");
}

#pragma mark - 私有方法
/**
 *  请求新闻数据
 *
 *  @param page         上拉加载更多的参数page
 *  @param catid        类别
 *  @param classPage    第几页
 */
- (void)requestNewsDataWithPage:(NSInteger)page catid:(NSInteger)catid classPage:(NSInteger)classPage;
{
    // 把这个参数，保存为全局的，方便上拉刷新调用
    _catid = catid;
    _classPage = classPage;
    
    NSString *urlStr = @"http://api.cmstop.net/mobile/index.php";
    // 请求参数
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:@"mobile" forKey:@"app"];
    [paraDic setObject:@"content" forKey:@"controller"];
    [paraDic setObject:@"index" forKey:@"action"];
    [paraDic setObject:@"" forKey:@"keyword"];
    [paraDic setObject:@"0" forKey:@"time"];
    [paraDic setObject:@(page) forKey:@"page"];
    [paraDic setObject:@(catid) forKey:@"catid"];
    
    // 发送请求
    [WebDataService requestWithURL:urlStr params:paraDic requestHeader:nil httpMethod:@"GET" block:^(id result) {
        
        NSMutableArray *newsModels = [NSMutableArray array];
        
        for (NSDictionary *dic in result[@"data"]) {
            NewsModel *newsModel = [[NewsModel alloc] initWithContentsOfDic:dic];
            [newsModels addObject:newsModel];
        }
        
        // 把数据给表视图，并且刷新表视图
        NewsTableView *newsTableView = (NewsTableView *)_scrollPageView.contentItems[classPage];
        
        // 判断是否是上拉
        if (page > 1) {
           // 拼接数据
            [self.dataList addObjectsFromArray:newsModels];
            
        }else {
            // 第一次进来。或者是下拉
            self.dataList = newsModels;
        }
        
        newsTableView.dataList = self.dataList;
        [newsTableView reloadData];
        
        //结束刷新
        [newsTableView headerEndRefreshing];
        [newsTableView footerEndRefreshing];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"error : %@",error);
        NewsTableView *newsTableView = (NewsTableView *)_scrollPageView.contentItems[classPage];
        //结束刷新
        [newsTableView headerEndRefreshing];
        [newsTableView footerEndRefreshing];
    }];
}

/**
 *  请求首页上广告视图的数据
 */
- (void)requestScrollViewData
{    
    NSString *urlStr = @"http://api.cmstop.net/mobile/index.php";
    // 请求参数
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:@"mobile" forKey:@"app"];
    [paraDic setObject:@"content" forKey:@"controller"];
    [paraDic setObject:@"slide" forKey:@"action"];
    [paraDic setObject:@"1389322157" forKey:@"time"];
    [paraDic setObject:@(0) forKey:@"catid"];
    
    // 发送请求
    [WebDataService requestWithURL:urlStr params:paraDic requestHeader:nil httpMethod:@"GET" block:^(id result) {
        
        NSMutableArray *newsModels = [NSMutableArray array];

        for (NSDictionary *dic in result[@"data"]) {
            NewsModel *newsModel = [[NewsModel alloc] initWithContentsOfDic:dic];
            [newsModels addObject:newsModel];
        }
        
        // 把数据给表视图，并且刷新表视图
        NewsTableView *newsTableView = (NewsTableView *)_scrollPageView.contentItems[0];
        
        newsTableView.adDataList = newsModels;
        [newsTableView reloadData];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"error : %@",error);
    }];
}


//初始化子视图
- (void)_initViews
{
    /* (1)导航栏 */
    [self _customNavigationItemButton];
    
    /* (2)分类视图(滑动视图) */
    _buttonItemArray = @[@{NOMALKEY: @"normal.png",
                                   HEIGHTKEY:@"helight.png",
                                   TITLEKEY:@"头条",
                                   CATID:@"0",
                                   TITLEWIDTH:[NSNumber numberWithFloat:60]
                                   },
                                    @{NOMALKEY: @"normal.png",
                                    HEIGHTKEY:@"helight.png",
                                    TITLEKEY:@"国际",
                                    CATID:@"5",
                                    TITLEWIDTH:[NSNumber numberWithFloat:60]
                                    },
                                  @{NOMALKEY: @"normal.png",
                                    HEIGHTKEY:@"helight.png",
                                    TITLEKEY:@"科技",
                                    CATID:@"1",
                                    TITLEWIDTH:[NSNumber numberWithFloat:60]
                                    },
                                  @{NOMALKEY: @"normal",
                                    HEIGHTKEY:@"helight",
                                    TITLEKEY:@"军事",
                                    CATID:@"2",
                                    TITLEWIDTH:[NSNumber numberWithFloat:60]
                                    },
                                  @{NOMALKEY: @"normal",
                                    HEIGHTKEY:@"helight",
                                    TITLEKEY:@"娱乐",
                                    CATID:@"3",
                                    TITLEWIDTH:[NSNumber numberWithFloat:60]
                                    },
                                  @{NOMALKEY: @"normal",
                                    HEIGHTKEY:@"helight",
                                    TITLEKEY:@"体育",
                                    CATID:@"4",
                                    TITLEWIDTH:[NSNumber numberWithFloat:60]
                                    },
                                  @{NOMALKEY: @"normal",
                                    HEIGHTKEY:@"helight",
                                    TITLEKEY:@"汽车",
                                    CATID:@"7",
                                    TITLEWIDTH:[NSNumber numberWithFloat:60]
                                    },
                                  @{NOMALKEY: @"normal",
                                    HEIGHTKEY:@"helight",
                                    TITLEKEY:@"房产",
                                    CATID:@"9",
                                    TITLEWIDTH:[NSNumber numberWithFloat:60]
                                    },
                                  @{NOMALKEY: @"normal",
                                    HEIGHTKEY:@"helight",
                                    TITLEKEY:@"财经",
                                    CATID:@"8",
                                    TITLEWIDTH:[NSNumber numberWithFloat:60]
                                    }];
    
    /* (2)分类按钮视图 */
    _menuHrizontalButton = [[MenuHrizontalButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 30, 30)];
    
    //先判断是否本地化
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kMyClass] == nil) {
        _menuHrizontalButton.itemsArray = _buttonItemArray;
        
    }else {
        _menuHrizontalButton.itemsArray = MY_CLASSBUTTON;
    }
    
    _menuHrizontalButton.delegate = self;
    [self.view addSubview:_menuHrizontalButton];
    
    // 默认第一个为选中
    [_menuHrizontalButton clickButtonAtIndex:0];
    
    /* (3)新闻视图 */
    _scrollPageView = [[ScrollPageView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight - 30)];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kMyClass] == nil) {
        
        [_scrollPageView setContentOfTables:_buttonItemArray.count];
    }else {
        
        [_scrollPageView setContentOfTables:(MY_CLASSBUTTON).count];
    }
    _scrollPageView.delegate = self;
    [self.view addSubview:_scrollPageView];
    
    /* (4)我的频道视图 */
    //先判断是否本地化
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kMyClass] == nil) {
        _myChannelView = [[MyChannelView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) buttonInfo:_buttonItemArray];
        
    }else {
        NSArray *array = [MY_CLASSBUTTON arrayByAddingObjectsFromArray:OPTIONAL_CLASSBUTTON];
        _myChannelView = [[MyChannelView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) buttonInfo:array];
    }
    [self.view addSubview:_myChannelView];
    
    // 第一次进来是隐藏的
    _myChannelView.bottom = 0;
    
    /* (5)我的频道 控制按钮 */
    UIButton *showMyChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    showMyChannel.frame = CGRectMake(kScreenWidth - 30, 0, 30, 30);
    [showMyChannel setImage:[UIImage imageNamed:@"箭头向下"] forState:UIControlStateNormal];
    [showMyChannel setImage:[UIImage imageNamed:@"箭头向上"] forState:UIControlStateSelected];
    [showMyChannel addTarget:self action:@selector(showMyChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    // 把这个按钮，插入到我的频道视图的上面
    [self.view insertSubview:showMyChannel aboveSubview:_myChannelView];
}

#pragma mark - 我的频道按钮方法
- (void)showMyChannelAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [UIView animateWithDuration:Duration animations:^{
            _myChannelView.bottom = kScreenHeight;
        }];
        
        //如果本地化，从新布局
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kMyClass] != nil) {
            [_myChannelView showMyClassButtonWithButtonArr:MY_CLASSBUTTON];
            [_myChannelView showOptionalClassButtonWithButtonArr:OPTIONAL_CLASSBUTTON];
        }

    }else {
        [UIView animateWithDuration:Duration animations:^{
            _myChannelView.bottom = 0;
        }];
        
        NSArray *array = nil;
        
        if (MY_CLASSBUTTON.count == 0) {
            
            array = _buttonItemArray;
        } else {
            
            array = MY_CLASSBUTTON;
        }
        
        //重新显示button
        _menuHrizontalButton.itemsArray = array;
        NSDictionary *dic = array[0];
        if (dic[CATID] != 0) {
            NewsTableView *newsTableView = (NewsTableView *)_scrollPageView.contentItems[0];
            newsTableView.adDataList = nil;
            [newsTableView reloadData];

        }
        //显示选中状态
        [_menuHrizontalButton clickButtonAtIndex:0];
        //重新显示tableView
        [_scrollPageView setContentOfTables:array.count];
        //移动tableView
        [_scrollPageView moveScrollowViewAthIndex:0];
        //请求数据
        NSDictionary *buttonInfoDic = array[0];
        int catid =[buttonInfoDic[CATID] intValue];
        NSLog(@"catid : %d",catid);
        [self requestNewsDataWithPage:1 catid:catid classPage:0];
    }
}

#pragma mark - 长按手势的方法
/*
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender
{
    UIButton *btn = (UIButton *)sender.view;
    if (sender.state == UIGestureRecognizerStateBegan) {
        // 显示删除按钮
        for (NSNumber *key in _closeDic) {
            UIButton *closeBtn = _closeDic[key];
            closeBtn.hidden = NO;
        }
        
        // 隐藏更多label
        _moreLabel.hidden = YES;
        // 隐藏可添加的类
        for (NSNumber *key in _otherClass) {
            UIButton *classBtn = _otherClass[key];
            classBtn.hidden = YES;
        }
        
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
        [UIView animateWithDuration:Duration animations:^{
            
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
        }];
        
    }else if(sender.state == UIGestureRecognizerStateChanged) {
        
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
        btn.center = CGPointMake(btn.center.x + deltaX, btn.center.y + deltaY);
        //NSLog(@"center = %@",NSStringFromCGPoint(btn.center));
        index = [self indexOfPoint:btn.center withButton:btn];
        
        if (index < 0) {
            contain = NO;
            
        }else {
            [UIView animateWithDuration:Duration animations:^{
                
                CGPoint temp = CGPointZero;
                UIButton *button = _itemDic[@(index)];
                temp = button.center;
                button.center = originPoint;
                btn.center = temp;
                originPoint = btn.center;
                contain = YES;
                
            }];
        }
        
    }else if (sender.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:Duration animations:^{
            
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            
            if (!contain) {
                btn.center = originPoint;
            }
        }];
    }
}
 */

/*
- (NSInteger)indexOfPoint:(CGPoint)point withButton:(UIButton *)btn
{
    for (NSInteger i = 0; i<_itemDic.count ;i++) {
        UIButton *button = _itemDic[@(i)];
        
        if (button != btn) {
            if (CGRectContainsPoint(button.frame, point)) {
                return i;
            }
        }
    }
    return -1;
}
 */

#pragma mark - MenuHrizontalDelegate, ScrollPageViewDelegate
- (void)didScrollPageViewChangedPage:(NSInteger)page
{
    [_menuHrizontalButton changeButtonStateAtIndex:page];
    
    NSArray *arr = nil;
    if (MY_CLASSBUTTON.count > 0) {
        
        arr = MY_CLASSBUTTON;
        
    }else {
        
        arr = _buttonItemArray;
    }
    
    NSDictionary *buttonInfoDic = arr[page];
    int catid =[buttonInfoDic[CATID] intValue];
    NSLog(@"catid : %d",catid);
    if (catid == 0) {
        
        [self requestScrollViewData];
        [self requestNewsDataWithPage:1 catid:catid classPage:page];
    }
    
    [self requestNewsDataWithPage:1 catid:catid classPage:page];
    
}

- (void)didMenuHrizontalClickedButtonAtIndex:(NSInteger)page
{
    [_scrollPageView moveScrollowViewAthIndex:page];
    
    NSArray *arr = nil;
    if (MY_CLASSBUTTON.count > 0) {
        
        arr = MY_CLASSBUTTON;
        
    }else {
        
        arr = _buttonItemArray;
    }
    
    NSDictionary *buttonInfoDic = arr[page];
    int catid =[buttonInfoDic[CATID] intValue];
    NSLog(@"catid : %d",catid);
    if (catid == 0) {
        
        [self requestScrollViewData];
        [self requestNewsDataWithPage:1 catid:catid classPage:page];
    }

    [self requestNewsDataWithPage:1 catid:catid classPage:page];
}

//表视图刷新
- (void)refreshDataWithPage:(NSInteger)page
{
    //NSLog(@"刷新数据");
    [self requestNewsDataWithPage:page catid:_catid classPage:_classPage];
}

@end



