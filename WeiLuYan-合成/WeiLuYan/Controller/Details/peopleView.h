//
//  peopleView.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItemCell.h"
#import "ActivityDetailInfo.h"

@interface peopleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *officeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UIButton *user_icon;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property(nonatomic,assign)int ID;
@property(nonatomic,assign)UIViewController * controller;

@property(nonatomic,assign)int flag;


@end
