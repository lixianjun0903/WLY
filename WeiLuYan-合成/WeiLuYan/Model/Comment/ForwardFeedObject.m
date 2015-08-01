//
//  ForwardFeedObject.m
//  WeiLuYan
//
//  Created by 张亮 on 14/11/11.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "ForwardFeedObject.h"

@implementation ForwardFeedObject


-(id)initWithValueDic:(NSDictionary*)dataDic
{
    self=[super init];
    
    if (self)
    {
        [self setValueForProperty:dataDic];
        
    }
    return self;
}
-(void)setValueForProperty:(NSDictionary*)dataDic
{
    self.add_time_int=[[dataDic objectForKey:@"add_time_int"] intValue];
    self.add_time_txt=[dataDic objectForKey:@"add_time_txt"];
    self.approval_count=[[dataDic objectForKey:@"approval_count"] intValue];
    self.data_approval=(NSMutableDictionary*)[dataDic objectForKey:@"data_approval"];
    //    self.feedObject=[self getFeedObject:[dataDic objectForKey:@"data_feed"]];
    self.personModel=[self getPersonModel:[dataDic objectForKey:@"data_user"]];
    self.feedcontent_id=[[dataDic objectForKey:@"feedcontent_id"] intValue];
    self.forward_content=[dataDic objectForKey:@"forward_content"];
    self.content=[dataDic objectForKey:@"content"];
    self.forward_status=[[dataDic objectForKey:@"forward_status"] intValue];
    self.forward_title=[dataDic objectForKey:@"forward_title"];
    self.from_type=[[dataDic objectForKey:@"from_type"] intValue];
    self.hot_status=[[dataDic objectForKey:@"hot_status"] intValue];
    
    self.comment_count=[[dataDic objectForKey:@"comment_count"] intValue];
    self.pic_content=[dataDic objectForKey:@"pic_content"];
    self.recommend_status=[[dataDic objectForKey:@"recommend_status"] intValue];
    self.top_status=[[dataDic objectForKey:@"top_status"] intValue];
    self.video_content=[dataDic objectForKey:@"video_content"];
    self.video_content=[dataDic objectForKey:@"videoimg_content"];
    self.feed_type=[[dataDic objectForKey:@"feed_type"] intValue];
}

//-(FeedObject*)getFeedObject:(NSDictionary*)feedDic
//{
//    FeedObject*feed=nil;
//    if ([feedDic count]>0)
//    {
//
//        FeedObject*feed=[[FeedObject alloc]init];
//        [feed setValuesForKeysWithDictionary:feedDic];
//        feed.user=[[PersonalInfoModel alloc]init];
//        feed.user.avatar=[[feedDic objectForKey:@"user"] objectForKey:@"avatar"];
//        feed.user.member_id=[[[feedDic objectForKey:@"user"] objectForKey:@"member_id"] intValue];
//        feed.user.nick_name=[[feedDic objectForKey:@"user"] objectForKey:@"nickname"];
//        feed.user.real_name=[[feedDic objectForKey:@"user"] objectForKey:@"real_name"];
//        return feed;
//    }
//    return feed;
//}

-(PersonalInfoModel*)getPersonModel:(NSDictionary*)userDic
{
    PersonalInfoModel*person=[[PersonalInfoModel alloc]init];
    person.avatar=[userDic objectForKey:@"avatar"];
    if ([[userDic objectForKey:@"avatar"] length]==0)
    {
        NSLog(@"===============");
        person.avatar=@"http://tp3.sinaimg.cn/1672033274/180/5707296587/1";
    }else{
        
        person.avatar=[userDic objectForKey:@"avatar"];
    }
    person.member_id=(int)[[userDic objectForKey:@"member_id"] integerValue];
    [person setNick_name:[userDic objectForKey:@"nickname"]];
    [person setReal_name:[userDic objectForKey:@"real_name"]];
    return person;
}

@end
