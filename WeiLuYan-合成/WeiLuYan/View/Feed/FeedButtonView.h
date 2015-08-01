//
//  ButtonView.h
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/4.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiveObject.h"
#import "CollectMoneyObject.h"
#import "ActivityInfo.h"

@interface FeedButtonView : UIView
@property (weak, nonatomic) IBOutlet UIButton *bgBtn;
@property (weak, nonatomic) IBOutlet UIButton *emojiBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (weak, nonatomic) IBOutlet UIButton *UpUserBtn;
@property (weak, nonatomic) IBOutlet UIButton *UpFavoriteBtn;
@property (weak, nonatomic) IBOutlet UIButton *UpCommentBtn;
@property (weak, nonatomic) IBOutlet UIButton *UpShareBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (nonatomic,strong) UIViewController * controller;

@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;


@property( nonatomic, strong) CollectMoneyObject * Data;
@property(nonatomic,strong)ActivityInfo * ActData;
@property( nonatomic, strong) PersonSimple * person;
@property( nonatomic, strong) ApprovalInfo * approval;


-(void)updateApproval;

@end
