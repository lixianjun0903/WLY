//
//  ButtonView.m
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/4.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "FeedButtonView.h"
#import "AccountModel.h"
#import "UIButton+WebCache.h"
#import "FeedRequest.h"
#import "WCommentViewController.h"
#import "AppDelegate.h"
#import "new_userObject.h"

@implementation FeedButtonView

alloc_with_xib(ButtonView)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

-(void)awakeFromNib
{
    [self setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    _favoriteBtn.imageView.layer.cornerRadius = _favoriteBtn.frame.size.width/2;
    _favoriteBtn.imageView.layer.masksToBounds = YES;
    [self initView];
}

-(void)initView
{
    _favoriteLabel.font = [UIFont systemFontOfSize:13];
    _favoriteLabel.textColor = [UIColor colorWithRed:234/255.0 green:42/255.0 blue:42/255.0 alpha:1];
    [_emojiBtn addObserver:self forKeyPath:@"selected" options:0 context:nil];
}



-(void)setData:(CollectMoneyObject *)feed
{
    if(_Data != nil)
    {
        [_Data.data_approval removeObserver:self forKeyPath:@"is_approval"];
        

       [_Data removeObserver:self forKeyPath:@"project_comment_count"];

        [_Data removeObserver:self forKeyPath:@"project_comment_count"];

    }
    _Data = feed;
    
   
    [_Data.data_approval addObserver:self forKeyPath:@"is_approval" options:NSKeyValueObservingOptionNew context:nil];
    
    [_Data addObserver:self forKeyPath:@"project_comment_count" options:NSKeyValueObservingOptionNew context:nil];
    
    _favoriteBtn.selected = _Data.data_approval.is_approval;
    
    [self updateApproval];
//    [self updateComment];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([object isKindOfClass:[ApprovalMessage class]])
    {
        [self updateApproval];
    }
    
    if([object isKindOfClass:[CollectMoneyObject class]])
    {
        [self updateComment];
    }
    
}
-(void)setActData:(ActivityInfo *)data
{
    
    if(_ActData != nil)
    {
        [_ActData.data_approval removeObserver:self forKeyPath:@"is_approval"];
        
        //评论数

       //[_ActData removeObserver:self forKeyPath:@"comment_count"];

//        [_ActData removeObserver:self forKeyPath:@"comment_count"];

    }
    _ActData = data;
    
    
    [_ActData.data_approval addObserver:self forKeyPath:@"is_approval" options:NSKeyValueObservingOptionNew context:nil];
    //评论数
    [_Data addObserver:self forKeyPath:@"project_comment_count" options:NSKeyValueObservingOptionNew context:nil];
    
    _emojiBtn.selected = _Data.data_approval.is_approval;
    
    [self updateApproval];
    [self updateComment];

    
    
}
-(void) updateComment
{
    _commentLabel.text = [NSString stringWithFormat:@"%d", _ActData.comment_count];
    
}

//更新button图片
-(void)updateApproval
{
    _favoriteLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_ActData.data_approval.new_user count]];
    if(_ActData.data_approval.is_approval)
    {
        AccountModel * model = [AccountModel instance];
        NSString * str = model.personInfoModel.avatar;
        if(str.length == 0)
        {
            [_favoriteBtn setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
        }
        else
        {
            [_favoriteBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
        }
    }else if(_ActData.data_approval.new_user.count > 0)
    {
        NSString * url = ((new_userObject *)_ActData.data_approval.new_user[0]).avatar;
       if([url isEqualToString:@""])
       {
           [_favoriteBtn setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
       }else
       {
           [_favoriteBtn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
       }
        
}
    else
    {
        [_favoriteBtn setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    }
}

@end

