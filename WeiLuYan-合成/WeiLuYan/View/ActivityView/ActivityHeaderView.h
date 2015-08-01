//
//  ActivityHeaderView.h
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/4.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityInfo.h"

@interface ActivityHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *user_icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property(nonatomic,strong)ActivityInfo * ActData;
@property(nonatomic,strong)UIViewController * Controller;

-(void)setHeaderData:(ActivityInfo * )model;
@end
