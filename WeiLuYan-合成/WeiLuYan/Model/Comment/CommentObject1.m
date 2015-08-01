//
//  CommentObject.m
//  WeiLuYan
//
//  Created by 张亮 on 14/11/13.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "CommentObject1.h"

@implementation CommentObject1

-(id)initWithValueDic:(NSDictionary*)dataDic
{
    self=[super init];
    
    if (self)
    {
        [self setCommentValue:dataDic];
        
    }
    return self;
}
-(void)setCommentValue:(NSDictionary*)commentDic
{
   
    if ([[commentDic objectForKey:@"comment_user_arr"] count]>0) {
          self.commentPersonModel=[[PersonalInfoModel alloc]init];
     self.commentPersonModel.avatar=[[commentDic objectForKey:@"comment_user_arr"] objectForKey:@"avatar"];
     self.commentPersonModel.member_id=[[[commentDic objectForKey:@"comment_user_arr"] objectForKey:@"member_id"] intValue];
    self.commentPersonModel.nick_name=[[commentDic objectForKey:@"comment_user_arr"] objectForKey:@"nickname"];
     self.commentPersonModel.real_name=[[commentDic objectForKey:@"comment_user_arr"] objectForKey:@"real_name"];
    }
  
    self.commentContent=[commentDic objectForKey:@"content"];
    if ([[commentDic objectForKey:@"reply_user_arr"] count]>0)
    {
        self.replyPersonModel=[[PersonalInfoModel alloc]init];
        self.replyPersonModel.avatar=[[commentDic objectForKey:@"reply_user_arr"] objectForKey:@"avatar"];
        self.replyPersonModel.member_id=[[[commentDic objectForKey:@"reply_user_arr"] objectForKey:@"member_id"] intValue];
        self.replyPersonModel.nick_name=[[commentDic objectForKey:@"reply_user_arr"] objectForKey:@"nickname"];
        self.replyPersonModel.real_name=[[commentDic objectForKey:@"reply_user_arr"] objectForKey:@"real_name"];
    }
    NSDate*date=[NSDate dateWithTimeIntervalSince1970:[[commentDic objectForKey:@"time"] intValue]];
    self.timeStr=[GeneralizedProcessor getMessageDatetimeStr:date :NO];
  }
@end
