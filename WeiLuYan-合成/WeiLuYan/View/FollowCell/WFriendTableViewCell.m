//
//  FriendTableViewCell.m
//  WeiLuYan
//
//  Created by jikai on 14-12-10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WFriendTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation WFriendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configFriend:(MyFriend *)model add:(BOOL)flag
{
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = 20;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.friend_user_icon] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    
    self.introductionLabel.text=model.from_type;
   // self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (model.is_apply ==0) {
        
        self.addButton.hidden=NO;
       // [self.addButton setImage:[UIImage imageNamed:@"friend_add"] forState: UIControlStateNormal];
        [self.addButton setBackgroundImage:[UIImage imageNamed:@"friend_add"] forState:UIControlStateNormal];
    }
    else if (model.is_apply ==1)
    {
        self.addButton.hidden=YES;
        
    }
    else if (model.is_apply==2)
    {
        NSLog(@"is_apple=222");
        
        [self.addButton setBackgroundImage:[UIImage imageNamed:@"friend_add"] forState:UIControlStateNormal];
        self.addButton.hidden=NO;
    }
    if ([model.friend_user_name  isEqualToString:@""])
    {
        self.nickNameLabel.text=model.friend_nick_name;
    }
    else {
        self.nickNameLabel.text=model.friend_user_name;
    }
    
}

- (IBAction)buttonClick:(id)sender {
}
@end
