//
//  CommentTableViewCell.m
//  WLY-TeamCommentView
//
//  Created by weiluyan on 14/12/29.
//  Copyright (c) 2014年 JX. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {

    [_userIcon.layer setCornerRadius:CGRectGetHeight([_userIcon bounds]) / 2];
    _userIcon.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated

{
    [super setSelected:selected animated:animated];

    
    
    
    // Configure the view for the selected state
}

-(void)config:(NSDictionary *)dic
{
    if([dic[@"data_commentuser"] isKindOfClass:[NSNull class]])
    {
        return;
    }
    _userName.text = dic[@"data_commentuser"][@"nickname"];
    
    NSString * str = dic[@"content"];
    
    _commentLabel.text = str;
    
    CGSize size = [_commentLabel sizeThatFits:CGSizeMake(200, 1000)];
    
    CGRect fra = _commentLabel.frame;
    
    fra.size.height = size.height;
    
    self.commentLabel.frame = fra;
    
    _timeLabel.frame = CGRectMake(_timeLabel.frame.origin.x, _commentLabel.frame.size.height + _commentLabel.frame.origin.y, _timeLabel.frame.size.width, _timeLabel.frame.size.height + 40);
    
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:dic[@"data_commentuser"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    _timeLabel.text = [GeneralizedProcessor getDateString:[dic[@"deal_time"] floatValue]];
}

-(CGFloat)getCellHeight
{
    return _timeLabel.frame.origin.y + _timeLabel.frame.size.height + 40;
}



@end
