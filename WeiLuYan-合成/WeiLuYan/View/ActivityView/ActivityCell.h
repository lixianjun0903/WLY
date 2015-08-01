//
//  ActivityCell.h
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityHeaderView.h"
#import "ActivityContentView.h"
#import "ActivityButtonView.h"
#import "ActivityInfo.h"
#import "FeedApprovalView.h"

@interface ActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ActivityButtonView * buttonView;

@property (weak, nonatomic) IBOutlet ActivityContentView * activityContentView;


@property (weak, nonatomic) IBOutlet ActivityHeaderView * headerView;

@property(nonatomic,assign)UIViewController * Controller;
@property (nonatomic,assign) BOOL Style;
@property (nonatomic,assign) BOOL type;

@property (nonatomic,strong) FeedApprovalView * approvalView;
@property (nonatomic,strong) ActivityInfo * data;

-(void)setData:(ActivityInfo *)data;
+(CGFloat)getCellHeight:(BOOL)flag;
@end
