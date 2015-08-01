//
//  FoundProjectModel.h
//  WeiLuYan
//
//  Created by dev on 14/12/8.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface FoundProjectModel : NSObject<Expose>

@property (nonatomic,strong) NSString * industry_id;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * parent_id;

@end
