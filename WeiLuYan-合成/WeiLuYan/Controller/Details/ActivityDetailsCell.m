//
//  ActivityDetailsCell.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ActivityDetailsCell.h"
#import "UIButton+WebCache.h"
#import "commentPersonObject.h"
#import "commentPersonObject.h"
#import "commentObject.h"
#import "PersonDetailObject.h"
#import "WMineViewController.h"

@implementation ActivityDetailsCell

- (void)awakeFromNib {
   
    _commentView.user_icon.layer.cornerRadius = _commentView.user_icon.frame.size.width/2;
    _commentView.user_icon.layer.masksToBounds = YES;
    _peopleView.user_icon.layer.cornerRadius = _peopleView.user_icon.frame.size.width/2;
    _peopleView.user_icon.layer.masksToBounds = YES;
    

}

-(void)setCellCommentData:(commentObject * )model
{
    _peopleView.hidden = YES;
    _commentView.hidden = NO;
    
    _commentView.ID = [model.comment_user_arr.member_id intValue];
    _commentView.controller = _controlller;
    
    
    commentPersonObject * perObj = model.comment_user_arr;
    
    if([perObj.avatar isEqualToString:@""])
    {
        [_commentView.user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:perObj.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"touxiang"]];
    }
    else
    {
        [_commentView.user_icon sd_setImageWithURL:[NSURL URLWithString:perObj.avatar] forState:UIControlStateNormal];
    }
    
    
    _commentView.nameLabel.text = [NSString stringWithFormat:@"%@",perObj.real_name];
    
    _commentView.introLabel.text = [NSString stringWithFormat:@"%@",model.content];
    
    //时间转化----等会再转
    
    NSString * timeSS = [NSString stringWithFormat:@"%@",model.time];
    long long beforTime = [timeSS longLongValue];
    _commentView.timeLabel.text = [self timeFormart:beforTime];
    
}
-(void)setCellPersonData:(PersonDetailObject *)model
{
    _peopleView.hidden = NO;
    _peopleView.flag = 0;
    _commentView.hidden = YES;
    
    _peopleView.ID = [model.member_id intValue];
    _peopleView.controller = _controlller;
    
    _peopleView.nameLabel.text = [NSString stringWithFormat:@"%@",model.real_name];
    _peopleView.officeLabel.text = [NSString stringWithFormat:@"%@",model.office];
    _peopleView.addLabel.text = [NSString stringWithFormat:@"%@",model.company];
    if([model.avatar isEqualToString:@""])
    {
        [_peopleView.user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"touxiang"]];
    }
    else
    {
        [_peopleView.user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal];
        
    }
    
    
}
-(NSString *)timeFormart:(long long)formartTime{
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:formartTime];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
