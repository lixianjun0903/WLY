//
//  ShareObject.h
//  WeiLuYan
//
//  Created by jikai on 15/3/25.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface ShareObject : NSObject<Expose>

@property (nonatomic, assign) int project_id;
@property (nonatomic, strong) NSString * project_name;
@property (nonatomic, strong) NSString * project_desc;
@property (nonatomic, strong) NSString * product_img;
@property (nonatomic, strong) NSString * share_url;

@end
