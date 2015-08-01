//
//  PersonInfoEditeModel.h
//  WeiLuYan
//
//  Created by jikai on 14/12/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
#import "UserInfoObject.h"
#import "JobStateObject.h"
#import "OfficeObject.h"

@interface PersonInfoEditeObject : NSObject<Expose>
array_item_def(job_arr)
@property (nonatomic, strong) NSArray * job_arr;
array_item_def(office_arr)
@property (nonatomic, strong) NSArray * office_arr;
@property (nonatomic,strong) UserInfoObject * user_arr;
@end
