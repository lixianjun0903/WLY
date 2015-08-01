//
//  userInfoModel.h
//  WeiLuYan
//
//  Created by jikai on 14/12/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
#import "TagObject.h"

@interface UserInfoObject : NSObject<Expose>
array_item_def(tag_arr)
@property (nonatomic,strong) NSString * desc;
@property (nonatomic,strong) NSArray * tag_arr;
@property (nonatomic,strong) NSString * address;
@property (nonatomic,strong) NSString * avatar;
@property (nonatomic,strong) NSString * card_pic;
@property (nonatomic,strong) NSString * card_status;
@property (nonatomic,strong) NSString * company;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,assign) int  favorite_project_count;
@property (nonatomic,assign) int  feedcontent_count;
@property (nonatomic,assign) int  frienda_count;
@property (nonatomic,assign) int  friendb_count;
@property (nonatomic,assign) int  influence_count;
@property (nonatomic,strong) NSString * job_status;
@property (nonatomic,strong) NSString * nick_name;
@property (nonatomic,assign) NSString *  office;
@property (nonatomic,strong) NSString *  phone;
@property (nonatomic,assign) int  sex;
@property (nonatomic,assign) int  user_id;
@property (nonatomic,strong) NSString * user_name;
@property (nonatomic,assign) int  vote_project_count;
@property (nonatomic,strong) NSString * vote_total_money;
@property (nonatomic,assign) int  vote_total_rate;
@property (nonatomic,strong) NSString * vote_total_val;

@end
