//
//  OtherTypeNewsCell.m
//  SituoNews
//
//  Created by hwwp on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "OtherTypeNewsCell.h"

@implementation OtherTypeNewsCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - 设置数据
- (void)setNewsModel:(NewsModel *)newsModel
{
    if (_newsModel != newsModel) {
        _newsModel = newsModel;
        
        // 标题
        _newsTitle.text = _newsModel.title;
        
        // 内容
        _contentLabel.text = _newsModel.description_news;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
