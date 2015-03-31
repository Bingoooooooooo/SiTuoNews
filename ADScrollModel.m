//
//  ADScrollModel.m
//  SituoNews
//
//  Created by hwwp on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "ADScrollModel.h"

@implementation ADScrollModel

- (id)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self) {
        
        self.description_news = dic[@"description"];
    }
    return self;
}

@end
