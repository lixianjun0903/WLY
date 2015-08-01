//
//  FaXianRequest.h
//  WeiLuYan
//
//  Created by weiluyan on 14/11/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AFAppRequest.h"

@interface WFindRequest : AFAppRequest
//found/project
+(void)project:(void (^)(NSArray * userDic))succ ;

@end
