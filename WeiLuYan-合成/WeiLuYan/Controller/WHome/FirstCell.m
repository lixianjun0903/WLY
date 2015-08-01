//
//  FirstCell.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/20.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "FirstCell.h"
#import "UIButton+WebCache.h"

@interface FirstCell()

@property (nonatomic,strong) attentionObject * obj;

@end

@implementation FirstCell

- (void)awakeFromNib {
    _user_icon.layer.masksToBounds = YES;
    _user_icon.layer.cornerRadius = _user_icon.frame.size.width/2;
}

-(void)setCellData:(attentionObject *)data attention:(BOOL)attention
{
    _is_attention = attention;
    _obj = data;
    if([data.avatar isEqualToString:@""]){
        [_user_icon setBackgroundImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    }
    else{
        [_user_icon sd_setBackgroundImageWithURL:[NSURL URLWithString:data.avatar] forState:UIControlStateNormal];
    }
    _attentionBtn.tag = data.member_id;
    _nameLabel.text = data.real_name;
    _companyLabel.text = data.company;
    
    [self refreshButton];
}

- (IBAction)attentionClick {
    _is_attention = !_is_attention;
    [self refreshButton];
    if(_is_attention){
        self.attention(_obj.member_id);
    }
    else{
        self.cancleAttention(_obj.member_id);
    }
}

-(void)refreshButton
{
    if(_is_attention){
        [_attentionBtn setBackgroundImage:[UIImage imageNamed:@"btn_choice"] forState:UIControlStateNormal];
    }
    else{
        [_attentionBtn setBackgroundImage:[UIImage imageNamed:@"btn_box_default"] forState:UIControlStateNormal];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
