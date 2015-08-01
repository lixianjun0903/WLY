//
//  investmentcellTableViewCell.m
//  WeiLuYan
//
//  Created by weiluyan on 14-10-17.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "investmentcellTableViewCell.h"

@implementation investmentcellTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _userimage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 35, 35)];
        _userimage.image=[UIImage imageNamed:@"touxiang"];
        [self  addSubview:_userimage];
        
        
        _name=[[UILabel alloc]initWithFrame:CGRectMake(60,0, 160, 30)];
        _name.text=@"潘石屹";
        _name.font=[UIFont systemFontOfSize:14];
        
        [self  addSubview:_name];
        
        
        _woek=[[UILabel alloc]initWithFrame:CGRectMake(60,20,160, 30)];
        _woek.text=@"xxx创始人";
        _woek.font=[UIFont systemFontOfSize:12];
        
        [self  addSubview:_woek];
        
        
        //friend_add
        
        _money=[[UILabel alloc]initWithFrame:CGRectMake(240,5,160, 20)];
        _money.text=@"5000元";
        _money.font=[UIFont systemFontOfSize:14];

        [self  addSubview:_money];

        _fen=[[UILabel alloc]initWithFrame:CGRectMake(160,5,100, 20)];
        _fen.text=@"25份";
        _fen.font=[UIFont systemFontOfSize:14];
        [self  addSubview:_fen];


        
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
