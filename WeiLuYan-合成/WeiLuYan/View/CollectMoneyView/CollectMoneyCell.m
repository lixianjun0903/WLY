//
//  CollectMoneyCell.m
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "CollectMoneyCell.h"

@implementation CollectMoneyCell

- (void)awakeFromNib {
    
    _colContentView.viewBG.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whitecard"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)setData:(CollectMoneyObject *)model
{
    
    _colHeaderView.Controller = _Controller;
    _colButtonView.Controller = _Controller;
    
    [_colHeaderView setColHeaderData:model];
    [_colContentView setContentData:model];
    [_colButtonView setButtonData:model];
}

@end
