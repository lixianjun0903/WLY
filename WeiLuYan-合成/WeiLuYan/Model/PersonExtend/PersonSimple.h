//
//  PersonSimple.h
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/3.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "PersonIcon.h"

@interface PersonSimple : PersonIcon<Expose>

@property( nonatomic, strong) NSString * nickname;
@property( nonatomic, strong) NSString * real_name;

@end
