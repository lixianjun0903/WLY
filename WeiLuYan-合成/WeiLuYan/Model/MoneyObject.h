//
//  MoneyObject.h
//  WeiLuYan
//
//  Created by mac on 15/1/14.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
@interface MoneyObject : NSObject<Expose>
@property (nonatomic,strong)NSString * finance_desc;
@property (nonatomic,strong)NSString * rate;
@property (nonatomic,strong)NSString * finance_id;
@property (nonatomic,strong)NSString * finance_money;
@property (nonatomic,strong)NSString * have_days;
@property (nonatomic,strong)NSString * head_pic;
@property (nonatomic,strong)NSString * status;
@property (nonatomic,strong)NSString * unit_money;
@property (nonatomic,strong)NSString * vote_money;
@property (nonatomic,strong)NSString * voteuser_count;
@end
