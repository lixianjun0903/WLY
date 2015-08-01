//
//  FaXianRequest.m
//  WeiLuYan
//
//  Created by weiluyan on 14/11/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WFindRequest.h"
#import "UserInfoRequest.h"
#import "FoundProjectModel.h"

@implementation WFindRequest

+(void)project:(void (^)(NSArray * userDic))succ
{

    [self postRequestWithToken:@"common/industryList" param:nil succ:succ resp:[FoundProjectModel class]];
}

@end
