//
//  TableViewCell.h
//  WeiLuYan
//
//  Created by mac on 14/12/30.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoneyDetailObject.h"

@interface TeamMoneyCell : UITableViewCell
- (IBAction)expandClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *peopleCount;
@property (weak, nonatomic) IBOutlet UIView *expandView;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet UILabel *detail;
- (IBAction)agreeClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *limit;
@property (weak, nonatomic) IBOutlet UILabel *left;
@property (assign) int lsexpand;
-(void)setExpand:(int)Style;
-(void)config:(MoneyParks *)data;
@end
