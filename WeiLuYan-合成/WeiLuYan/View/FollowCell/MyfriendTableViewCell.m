//
//  MyfriendTableViewCell.m
//  WeiLuYan
//
//  Created by weiluyan on 14-10-14.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "MyfriendTableViewCell.h"
#import "PersonalInfoModel.h"


#import "UIImageView+WebCache.h"
#import "MyFriend.h"
@implementation MyfriendTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _userimage = [[UIImageView alloc] init];
        _userimage.frame = CGRectMake(10,5, 45, 45);
        _userimage.layer.masksToBounds =YES;
        
        _userimage.layer.cornerRadius =50;
        _userimage.layer.cornerRadius = _userimage.frame.size.height/2;
        _userimage.layer.masksToBounds = YES;
        [self   addSubview:_userimage];
        
        _friendBtnAdd=[UIButton buttonWithType:UIButtonTypeCustom];
        //        [_friendBtn setImage:[UIImage imageNamed:@"closed_W"] forState: UIControlStateNormal];
        //        [_friendBtn addTarget:self action:@selector(fanhuiBtn) forControlEvents:UIControlEventTouchUpInside];
        [self  addSubview:_friendBtnAdd];
        
        _name=[[UILabel alloc]initWithFrame:CGRectMake(70,0, 160, 40)];
        //        _name.text=mod.user_name;
        _name.font=[UIFont systemFontOfSize:15];
        [self  addSubview:_name];
        
        _woek=[[UILabel alloc]initWithFrame:CGRectMake(70,20,160, 40)];
        _woek.font=[UIFont systemFontOfSize:12];
        [self  addSubview:_woek];
        
        //friend_add
        _friendBtnAdd=[UIButton  buttonWithType:UIButtonTypeCustom];
        [_friendBtnAdd setBackgroundImage:[UIImage imageNamed:@"myf_Chat_button"] forState:UIControlStateNormal];
        _friendBtnAdd.frame=CGRectMake(245, 10,60, 35);
        [self  addSubview:_friendBtnAdd];
        //
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}
-(void)friednbtn:(MyFriend*)mod
{
    NSLog(@"usernamame=%@",mod.friend_user_name);
    NSLog(@"jobdddddd=%@",mod.friend_user_job);
    NSLog(@"dadadddadofff=%@",mod.friend_user_office);
    NSLog(@"daffererididid=%d",mod.is_apply);
    NSLog(@"mdomdofrom_type=%@",mod.from_type);
    
    _woek.text=mod.from_type;
    if (mod.is_apply ==0) {
        NSLog(@"is_apple=0000");
        _friendBtnAdd.hidden=NO;

        [_friendBtnAdd setImage:[UIImage imageNamed:@"friend_add"] forState: UIControlStateNormal];
        [_friendBtnAdd setFrame:CGRectMake(250,5, _friendBtnAdd.imageView.image.size.width, _friendBtnAdd.imageView.image.size.height)];
        
    }else if (mod.is_apply ==1)
    {
        
        NSLog(@"is_apple=1111");
        _friendBtnAdd.hidden=YES;
        
    }else if (mod.is_apply==2)
    {
        NSLog(@"is_apple=222");
        
        [_friendBtnAdd setImage:[UIImage imageNamed:@"friend_add"] forState: UIControlStateNormal];
        [_friendBtnAdd setFrame:CGRectMake(250,5, _friendBtnAdd.imageView.image.size.width, _friendBtnAdd.imageView.image.size.height)];
        _friendBtnAdd.hidden=NO;

        
    }else
    {
    }
    [_userimage    sd_setImageWithURL:[NSURL URLWithString:mod.friend_user_icon] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    if ([mod.friend_user_name  isEqualToString:@""])
    {
        _name.text=mod.friend_nick_name;
    }else {
        _name.text=mod.friend_user_name;
    }
    
    
    //判断职位
//    if ([NSString stringWithFormat:@"%@",mod.friend_user_job]!=nil &&  [NSString stringWithFormat:@"%@",mod.friend_user_office ] !=nil)
//    {
//        _woek.text=[NSString stringWithFormat:@"%@,%@",mod.friend_user_office,mod.friend_user_job];
//    } if ([mod.friend_user_office  isEqualToString:@""] && [NSString stringWithFormat:@"%@", mod.friend_user_job ]!=nil )
//    {
//        
//        _woek.text=mod.friend_user_job;
//    } if ([mod.friend_user_job  isEqualToString:@""] &&  [NSString stringWithFormat:@"%@",mod.friend_user_office ] !=nil)
//    {
//        NSLog(@"eleleleele=%@",mod.friend_user_office);
//        _woek.text=mod.friend_user_office;
//    }if ([mod.friend_user_job  isEqualToString:@""] &&[mod.friend_user_office  isEqualToString:@""]) {
//        _woek.text=@"";
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
