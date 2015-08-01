//
//  ActivityHeaderView.m
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/4.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ActivityHeaderView.h"
#import "UIButton+WebCache.h"
#import "DataUserObject.h"
#import "WMineViewController.h"

@implementation ActivityHeaderView
alloc_with_xib(ActHeaderView)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    
    return self;
}
-(void)awakeFromNib
{
    _user_icon.layer.masksToBounds = YES;
    _user_icon.layer.cornerRadius = _user_icon.frame.size.width / 2;
}

-(void)setHeaderData:(ActivityInfo *)model
{
    _ActData = model;
    
    DataUserObject * dataObj = model.data_user;
    [_user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:dataObj.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"touxiang"]];
    _nameLabel.text = dataObj.nickname;
    
    [self timeTransform:model.add_time_int];
}
-(void)timeTransform:(NSString *)time
{
    if(!time){
        _timeLabel.text = @"";
        return;
    }
    //时间判断
    NSString * timeSS = [NSString stringWithFormat:@"%@",time];
    long long beforTime = [timeSS longLongValue];
    NSDate * nowTime = [NSDate date];
    long long nowInterval = [nowTime timeIntervalSince1970];
    long long nowtimeNum= nowInterval;
    
    long long subtime = nowtimeNum - beforTime;
    
    if(subtime > 72 * 3600)
    {
        _timeLabel.text = [self timeFormart:beforTime];
    }
    //前天
    if(subtime > 48 * 3600 && subtime < 72 * 3600)
    {
        NSString *time = [self timeFormart:beforTime];
        time = [time substringFromIndex:10];
        _timeLabel.text = [NSString stringWithFormat:@"前天%@",time];
    }
    //
    if(subtime > 24 * 3600 && subtime < 48 * 3600)
    {
        NSString *time = [self timeFormart:beforTime];
        time = [time substringFromIndex:10];
        _timeLabel.text = [NSString stringWithFormat:@"昨天%@",time];
    }
    if(subtime > 3600 && subtime < 24 * 3600)
    {
        _timeLabel.text = [NSString stringWithFormat:@"%lld小时前",subtime / 3600];
        
    }
    if(subtime > 60 && subtime < 3600)
    {
        _timeLabel.text = [NSString stringWithFormat:@"%lld分钟前",subtime / 60];
    }
    //一分钟内
    if (subtime<60) {
        _timeLabel.text = [NSString stringWithFormat:@"%lld秒前",subtime];
    }
    
}

-(NSString *)timeFormart:(long long)formartTime{
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:formartTime];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

- (IBAction)userIconClick:(id)sender {
    
    WMineViewController * vc = [[WMineViewController alloc] init];
    vc.useridd = _ActData.data_user.member_id;
    [_Controller.navigationController pushViewController:vc animated:YES];
}
@end
