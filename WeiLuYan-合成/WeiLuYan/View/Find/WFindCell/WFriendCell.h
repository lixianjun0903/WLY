//
//  WFriendCell.h
//  WeiLuYan
//
//  Created by dev on 14/12/11.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoundFriendModel.h"

@interface WFriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *UserImageView;
@property (weak, nonatomic) IBOutlet UILabel *UserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *UserCompanyLabel;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (nonatomic,retain) NSString * UserId;

-(void)config:(FoundFriendModel *)model;

@end
