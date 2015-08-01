//
//  MyFriend.h
//  WeiLuYan
//
//  Created by weiluyan on 14/11/8.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface MyFriend : NSObject<Expose>

@property(nonatomic,retain)NSString*friend_id;
@property(nonatomic,retain)NSString*friend_user_icon;
@property(nonatomic,retain)NSString*friend_user_id;
@property(nonatomic,retain)NSString*friend_user_job;
@property(nonatomic,retain)NSString*friend_user_name;
@property(nonatomic,retain)NSString*friend_user_office;
@property(nonatomic,assign)int is_apply;
@property(nonatomic,retain)NSString* friend_nick_name;
@property(nonatomic,retain)NSString * from_type;

@end
