//
//  commentObject.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/17.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
#import "commentPersonObject.h"
#import "replyPersonObject.h"
#import "commentPersonObject.h"

@interface commentObject : NSObject<Expose>

@property(nonatomic,strong)commentPersonObject * comment_user_arr;

@property(nonatomic,strong)NSString * content;
@property(nonatomic,strong)NSString * time;


array_item_def(reply_user_arr)
@property(nonatomic,strong)NSArray * reply_user_arr;
@end
