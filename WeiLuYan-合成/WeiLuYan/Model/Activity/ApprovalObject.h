//
//  ApprovalInfo.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/6.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
#import "new_userObject.h"

@interface ApprovalObject : NSObject<Expose>

@property(nonatomic)int is_approval;

array_item_def(new_user);

@property (nonatomic, getter=theNewTitle) NSArray * new_user;

@end
