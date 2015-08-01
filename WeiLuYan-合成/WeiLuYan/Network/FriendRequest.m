//
//  FriendRequest.m
//  WeiLuYan
//
//  Created by dev on 14/12/4.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "FriendRequest.h"
#import "FoundFriendModel.h"

@implementation FriendRequest


+(void)friendReq:(void (^)(NSArray *))succ :(int)job_status :(int)page
{
    NSDictionary * pageParameter = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:job_status],@"job_status",[NSNumber numberWithInt:page],@"page", nil];
    
    [self postRequestWithToken:@"/found/user" param:pageParameter succ:succ resp:[FoundFriendModel class]];
}

+(AFRequestState *)getFriendRequest:(void (^)(NSArray *))succ :(int)job_status :(int)pageIndex
{
    NSDictionary * pageParameter = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:job_status],@"job_status",[NSNumber numberWithInt:pageIndex],@"page", nil];
    return [self postRequestWithToken:@"/found/user" param:pageParameter succ:succ resp:[FoundFriendModel class]];
}

+(void)addFriend:(void (^)(NSNumber *))succ :(NSString *)usr_Id
{
    NSDictionary * paraDic = [NSDictionary dictionaryWithObjectsAndKeys:usr_Id,@"user_id",nil];
    [self postRequestWithToken:@"/friend/addFriend" param:paraDic succ:succ];
}

@end
