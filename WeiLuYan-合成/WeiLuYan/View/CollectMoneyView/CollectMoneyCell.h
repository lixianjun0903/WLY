//
//  CollectMoneyCell.h
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectMoneyObject.h"
#import "CollectHeaderView.h"
#import "CollectContentView.h"
#import "CollectButtonView.h"
@interface CollectMoneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet CollectHeaderView *colHeaderView;
@property (weak, nonatomic) IBOutlet CollectContentView *colContentView;
@property (weak, nonatomic) IBOutlet CollectButtonView *colButtonView;
@property(nonatomic,weak)UIViewController * Controller;


-(void)setData:(CollectMoneyObject *)model;
@end
