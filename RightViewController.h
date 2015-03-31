//
//  RightViewController.h
//  SituoNews
//
//  Created by hwwp on 15-3-21.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "BaseViewController.h"

@interface RightViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *titleNames;
@property (nonatomic, strong) NSArray *titleImageNames;
@end
