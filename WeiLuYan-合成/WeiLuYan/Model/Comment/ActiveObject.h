//
//  FeedExObject.h
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/3.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "PersonalInfoModel.h"
#import "Gson.h"
#import "PersonSimple.h"

@interface ApprovalInfo : NSObject<Expose>
//是否是自己
//1是自己
//0不是
@property int is_approval;

array_item_def(new_user)
@property (nonatomic, getter=theNewTitle) NSMutableArray * new_user;

-(BOOL) isEmpty;

@end

@interface FeedSimple : NSObject<Expose>

@property( nonatomic, assign) int feedcontent_id;
@property( nonatomic, strong) NSString* forward_title;
@property( nonatomic, strong) NSString* content;
@property( nonatomic, strong) NSString* forward_content;

@end


@interface ActiveObject :FeedSimple<Expose>

array_item_def(pic_content)
@property( nonatomic, strong) NSArray* pic_content;

@property( nonatomic, strong) NSString* video_content;
@property( nonatomic, strong) NSString* videoimg_content;

@property( nonatomic, assign) int add_time_int;
@property( nonatomic, strong) NSString* add_time_txt;

@property( nonatomic, assign) int approval_count;
@property( nonatomic, assign) int comment_count;
@property( nonatomic, assign) int recommend_status;

@property( nonatomic, assign) int hot_status;
@property( nonatomic, assign) int top_status;

@property( nonatomic, assign) int forward_status;
@property( nonatomic, assign) int from_type;

@property( nonatomic, strong) PersonSimple * data_user;

@property( nonatomic, assign) int feed_type;

@property (nonatomic, strong) NSDictionary * data_feed;

@property( nonatomic, strong) ApprovalInfo * data_approval;



@property( nonatomic, assign) int approval_status;
@property( nonatomic, strong) NSString*approval_user_avatar;
@property( nonatomic, assign) int approval_user_id;
@property( nonatomic, strong) NSString*approval_user_name;
@property( nonatomic, assign) int favorite_status;
//	@property( nonatomic, strong) NSString*finance_info;
@property( nonatomic, assign) int project_approval_count;
@property( nonatomic, assign) int project_id;
//@property( nonatomic, strong) NSString*project_industry;
@property( nonatomic, strong) NSString*project_name;
@property( nonatomic, strong) NSString*project_nick_name;
@property( nonatomic, strong) NSString*project_user_avatar;
@property( nonatomic, assign) int project_user_id;
@property( nonatomic, strong) NSString*project_user_name;




@end
