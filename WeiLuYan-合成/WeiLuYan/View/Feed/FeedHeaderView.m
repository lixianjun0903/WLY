//
//  HeaderView.m
//  WeiLuYan
//
//  Created by 张亮 on 14-10-8.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "FeedHeaderView.h"
//#import "FeedObject.h"
#import "PersonalInfoModel.h"
#import "UIButton+WebCache.h"
#import "PersonSimple.h"
#import "CollectMoneyRequest.h"
#import "MBProgressHUD+Show.h"

@interface FeedHeaderView ()

{
    int selectId;
    
    BOOL isCollected;
}

@end


@implementation FeedHeaderView

alloc_with_xib(HeaderView)

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_userIcon.layer setCornerRadius:CGRectGetHeight([_userIcon bounds]) / 2];
    _userIcon.layer.masksToBounds = YES;
    
    _collectBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;

}

-(void)removeBtnTargets
{
    [_collectBtn removeTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchDown];
    [_collectBtn removeTarget:self action:@selector(unCollectClick:) forControlEvents:UIControlEventTouchDown];
}

-(void)collectClick:(UIButton *)sender
{
    [self removeBtnTargets];
    isCollected = NO;
    selectId = sender.tag;
    
    [CollectMoneyRequest collectFinanceCollectWithId:selectId with:^(NSDictionary *result) {
        //成功
        [_collectBtn setImage:[UIImage imageNamed:@"ic_collect_highlight"] forState:UIControlStateNormal];
        
        isCollected = YES;
        
        [MBProgressHUD creatembHub:@"关注成功"];
        [_collectBtn addTarget:self action:@selector(unCollectClick:) forControlEvents:UIControlEventTouchDown];
        
    }];
    
}

-(void)unCollectClick:(UIButton *)sender
{
    [self removeBtnTargets];
    isCollected = YES;
    selectId = sender.tag;
    
    [CollectMoneyRequest collectFinanceUnCollectWithId:selectId with:^(NSDictionary *result) {
        
        [_collectBtn setImage:[UIImage imageNamed:@"ic_collect_normal"] forState:UIControlStateNormal];
        
        isCollected = NO;
        
        [MBProgressHUD creatembHub:@"已取消关注"];
        [_collectBtn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchDown];
        
    }];
    
}


-(void)setCollectPersonInfo:(CollectMoneyObject *)data
{
    [_userIcon sd_setBackgroundImageWithURL:[NSURL URLWithString:data.approval_user_avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    _nameLabel.text = data.project_user_name;
    
}

-(void)setPersonInfo:(CollectMoneyObject *)data
{
    [_userIcon sd_setBackgroundImageWithURL:[NSURL URLWithString:data.project_user_avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"touxiang"]];
    _nameLabel.text = data.project_user_name;
    [self timeTransform:data.project_update_time];
    
    NSLog(@"%@",data.favorite_status);
    if ([data.favorite_status intValue] == 1) {
        
        isCollected = YES;
        [_collectBtn setImage:[UIImage imageNamed:@"ic_collect_highlight"] forState:UIControlStateNormal];
        _collectBtn.tag = [data.project_id intValue];
        
        [self removeBtnTargets];

        [_collectBtn addTarget:self action:@selector(unCollectClick:) forControlEvents:UIControlEventTouchDown];
    }
    else
    {
        isCollected = NO;
        [_collectBtn setImage:[UIImage imageNamed:@"ic_collect_normal"] forState:UIControlStateNormal];
        _collectBtn.tag = [data.project_id intValue];
        
        [self removeBtnTargets];

        [_collectBtn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchDown];
    }

}
-(void)setActivityInfo:(ActivityInfo *)data
{
    DataUserObject * dataObj = data.data_user;
    [_userIcon sd_setBackgroundImageWithURL:[NSURL URLWithString:dataObj.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"touxiang"]];
    _nameLabel.text = dataObj.nickname;
    
    [self timeTransform:data.add_time_int];
    
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


@end
