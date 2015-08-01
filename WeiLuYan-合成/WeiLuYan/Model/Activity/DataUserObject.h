//
//  DataUserObject.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/11.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface DataUserObject : NSObject<Expose>

@property (nonatomic,strong) NSString * avatar;
@property (nonatomic,assign) int member_id;
@property (nonatomic,strong) NSString * nickname;
@property (nonatomic,strong) NSString * real_name;

@end
