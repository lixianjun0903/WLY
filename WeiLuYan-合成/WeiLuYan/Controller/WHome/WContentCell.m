//
//  WContentCell.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 14-12-16.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WContentCell.h"
#import "UIImageView+WebCache.h"

@implementation WContentCell

- (void)awakeFromNib {
    [_userIcon.layer setCornerRadius:CGRectGetHeight([_userIcon bounds]) / 2];
    _userIcon.layer.masksToBounds = YES;
    _commentLabel.numberOfLines = 0;
    _commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)loadData:(NSDictionary *)data
{
        
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:data[@"data_commentuser"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    _nameLabel.text = data[@"data_commentuser"][@"nickname"];
    _commentLabel.text = data[@"content"];
    _timeLabel.text = [GeneralizedProcessor getDateString:[data[@"time"] floatValue]];

}

-(void)setCollectDetail:(NSDictionary *)data
{
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:data[@"avatar"]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    _nameLabel.text = data[@"nickname"];
    
    _timeLabel.text = @"北京";
}
@end
