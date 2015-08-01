//
//  CollectContentView.h
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectMoneyObject.h"

@interface CollectContentView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *projectImg;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *precentLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property(nonatomic,weak)UIViewController * Controller;
@property (weak, nonatomic) IBOutlet UIView *viewBG;


-(void)setContentData:(CollectMoneyObject *)model;
@end
