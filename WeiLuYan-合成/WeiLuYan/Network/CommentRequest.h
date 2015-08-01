//
//  CommentRequest.h
//  WeiLuYan
//
//  Created by 张亮 on 14/11/13.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AFAppRequest.h"

@interface CommentRequest : AFAppRequest


//获得动态评论列表
+(void)getFeedCommentFromID:(void (^)(NSArray * commentDic))succ :(int)feedID :(int)page;
//添加评论
+(void)sendComment:(void (^)(NSDictionary*commentDic))succ :(int)feedID :(NSString*)commentContent;
// 添加动态评论回复
+(void)addCommentRely:(void (^)(NSDictionary*commentDic))succ :(int)feedID :(int)comment_user_id :(NSString*)commentContent;


//////12.17/////12.18////
//获得项目评论列表
+(AFRequestState *)getFeedRequest:(void (^)(NSArray * feedDic))succ :(int)feedID :(int)page;
//添加项目评论回复
+(AFRequestState*)sendCommentNew:(void (^)(NSDictionary*commentDic))succ :(int)feedID :(NSString*)commentContent;


+(AFRequestState*)addCommentRelyNew:(void (^)(NSDictionary*commentDic))succ :(int)feedID :(int)comment_user_id :(NSString*)commentContent;
@end
