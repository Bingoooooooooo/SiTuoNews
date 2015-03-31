//
//  CustomLabel.m
//  SituoNews
//
//  Created by hwwp on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 从本地拿字体数据
        int size = [[[NSUserDefaults standardUserDefaults] objectForKey:kFontSize] intValue];
        if (size == 0) {
            self.font = [UIFont systemFontOfSize:12];
            
        }else if (size == 1) {
            self.font = [UIFont systemFontOfSize:14];
            
        }else {
            self.font = [UIFont systemFontOfSize:16];
        }
    }
    return self;
}



@end
