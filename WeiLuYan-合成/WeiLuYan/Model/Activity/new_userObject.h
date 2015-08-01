//
//  new_userObject.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/6.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
@interface new_userObject : NSObject<Expose>

@property(nonatomic,strong)NSString * avatar;
@property(nonatomic)int member_id;

@end
