//
//  ActivityInfo.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/6.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
#import "ApprovalObject.h"
#import "DataUserObject.h"

@interface ActivityInfo : NSObject<Expose>

@property(nonatomic,strong)NSString * add_time_int;
@property(nonatomic,strong)NSString * add_time_txt;
@property(nonatomic,strong)NSString * content;

@property(nonatomic)int approval_count;
@property(nonatomic)int comment_count;

@property(nonatomic,strong)ApprovalObject * data_approval;

@property(nonatomic,strong)NSString * data_feed;
@property(nonatomic,strong)DataUserObject * data_user;
@property(nonatomic,assign)int delete_status;
@property(nonatomic,assign)int feed_type;
@property(nonatomic,assign)int feedcontent_id;
@property(nonatomic,strong)NSString * forward_content;
@property(nonatomic,assign)int forward_status;
@property(nonatomic,strong)NSString * forward_title;
@property(nonatomic,assign)int  from_type;
@property(nonatomic,assign)int  hot_status;
@property(nonatomic,strong)NSArray * pic_content;
@property(nonatomic,assign)int  recommend_status;
@property(nonatomic,assign)int  top_status;
@property(nonatomic,assign)int  update_time_int;
@property(nonatomic,strong)NSString * video_content;
@property(nonatomic,strong)NSString * videoimg_content;















@end
