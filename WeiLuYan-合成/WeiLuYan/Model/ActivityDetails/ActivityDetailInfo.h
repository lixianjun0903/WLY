//
//  ActivityDetailInfo.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/17.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
#import "PersonDetailObject.h"
#import "createPersonObject.h"
#import "commentObject.h"
@interface ActivityDetailInfo : NSObject<Expose>

@property(nonatomic,assign)int approval_count;

array_item_def(approval_user_arr)
@property(nonatomic,strong)NSArray * approval_user_arr;

@property(nonatomic,assign)int auth_approval_status;
@property(nonatomic,strong)NSString * content;

@property(nonatomic,strong)createPersonObject * create_user;

array_item_def(feed_comment_arr)
@property(nonatomic,strong)NSArray * feed_comment_arr;

@property(nonatomic,assign)int feedcontent_id;
@property(nonatomic,strong)NSArray * pic_content;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,assign)int user_id;
@property(nonatomic,strong)NSString * video_text;
@property(nonatomic,strong)NSString * videoimg_text;



@end
