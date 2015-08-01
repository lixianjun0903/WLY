//
//  MyLaberTableViewCell.h
//  tabviewcon
//
//  Created by weiluyan on 15/2/2.
//  Copyright (c) 2015年 JX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLaberTableViewCell : UITableViewCell
@property (nonatomic ,strong) UIView *myView;
@property (nonatomic ,strong) NSMutableArray *myArry;
@property (nonatomic ,strong) UILabel *userLaber;

//+ (instancetype)cellWithTableView:(UITableView *)tableView;
-(void)setLabertext:(NSMutableArray*)laberArray;
@end
