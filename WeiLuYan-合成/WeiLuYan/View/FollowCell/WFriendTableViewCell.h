//
//  FriendTableViewCell.h
//  WeiLuYan
//
//  Created by jikai on 14-12-10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFriend.h"

@interface WFriendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)buttonClick:(id)sender;

-(void)configFriend:(MyFriend *)model add:(BOOL)flag;

@end
