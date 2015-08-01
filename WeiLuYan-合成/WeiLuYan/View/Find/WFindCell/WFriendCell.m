//
//  WFriendCell.m
//  WeiLuYan
//
//  Created by dev on 14/12/11.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WFriendCell.h"
#import "UIImageView+WebCache.h"
#import "FriendRequest.h"

@implementation WFriendCell

- (void)awakeFromNib
{

}

-(void)config:(FoundFriendModel *)model
{
    [_UserImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    
    _UserNameLabel.text = model.user_name;
    
    _UserCompanyLabel.text = [NSString stringWithFormat:@"%@创始人",model.company];
    
    self.UserId = model.user_id;
}
- (IBAction)addFriendClick:(UIButton *)sender {
    
    [FriendRequest addFriend:^(NSNumber *result) {
        
        if (result == [NSNumber numberWithLong:1]){
            sender.selected = YES;
        }
        if (sender.selected) {
            return;
        }
    } :self.UserId];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
