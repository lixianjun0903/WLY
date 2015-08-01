//
//  UserTableViewCell.m
//  tabviewcon
//
//  Created by weiluyan on 15/2/2.
//  Copyright (c) 2015年 JX. All rights reserved.
//

#import "UserTableViewCell.h"
#import "GeneralizedProcessor.h"
#import "UIImageView+WebCache.h"
#import "WEditViewController.h"
#import "AppDelegate.h"

@implementation UserTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"UserTableViewCell";
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserTableViewCell" owner:self options:nil] lastObject];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)awakeFromNib
{
    _userIcon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //单击的次数
    [_userIcon addGestureRecognizer:singleRecognizer];
}
-(void)setmod:(NSDictionary*)dic
{
    
    _userJob.text=[dic objectForKey:@"job"];
    _userName.text=[dic objectForKey:@"name"];

    //头像
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"avatar"]]placeholderImage:[UIImage imageNamed:@"default_user_L.png"]];

    _userIcon.layer.masksToBounds = YES;
    _userIcon.layer.cornerRadius = _userIcon.frame.size.width/2;


}
-(void)SingleTap:(UITapGestureRecognizer*)tap
{
    WEditViewController * edite = [WEditViewController new];
    
    [[AppDelegate getNav] pushViewController:edite animated:YES];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
