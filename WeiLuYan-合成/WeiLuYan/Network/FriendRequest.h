//
//  FriendRequest.h
//  WeiLuYan
//
//  Created by dev on 14/12/4.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AFAppRequest.h"

@interface FriendRequest : AFAppRequest
//
+(void)friendReq:(void (^)(NSArray * result))succ :(int)job_status :(int)page;
+(void)addFriend:(void(^)(NSNumber * result))succ :(NSString *)usr_Id;
+(AFRequestState *)getFriendRequest:(void (^)(NSArray * feedDic))succ :(int)job_status :(int)pageIndex;

@end
