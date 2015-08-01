//
//  WLY_CommentTableViewCell.m
//  WeiLuYan
//
//  Created by 张亮 on 14-9-23.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WLY_CommentTableViewCell.h"
#import "UIButton+WebCache.h"

#import "PersonalInfoModel.h"


#define ICON_AND_WORD_LEFT_AND_RIGHT 15
#define USER_LEVEL_WIDTH_HEIGHT 15
@implementation WLY_CommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
          self.selectionStyle=UITableViewCellSelectionStyleNone;
        _commentUserIcon=[UIButton buttonWithType:UIButtonTypeCustom];
        [_commentUserIcon setFrame:CGRectMake(ICON_AND_WORD_LEFT_AND_RIGHT, 14, 30, 30)];
        [_commentUserIcon.layer setCornerRadius:CGRectGetHeight([_commentUserIcon bounds]) / 2];
        _commentUserIcon.layer.masksToBounds = YES;
        [self addSubview:_commentUserIcon];
        
//        _userLevlIcon=[[UIImageView alloc]initWithFrame:CGRectMake(ICON_AND_WORD_LEFT_AND_RIGHT+22, _commentUserIcon.frame.origin.y+16, USER_LEVEL_WIDTH_HEIGHT,USER_LEVEL_WIDTH_HEIGHT)];
//        [_userLevlIcon setImage:[UIImage imageNamed:@"iconV"]];
//        [self addSubview:_userLevlIcon];
        
        _userNameLable=[[UILabel alloc]initWithFrame:CGRectMake( _commentUserIcon.frame.origin.x+ _commentUserIcon.frame.size.width+10,0, 80, 40)];
        [_userNameLable setFont:[UIFont systemFontOfSize:13]];
        [_userNameLable setTextColor:[GeneralizedProcessor hexStringToColor:@"#1a1a1a"]];
       [self addSubview:_userNameLable];
        
        _commentContent=[[UILabel alloc]initWithFrame:CGRectMake( _userNameLable.frame.origin.x,_userNameLable.frame.origin.y+_userNameLable.frame.size.height,0,0)];
        [_commentContent setTextColor:[GeneralizedProcessor hexStringToColor:@"#5a5a5a"]];
        [self addSubview:_commentContent];
        
        _comentDate=[[UILabel alloc]initWithFrame:CGRectMake(232, 14, 66, 12)];
        [_comentDate setFont:[UIFont systemFontOfSize:9]];
        [self addSubview:_comentDate];
        [_comentDate setTextColor:[GeneralizedProcessor hexStringToColor:@"#b4b4b4"]];

    }
    return self;
}

-(void)setCommentObjectValue:(CommentObject1*)commentObject
{

    [_commentUserIcon sd_setImageWithURL:[NSURL URLWithString:commentObject.commentPersonModel.avatar] forState:UIControlStateNormal];
    [_userNameLable setText:commentObject.commentPersonModel.nick_name];
    
    NSString*content=@"";
    if (commentObject.replyPersonModel!=nil)
    {
  
     content=[NSString stringWithFormat:@"回复%@ : %@",commentObject.replyPersonModel.nick_name,commentObject.commentContent];
    }else
    {
        content=commentObject.commentContent;
     }
    
    [GeneralizedProcessor setLableNewFrameFromText:_commentContent :content :[UIFont systemFontOfSize:12] :self.frame.size.width-70 ];
    [_comentDate setText:commentObject.timeStr];
    
}

-(CGFloat)getHeightFrom:(CommentObject1*)commentObject
{
    [self setCommentObjectValue:commentObject];
    return   _commentUserIcon.frame.size.height+_commentContent.frame.size.height+24;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
