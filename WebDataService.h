//
//  WXDataService.h
//  WXWeibo
//
//  Created by JayWon on 14-8-23.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionLoad)(id result);
typedef void(^ErrorBlock)(NSError *error);

@interface WebDataService : NSObject

+ (NSMutableURLRequest *)requestWithURL:(NSString *)url
                                 params:(NSMutableDictionary *)params
                          requestHeader:(NSDictionary *)header
                             httpMethod:(NSString *)httpMethod
                                  block:(CompletionLoad)block
                             errorBlock:(ErrorBlock)errorBlock;

@end
