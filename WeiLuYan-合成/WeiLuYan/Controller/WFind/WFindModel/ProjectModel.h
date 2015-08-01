//
//  ProjectModel.h
//

//
//  Created by 张亮 on 14/11/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModel : NSObject
//{
//    "approval_status" = 0;
//    "approval_user_avatar" = "http://wly.iheima.com/./Public/uploads/avatar/54609390cd036.png";
//    "approval_user_id" = 2;
//    "approval_user_name" = ;;
//    "favorite_status" = 0;
//    "finance_info" =             (
//    );
//    isflag = 1;
//    "project_approval_count" = 0;
//    "project_id" = 2;
//    "project_industry" =             {
//        1 = "\U6e38\U620f";
//        2 = "\U786c\U4ef6";
//    };
//    "project_logo" = "http://wly.iheima.com/./Public/uploads/project/http://wly.iheima.com/./Public/uploads/project/54699f72dd253.png";
//    "project_name" = "\U5434\U6d9b";
//    "project_nick_name" = "\U87d1\U8782";
//    "project_user_avatar" = "http://wly.iheima.com/./Public/uploads/avatar/5466cbadd78d2.png";
//    "project_user_id" = 1;
//    "project_user_name" = "\U529b\U91cf";
//},

@property( nonatomic, assign) int approval_status;
@property( nonatomic, strong) NSString * approval_user_avatar;
@property( nonatomic, assign) int approval_user_id;
@property( nonatomic, strong) NSString * approval_user_name;
@property( nonatomic, strong)NSDictionary*data_approval;
@property( nonatomic, assign)int favorite_status;
@property( nonatomic, strong)NSDictionary* finance_info;
@property( nonatomic, assign)int project_approval_count;
@property( nonatomic, assign)int isflag;
@property( nonatomic, assign)int project_id;
@property( nonatomic, strong)NSString*project_logo;
@property( nonatomic, strong)NSString* project_name;
@property( nonatomic, strong)NSString* project_nick_name;
@property( nonatomic, strong)NSString* project_user_avatar;
@property( nonatomic, assign)int project_user_id;
@property( nonatomic, strong)NSString* project_user_name;
@property( nonatomic, strong)NSMutableArray* project_industry;
@property( nonatomic, strong)NSDictionary*data_user;
@property( nonatomic, assign)int create_time;
@property( nonatomic, assign) int is_finance;
@property( nonatomic, strong) NSString* roadshow_video;
@property( nonatomic, strong) NSString* roadshow_img;
@property( nonatomic, assign) int stage;
@property( nonatomic, assign) int is_favorite;

-(id)initWithValueDic:(NSDictionary*)dataDic;
-(void)setValueForProperty:(NSDictionary*)dataDic;
@end
