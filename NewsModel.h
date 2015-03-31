//
//  NewsModel.h
//  SituoNews
//
//  Created by hwwp on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "BaseModel.h"

@interface NewsModel : BaseModel

@property (nonatomic, strong) NSNumber *comments;       // 13,
@property (nonatomic, strong) NSNumber *sorttime;       //1381237095
@property (nonatomic, strong) NSNumber *contentid;      // 323
@property (nonatomic, strong) NSNumber *modelid;        // 1,
@property (nonatomic, strong) NSString *title;          //广州因三条地铁设换乘站 公园4000棵树被挖走",
@property (nonatomic, strong) NSString *thumb;          //http://upload.cmstop.net/2014/0616/thumb_640_314_1402887770652.jpg",
@property (nonatomic, strong) NSString *description_news;    //因三条地铁线路在此设换乘站，公园内4000多棵树被挖走，“复绿”最快要等到明年6月",


@end
