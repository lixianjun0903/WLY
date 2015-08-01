//
//  ActivityButtonView.h
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityInfo.h"
#import "descAlertView.h"

@interface ActivityButtonView : UIView

@property (weak, nonatomic) IBOutlet UIButton *userApprovalBtn;

@property (weak, nonatomic) IBOutlet UIButton *approvalBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *approvalCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property(nonatomic,strong)ActivityInfo * ActData;
@property(nonatomic,weak)UIViewController * Controller;
@property(nonatomic,assign)int ID;
@property (nonatomic,strong) descAlertView * alert;
@property (nonatomic,strong) UILabel * addLabel;
@property (nonatomic,assign) BOOL isExpand;

@property (nonatomic,copy) void (^ click)();
@property (nonatomic,copy) void (^approval)(ApprovalObject *);

-(void)setButtonData:(ActivityInfo *)model;
@end
