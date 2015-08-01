//
//  WPortrait.h
//  WeiLuYan
//
//  Created by dev on 14/12/16.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonJudge;
@interface WHeaderIcon : UIView

@property (nonatomic,assign) UIViewController * vc;
@property (weak, nonatomic) IBOutlet UIImageView *myImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *VImg;
@property (weak, nonatomic) IBOutlet UIImageView *genderImg;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

-(void)setviewDic:(PersonJudge *)mod;

@end
