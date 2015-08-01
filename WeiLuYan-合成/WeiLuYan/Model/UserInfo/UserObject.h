//
//  UserObject.h
//  WeiLuYan
//
//  Created by jikai on 15/3/12.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface UserObject : NSObject<Expose>

@property (nonatomic,strong) NSString * address;
@property (nonatomic,strong) NSString * avatar;
@property (nonatomic,strong) NSString * company;
@property (nonatomic,strong) NSString * desc;
@property (nonatomic,strong) NSString * user_name;
@property (nonatomic,strong) NSString * job_status;
@property (nonatomic,strong) NSString * office;
@property (nonatomic,assign) int card_status;
@property (nonatomic,assign) NSString * nick_name;
@property (nonatomic,assign) int is_attention;
@property (nonatomic,assign) int user_id;
@end
