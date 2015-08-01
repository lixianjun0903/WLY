//
//  WPortrait.m
//  WeiLuYan
//
//  Created by dev on 14/12/16.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WHeaderIcon.h"
#import "SJAvatarBrowser.h"
#import "PersonJudge.h"
#import "UIImageView+WebCache.h"
#import "WEditViewController.h"

@implementation WHeaderIcon
alloc_with_xib(WHeaderIcon)
-(void)awakeFromNib
{
    self.myImg.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //单击的次数
    [self.myImg addGestureRecognizer:singleRecognizer];
}

-(void)setviewDic:(PersonJudge *)mod
{
    //昵称
    _nameLabel.text=mod.nick_name;
    //性别
    if ([[NSString stringWithFormat:@"%d", mod.sex ] isEqual:@"0"])
    {
        _genderImg.image=[UIImage imageNamed:@""];
        
    }
    else if ([[NSString stringWithFormat:@"%d", mod.sex ] isEqual:@"1"])
    {
        _genderImg.image=[UIImage imageNamed:@"my2_male"];
    }
    else
    {
        _genderImg.image=[UIImage imageNamed:@"my2_femina"];
    }
    
    //加V认证
    if ([[NSString stringWithFormat:@"%d",mod.card_status]isEqual:@"0"]) {
        _VImg.image=[UIImage imageNamed:@""];
        
    }
    else if ([[NSString stringWithFormat:@"%d",mod.card_status]isEqual:@"1"])
    {
        _VImg.image=[UIImage imageNamed:@"my2_V"];
        
        
    }
    else
    {
        _VImg.image=[UIImage imageNamed:@""];
        
    }
    
    //职位
    if ([NSString stringWithFormat:@"%@",mod.job_status]!=nil &&  [NSString stringWithFormat:@"%@",mod.company ] !=nil)
    {
        _desLabel.text=[NSString stringWithFormat:@"%@,%@",mod.company,mod.job_status];
    }
    
    if ([mod.company  isEqualToString:@""] && [NSString stringWithFormat:@"%@", mod.job_status ]!=nil )
    {
        
        _desLabel.text=mod.job_status;
    }
    
    if ([mod.job_status  isEqualToString:@""] &&  [NSString stringWithFormat:@"%@",mod.company ] !=nil)
    {
        NSLog(@"eleleleele=%@",mod.company);
        _desLabel.text=mod.company;
    }
    
    if ([mod.job_status  isEqualToString:@""] &&[mod.company  isEqualToString:@""]) {
        _desLabel.text=@"";
    }
    //头像
    [_myImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar]placeholderImage:[UIImage imageNamed:@"default_user_L.png"]];
}

-(void)SingleTap:(UITapGestureRecognizer*)tap
{
    WEditViewController * edit = [WEditViewController new];
    [self.vc.navigationController pushViewController:edit animated:YES];
  
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
