//
//  attentionObject.h
//  WeiLuYan
//
//  Created by wly on 15/3/19.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
@interface attentionObject : NSObject<Expose>
@property(nonatomic,assign) int member_id;
@property(nonatomic,strong) NSString *nickname;
@property(nonatomic,strong) NSString *real_name;
@property(nonatomic,strong) NSString *office;
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *company;

@end
