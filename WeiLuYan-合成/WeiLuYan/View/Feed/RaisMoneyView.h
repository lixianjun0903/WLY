//
//  RaisMoneyView.h
//  WeiLuYan
//
//  Created by 张亮 on 14-9-29.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCollectMoneyViewController.h"
#import "CollectMoneyObject.h"

@interface RaisMoneyView : UIView
@property (weak, nonatomic) IBOutlet UIView *contentBgView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *mediaView;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UILabel *raiseMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UIView *viewBG;
@property (nonatomic,strong)WCollectMoneyViewController * wvc;


-(void)setData:(CollectMoneyObject *)data;

@end
