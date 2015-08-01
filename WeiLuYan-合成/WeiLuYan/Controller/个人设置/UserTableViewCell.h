//
//  UserTableViewCell.h
//  tabviewcon
//
//  Created by weiluyan on 15/2/2.
//  Copyright (c) 2015年 JX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userJob;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (nonatomic,assign) UIViewController * vc;

-(void)setmod:(NSDictionary*)dic;

@end
