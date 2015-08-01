//
//  commentView.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailViewController.h"
@interface commentView : UIView
@property (weak, nonatomic) IBOutlet UIButton *user_icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property(nonatomic,assign)int ID;

@property(nonatomic,weak)UIViewController * controller;
@end
