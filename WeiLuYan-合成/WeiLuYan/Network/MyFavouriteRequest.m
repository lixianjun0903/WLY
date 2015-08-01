//
//  MyFavouriteRequest.m
//  WeiLuYan
//
//  Created by wly on 15/3/19.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "MyFavouriteRequest.h"
#define ACCOUNTUSERINFO @"accountUserInfo"

@implementation MyFavouriteRequest

+(AFRequestState *)favoritePersonListsWithPage:(int)page with:(void(^)(FavouritePerson * personDic))succ fail:(void (^)(int errCode, NSError * err))fail{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = [NSDictionary dictionaryWithDictionary:[user objectForKey:ACCOUNTUSERINFO]];
    NSNumber *personId = [dic objectForKey:@"member_id"];
    NSDictionary * param = @{@"uid":personId};
    return [self postRequestWithToken:@"/user/getAttentionUser" param:param succ:succ fail:fail resp:[FavouritePerson class]];
}

//项目取消收藏
+(AFRequestState *)cancelFavoriteWithId:(NSArray *)personId with:(void(^)(NSNumber * result))succ
{
   
    NSData * data = [NSJSONSerialization dataWithJSONObject:personId options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     NSDictionary * param = @{@"U_UserIDs":str};
    return [self postRequestWithToken:@"/user/cancelUserAttention" param:param succ:succ];
}

@end
