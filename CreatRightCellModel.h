//
//  CreatRightCellModel.h
//  SituoNews
//
//  Created by huanhuan on 15-3-23.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "BaseModel.h"

@interface CreatRightCellModel : BaseModel

@property (nonatomic, copy)NSString *appid;//右控制器cell的ID
@property (nonatomic, copy)NSString *name;//右控制器cell的名字
@property (nonatomic, copy)NSString *iconurl;//右控制器cell的图标URL
@property (nonatomic, copy)NSString *url;//右控制器cell的URL（我猜的）

@end
