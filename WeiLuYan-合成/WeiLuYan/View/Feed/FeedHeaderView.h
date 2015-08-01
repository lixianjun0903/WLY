//
//  HeaderView.h
//  WeiLuYan
//
//  Created by 张亮 on 14-10-8.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonIndexPath.h"
#import "ActivityInfo.h"
#import "CollectMoneyObject.h"

@class FeedObject;
@class PersonalInfoModel;
@class PersonSimple;

@interface FeedHeaderView : UIView <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

//@property( nonatomic, strong) UILabel * nameLabl;
//@property( nonatomic, strong) UIView * dateTimeAndTimePic;
//
//@property( nonatomic, strong) UIButton * userIcon;
//
//@property( nonatomic, strong) UIImageView * time;
//@property( nonatomic, strong) UILabel * timeStr;
-(void)setCollectPersonInfo:(CollectMoneyObject *)data;
//-(void)setPersonInfo:(PersonSimple*)dataUser;
-(void)setPersonInfo:(CollectMoneyObject *)data;
-(void)setActivityInfo:(ActivityInfo *)data;
@end
