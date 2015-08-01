//
//  MyFavouriteRequest.h
//  WeiLuYan
//
//  Created by wly on 15/3/19.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFAppRequest.h"
#import "FavouritePerson.h"

@interface MyFavouriteRequest : AFAppRequest

//关注人列表
+(AFRequestState *)favoritePersonListsWithPage:(int)page with:(void(^)(FavouritePerson * personDic))succ fail:(void (^)(int errCode, NSError * err))fail;

//取消关注
+(AFRequestState *)cancelFavoriteWithId:(NSArray *)personId with:(void(^)(NSNumber *result))succ;



@end
