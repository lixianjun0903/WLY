//
//  officeModel.h
//  WeiLuYan
//
//  Created by jikai on 14/12/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface OfficeObject : NSObject<Expose>

@property (nonatomic,strong) NSString * name;
@property (nonatomic,assign) int named_id;

@end
