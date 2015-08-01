//
//  ProjectRequest.m
//  WeiLuYan
//
//  Created by 张亮 on 14/11/21.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "ProjectRequest.h"
#import "UserInfoRequest.h"

@implementation ProjectRequest
+(void)search:(void (^)(NSDictionary*result, NSError *error))block :(NSString*)keyWord
{
//    NSDictionary*pageParameter=  [NSDictionary dictionaryWithObjectsAndKeys:keyWord,@"keywords", nil];
//    NSMutableDictionary*URLparameter= [ProjectRequest getURLSignaAndTokenDic:@"feed/commentLists"];
//    [URLparameter setValuesForKeysWithDictionary:pageParameter];
//    [[ProjectRequest sharedClient] POST:@"search/index" parameters:URLparameter success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         block(responseObject,nil);
//      
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         block(nil,error);
//    }];
//    [self postRequestWithToken:@"search/index" param:@{@"keywords" : keyWord} succ:succ];
}

+(void)found:(void (^)(NSArray * result))succ :(int)industry_id :(int)video_len :(int)p
{
    //NSDictionary * pageParameter=  [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:industry_id],@"industry_id",[NSNumber numberWithInt:video_len],@"video_len",[NSNumber numberWithInt:p],@"p", nil];
    
    //NSMutableDictionary * URLparameter= [ProjectRequest getURLSignaAndTokenDic:@"found/project"];
    
//    [URLparameter setValuesForKeysWithDictionary:pageParameter];
    
//    [[ProjectRequest sharedClient] POST:@"found/project" parameters:URLparameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        block(responseObject,nil);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        block(nil,error);
//    }];
//    
//    [[ProjectRequest sharedClient] POST:@"found/project" parameters:URLparameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //NSLog(@"faxianfaxi=%@",responseObject);
//        
//        succ(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
    
    [self postRequestWithToken:@"found/project" param:@{@"industry_id":[NSNumber numberWithInt:industry_id], @"video_len":[NSNumber numberWithInt:video_len], @"p":[NSNumber numberWithInt:p]} succ:succ];
}
@end
