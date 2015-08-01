//
//  WSetCell.m
//  WeiLuYan
//
//  Created by dev on 14/12/12.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WSetCell.h"

@implementation WSetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)Config:(NSString *)content
{
    self.contentLabel.text = content;
}

@end
