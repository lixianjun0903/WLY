//
//  commentPersonObject.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/17.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface commentPersonObject : NSObject<Expose>

@property(nonatomic,strong)NSString * avatar;
@property(nonatomic,strong)NSString * company;
@property(nonatomic,strong)NSString * member_id;
@property(nonatomic,strong)NSString * nickname;
@property(nonatomic,strong)NSString * office;
@property(nonatomic,strong)NSString * real_name;

@end
