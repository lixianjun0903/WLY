//
//  CollectDetailsCell.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "CollectDetailsCell.h"
#import "UIButton+WebCache.h"
#import "GeneralizedProcessor.h"


@implementation CollectDetailsCell

- (void)awakeFromNib {
    
    _commentView.user_icon.layer.cornerRadius = 25;
    _commentView.user_icon.layer.masksToBounds = YES;
    _peopleView.user_icon.layer.cornerRadius = 25;
    _peopleView.user_icon.layer.masksToBounds = YES;
    
}

-(void)setPeopleData:(TeamPeopleObject *)model
{
    _peopleView.flag = 0;
    _commentView.hidden = YES;
    _peopleView.hidden = NO;
    _investView.hidden = YES;
    _peopleView.controller = _controller;
    _peopleView.ID = [model.U_ID intValue];
    
    
    if([model.U_Avator isEqualToString:@""])
    {
        [_peopleView.user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.U_Avator]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"touxiang"]];
    }
    else
    {
        [_peopleView.user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.U_Avator] forState:UIControlStateNormal];
    }
    
    _peopleView.nameLabel.text = [NSString stringWithFormat:@"%@",model.U_Nick_Name];
    
}

-(void)setInvestPeopleData:(InvestPeopleObject *)model
{
    _investView.hidden = YES;
    _peopleView.flag = 1;
    
    if ([model.U_Avator isEqualToString:@""]) {
        [_peopleView.user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.U_Avator] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"touxiang"]];
        
    }
    else
    {
        [_peopleView.user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.U_Avator] forState:UIControlStateNormal];
    }
    _peopleView.nameLabel.text = [NSString stringWithFormat:@"%@",model.U_Nick_Name];
    _peopleView.moneyLabel.text = [NSString stringWithFormat:@"￥%d万",model.C_BackPrice];
    _peopleView.officeLabel.text = [NSString stringWithFormat:@"%@",model.U_User_Office];
    _peopleView.addLabel.text = [NSString stringWithFormat:@"%@",model.U_User_Company];
}
-(void)setCommentData:(NewCommentObject *)model
{
    _commentView.hidden = NO;
    _peopleView.hidden = YES;
    _investView.hidden = YES;
    _commentView.controller = _controller;
    _commentView.ID = [model.U_ID intValue];
    
    _commentView.nameLabel.text = model.U_Nick_Name;
    if ([model.U_Avator isEqualToString:@""]) {
        [_commentView.user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.U_Avator] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"touxiang"]];
    }
    else
    {
        [_commentView.user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.U_Avator] forState:UIControlStateNormal];
    }
    _commentView.timeLabel.text = [GeneralizedProcessor getDateString:[model.U_CommentTime floatValue]];
    _commentView.introLabel.text = model.C_CommentDetail;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setInvestParkData:(CollectParkObject *)model
{
    _commentView.hidden = YES;
    _peopleView.hidden = YES;
    _investView.hidden = NO;
    
    _investView.MoneyLabel.text = [NSString stringWithFormat:@"%d万",model.C_Park_Price];
    _investView.parkLabel.text = [NSString stringWithFormat:@"%@",model.C_Park_Name];
    _investView.introLabel.text = [NSString stringWithFormat:@"%@",model.C_Park_Description];
    
    
}

@end
