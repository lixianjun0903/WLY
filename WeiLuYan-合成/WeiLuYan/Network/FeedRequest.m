//
//  FeedRequest.m
//  WeiLuYan
//
//  Created by 张亮 on 14/11/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "FeedRequest.h"
#import "ForwardFeedObject.h"
#import "ActiveObject.h"
#import "CollectMoneyObject.h"
#import "ActivityInfo.h"
#import "ActivityDetailInfo.h"

@implementation FeedRequest

//项目分享
+(void)shareProject:(void(^)(ShareObject * data))succ fail:(void (^)(int, NSError *))fail ID:(int)projectId
{
    [self postRequestWithToken:@"common/toShare" param:@{@"pid":[NSNumber numberWithInt:projectId]} succ:succ fail:fail resp:[ShareObject class]];
}

+(AFRequestState *)getFeedRequest:(void (^)(NSArray * feedDic))succ :(int)pageIndex
{
    return [self postRequestWithToken:@"feed/lists" param:@{@"p":[NSNumber numberWithInt:pageIndex]} succ:succ resp:[ActivityInfo class]];
}

+(AFRequestState *)deleteFeed:(void (^)(NSDictionary*feedDic))succ :(int)feedID
{
    return [self postRequestWithToken:@"feed/delete" param:@{@"feedcontent_id":[NSNumber numberWithInt:feedID]} succ:succ];
}

+(AFRequestState *)likeFeed:(void (^)(NSDictionary*feedDic))succ :(int)feedID
{
    return [self postRequestWithToken:@"feed/addApproval" param:@{@"feedcontent_id":[NSNumber numberWithInt:feedID]} succ:succ];
}

+(AFRequestState *)dislikeFeed:(void (^)(NSDictionary*feedDic))succ :(int)feedID
{
    return [self postRequestWithToken:@"feed/cansleApproval" param:@{@"feedcontent_id":[NSNumber numberWithInt:feedID]} succ:succ];
}
+(AFRequestState *)getActivityDetailRequest:(void (^)(ActivityDetailInfo * feedDic))succ :(int)pageIndex
{
    return [self postRequestWithToken:@"feed/detail" param:@{@"feedcontent_id":[NSNumber numberWithInt:pageIndex]} succ:succ resp:[ActivityDetailInfo class]];
}
@end
