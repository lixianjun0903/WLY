//
//  CollectHeaderView.h
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/5.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectMoneyObject.h"
@interface CollectHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property(nonatomic,weak)UIViewController * Controller;
@property(nonatomic,strong)CollectMoneyObject * data;
-(void)setColHeaderData:(CollectMoneyObject *)model;
@end
