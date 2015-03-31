//
//  NewsCell.m
//  SituoNews
//
//  Created by hwwp on 15-3-22.
//  Copyright (c) 2015年 思拓. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // Initialization code
    }
    return self;
}

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
        
        // 图片
        [_contentImage sd_setImageWithURL:[NSURL URLWithString:_newsModel.thumb] placeholderImage:nil];
    }
}

@end
