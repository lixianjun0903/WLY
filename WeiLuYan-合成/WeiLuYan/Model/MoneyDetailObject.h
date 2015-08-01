//
//  MoneyDetailObject.h
//  WeiLuYan
//
//  Created by mac on 15/1/14.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
#import "MoneyObject.h"

@interface Item  : NSObject<Expose>
@property NSString * _139;

@end

@interface PersonMessage : NSObject<Expose>
@property NSString * avatar;
@property NSString * member_id;
@property NSString * nickname;
@property NSString * real_name;
@end
//数组data_comment里的对象（评论人model）
@interface MessageComment : NSObject<Expose>
@property NSString * comment_user_id;
@property NSString * content;
@property PersonMessage * data_commentuser;
@property NSString * data_replyuser;
@property NSString * deal_time;
@property NSString * project_id;
@property NSString * reply_user_id;

@end
//数组data_finance里的对象（融资信息）
@interface PastFinance : NSObject<Expose>
@property NSString * add_time;
@property NSString * project_finance_past_id;
@property NSString * title;
@end
//数组data_team里的对象（团队成员信息）
@interface Team : NSObject<Expose>
@property NSString * avatar;

@property NSString * nick_name;
@property NSString * real_name;
@property NSString * ref_id;
@property NSString * type;

@end
//数组data_parks里面的对象（融资档位信息）
@interface MoneyParks :NSObject<Expose>
@property (assign) int park_claimed;
@property (strong,nonatomic) NSString * parks_desc;
@property (assign) int parks_id;
@property (strong,nonatomic) NSString * parks_name;
@property (assign) int parks_price;
@property (assign) int pakes_count;
@property (assign) int parks_last;
@end

//众筹详情页数据model
@interface MoneyDetailObject : NSObject<Expose>

@property (assign) int comment_count;
@property (nonatomic,strong) NSString * comments;
//把json数据的数组转为对象（参数为数组名字）
array_item_def(data_comment);
@property (nonatomic,strong) NSArray * data_comment;
@property (nonatomic,strong) MoneyObject * data_finance;
array_item_def(data_financepast)
@property (nonatomic,strong) NSArray * data_financepast;

//@property (nonatomic,strong) Item * data_industry;
array_item_def(data_team)
@property (nonatomic,strong) NSArray * data_team;
@property (nonatomic,strong) NSString * favorite_count;
@property (nonatomic,strong) NSString * finance_allowed;
@property (nonatomic,strong) NSString * financepast_count;
@property (nonatomic,strong) NSString * influence_count;
@property (nonatomic,strong) NSString * introduce_id;
@property (nonatomic,strong) NSString * introduce_img;
@property (nonatomic,strong) NSString * introduce_video;
@property (nonatomic,strong) NSString * introduce_video_name;
@property (assign) int project_approval_count;
@property (nonatomic,strong) NSString * introduce_video_unique;
@property (nonatomic,strong) NSString * is_auth;
@property (nonatomic,strong) NSString * is_finance;
@property (nonatomic,strong) NSString * is_owner;
@property (nonatomic,strong) NSString * is_voter;
@property (nonatomic,strong) NSString * logo;
@property (nonatomic,strong) NSString * product_img;
@property (nonatomic,strong) NSString * project_desc;
@property (nonatomic,strong) NSString * project_favorite_id;
@property (nonatomic,strong) NSString * project_id;
@property (nonatomic,strong) NSString * project_name;
array_item_def(data_parks)
@property (nonatomic,strong) NSArray * data_parks;

@property (nonatomic,strong) NSString * roadshow_id;
@property (nonatomic,strong) NSString * roadshow_img;
@property (nonatomic,strong) NSString * roadshow_video;
@property (nonatomic,strong) NSString * roadshow_video_name;

@property (nonatomic,strong) NSString * roadshow_video_unique;
@property (nonatomic,strong) NSString * stage;
@property (nonatomic,strong) NSString * team_count;
@property (nonatomic,strong) NSString * update_time;

@end
