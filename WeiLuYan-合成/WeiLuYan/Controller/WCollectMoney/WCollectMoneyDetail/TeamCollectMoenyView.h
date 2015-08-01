//
//  TeamCollectMoenyView.h
//  WeiLuYan
//
//  Created by mac on 14/12/29.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoneyDetailObject.h"

@interface TeamCollectMoenyView : UIView
@property (weak, nonatomic) IBOutlet UIProgressView *moneyProgress;
@property (weak, nonatomic) IBOutlet UILabel *progressLab;
@property (weak, nonatomic) IBOutlet UILabel *alreadyMoney;
@property (weak, nonatomic) IBOutlet UILabel *leftTime;
@property (weak, nonatomic) IBOutlet UITableView *moneydetailTableView;
@property (strong,nonatomic) NSMutableDictionary * expand;
@property (assign) int Expands;
-(void)setCollectPro:(MoneyDetailObject *)data;
@end
