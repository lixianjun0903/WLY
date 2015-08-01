//
//  PersonModel.h
//

//
//  Created by 张亮 on 14/11/6.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalInfoModel : NSObject

@property( nonatomic, strong)NSString*address;
@property( nonatomic, strong)NSString*avatar;
@property( nonatomic, strong)NSString* card_pic;
@property( nonatomic, assign)int card_status;
@property( nonatomic, strong)NSString* company;
@property( nonatomic, assign)int favorite_project_count;
@property( nonatomic, assign)int feedcontent_count;
@property( nonatomic, assign)int frienda_count;
@property( nonatomic, assign)int friendb_count;
@property( nonatomic, assign)int influence_count;
@property( nonatomic, strong)NSString* job_status;
@property( nonatomic, strong)NSString* nick_name;
@property( nonatomic, strong)NSString* office;
@property( nonatomic, strong)NSMutableDictionary* project_arr;
@property( nonatomic, assign)int sex;
@property( nonatomic, strong)NSMutableArray* tag_arr;
@property( nonatomic, assign)int user_id;
@property( nonatomic, strong)NSString* user_name;
@property( nonatomic, assign)int vote_project_count;
@property( nonatomic, assign)double vote_total_money;
@property( nonatomic, assign)int  vote_total_rate;
@property( nonatomic, assign)double vote_total_val;
@property( nonatomic, strong) NSString* phone;
@property( nonatomic, strong)NSString*  email;
@property( nonatomic, assign)int member_id;
@property( nonatomic, strong)NSString* real_name;
@property( nonatomic, strong)NSString* qq_name;
@property(nonatomic,strong) NSString * weibo_name;
@property( nonatomic, strong)NSString* feedcontent_id;
@property( nonatomic) int job;

@end
