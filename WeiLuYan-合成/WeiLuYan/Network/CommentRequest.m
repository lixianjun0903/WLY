//
//  CommentRequest.m
//  WeiLuYan
//
//  Created by 张亮 on 14/11/13.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "CommentRequest.h"

@implementation CommentRequest
+(void)getFeedCommentFromID:(void (^)(NSArray * commentDic))succ :(int)feedID :(int)page
{

  [self postRequestWithToken:@"feed/commentLists"  param:@{@"feedcontent_id":[NSNumber numberWithInt:feedID], @"page":[NSNumber numberWithInt:page]} succ:succ resp:[NSArray class]];
}

+(void)sendComment:(void (^)(NSDictionary*commentDic))succ :(int)feedID :(NSString*)commentContent
{

    [self postRequestWithToken:@"project/addProjectComment"  param:@{@"project_id":[NSNumber numberWithInt:feedID], @"content":commentContent} succ:succ resp:[NSNull class]];

}

+(void)addCommentRely:(void (^)(NSDictionary*commentDic))succ :(int)feedID :(int)comment_user_id :(NSString*)commentContent
{

    [self postRequestWithToken:@"feed/addCommentRely"  param:@{@"feedcontent_id":[NSNumber numberWithInt:feedID], @"content":commentContent, @"comment_user_id":[NSNumber numberWithInt:comment_user_id]} succ:succ ];
}

+(AFRequestState *)getFeedRequest:(void (^)(NSArray * feedDic))succ :(int)feedID :(int)page;
{
    

    return [self postRequestWithToken:@"project/getProjectComments"  param:@{@"project_id":[NSNumber numberWithInt:feedID], @"p":[NSNumber numberWithInt:page]} succ:succ resp:[NSArray class]];

}
+(AFRequestState*)sendCommentNew:(void (^)(NSDictionary*commentDic))succ :(int)feedID :(NSString*)commentContent
{


   return   [self postRequestWithToken:@"feed/addComment"  param:@{@"feedcontent_id":[NSNumber numberWithInt:feedID], @"content":commentContent} succ:succ ];



}
+(AFRequestState*)addCommentRelyNew:(void (^)(NSDictionary*commentDic))succ :(int)feedID :(int)comment_user_id :(NSString*)commentContent
{


    return  [self postRequestWithToken:@"feed/addCommentRely"  param:@{@"feedcontent_id":[NSNumber numberWithInt:feedID], @"content":commentContent, @"comment_user_id":[NSNumber numberWithInt:comment_user_id]} succ:succ ];
}

@end
