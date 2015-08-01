//
//  CollectMoneyForHeader.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectDetailObject.h"
#import "CollectMoneyDetailViewController.h"

@interface CollectMoneyForHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *projectIntro;
@property (weak, nonatomic) IBOutlet UIButton *checkDetails;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic,strong)NSString * videoUnique;
@property (nonatomic,strong)NSString * videoName;
@property(nonatomic,weak)CollectMoneyDetailViewController * cdv;
@property(nonatomic,strong)NSString * shortContent;
@property(nonatomic,strong)NSString * longContent;

-(void)setCollectMoneyHeader:(ProjectDetailObject *)model;
@end
