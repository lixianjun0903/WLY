//
//  FeedRequest.h
//  WeiLuYan
//
//  Created by 张亮 on 14/11/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AFAppRequest.h"
#import "ActivityDetailInfo.h"
#import "ShareObject.h"

@interface FeedRequest : AFAppRequest

//项目分享
+(void)shareProject:(void(^)(ShareObject * data))succ fail:(void (^)(int errCode, NSError * err))fail ID:(int)projectId;
//获得项目列表
+(AFRequestState *)getFeedRequest:(void (^)(NSArray * feedDic))succ :(int)pageIndex;
//删除动态
+(AFRequestState *)deleteFeed:(void (^)(NSDictionary*feedDic))succ :(int)feedID;
//项目点赞
+(AFRequestState *)likeFeed:(void (^)(NSDictionary*feedDic))succ :(int)feedID;
//项目取消点赞
+(AFRequestState *)dislikeFeed:(void (^)(NSDictionary*feedDic))succ :(int)feedID;
//动态详情页
+(AFRequestState *)getActivityDetailRequest:(void (^)(ActivityDetailInfo * feedDic))succ :(int)pageIndex;

@end
