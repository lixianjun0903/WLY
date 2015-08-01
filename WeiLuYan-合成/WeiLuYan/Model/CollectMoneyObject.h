//
//  CollectMoneyObject.h
//  WeiLuYan
//
//  Created by mac on 15/1/14.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoneyObject.h"
#import "IndustryObject.h"
#import "Gson.h"
#import "PersonIcon.h"

@interface ApprovalMessage: NSObject<Expose>
//是否是自己
//1是自己
//0不是
@property int is_approval;

array_item_def(new_user)
@property (nonatomic, getter=theNewTitle)NSMutableArray * new_user;

-(BOOL) isEmpty;
@end

@interface CollectMoneyObject : NSObject<Expose>
@property (strong,nonatomic) NSString * approval_status;
@property (strong,nonatomic) NSString * approval_user_avatar;
@property (strong,nonatomic) NSString * approval_user_id;
@property (strong,nonatomic) NSString * approval_user_name;

@property (strong,nonatomic) ApprovalMessage * data_approval;

@property (strong,nonatomic) NSString * favorite_status;
@property (strong,nonatomic) MoneyObject * finance_info;
@property (nonatomic, assign) int project_approval_count;
@property (nonatomic, assign) int project_comment_count;
@property (strong,nonatomic) NSString * project_id;
@property (strong,nonatomic) IndustryObject * project_industry;
@property (strong,nonatomic) NSString * project_update_time;

@property (strong,nonatomic) NSString * project_name;
@property (strong,nonatomic) NSString * project_nick_name;
@property (strong,nonatomic) NSString * project_product_img;
@property (strong,nonatomic) NSString * project_user_avatar;
@property (strong,nonatomic) NSString * project_user_id;
@property (strong,nonatomic) NSString * project_user_name;
@property (strong,nonatomic) NSString * project_desc;


@end
