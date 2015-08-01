//
//  ProjectRequest.h
//  WeiLuYan
//
//  Created by 张亮 on 14/11/21.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AFAppRequest.h"

@interface ProjectRequest : AFAppRequest

//+(void)search:(void (^)(NSDictionary*result, NSError *error))block :(NSString*)keyWord;

+(void)found:(void (^)(NSArray * result))succ :(int)industry_id :(int)video_len :(int)p;

@end
