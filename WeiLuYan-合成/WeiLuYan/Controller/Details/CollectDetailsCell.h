//
//  CollectDetailsCell.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailInfo.h"
#import "commentView.h"
#import "peopleView.h"
#import "investView.h"
#import "MoneyDetailObject.h"
#import "TeamPeopleObject.h"
#import "NewCommentObject.h"
#import "InvestPeopleObject.h"
#import "CollectParkObject.h"
@interface CollectDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet commentView *commentView;
@property (weak, nonatomic) IBOutlet peopleView *peopleView;
@property (weak, nonatomic) IBOutlet investView *investView;

@property(nonatomic,assign)UIViewController * controller;

-(void)setPeopleData:(TeamPeopleObject * )model;
-(void)setCommentData:(NewCommentObject *)model;
-(void)setInvestPeopleData:(InvestPeopleObject *)model;
-(void)setInvestParkData:(CollectParkObject * )model;

@end
