//
//  MyfriendTableViewCell.h
//  WeiLuYan
//
//  Created by weiluyan on 14-10-14.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyFriend;
@interface MyfriendTableViewCell : UITableViewCell

@property(nonatomic,retain)UIImageView *userimage;
@property(nonatomic,retain)UILabel *name;
@property(nonatomic,retain)UILabel *woek;
@property(nonatomic,retain)UIButton *friendBtnAdd;
-(void)friednbtn:(MyFriend*)mod;

@end
