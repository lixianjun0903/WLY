//
//  WProjectCell.m
//  WeiLuYan
//
//  Created by dev on 14/12/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WProjectCell.h"

@implementation WProjectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)config:(FoundProjectModel *)model
{
    self.title.text = model.name;
}

@end
