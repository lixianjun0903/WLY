//
//  PersonIcon.h
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/3.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface PersonIcon : NSObject<Expose>

@property int user_id;
@property (nonatomic,assign) NSString * avatar;

@end
