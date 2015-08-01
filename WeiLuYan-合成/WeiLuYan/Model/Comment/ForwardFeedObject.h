//
//  ForwardFeedObject.h
//  WeiLuYan
//
//  Created by 张亮 on 14/11/11.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FeedObject.h"
#import "PersonalInfoModel.h"

@interface ForwardFeedObject : NSObject
//{
//    "add_time_int" = 1414656118;
//    "add_time_txt" = "2014\U5e7410\U670830\U65e5";
//    "approval_count" = 0;
//    content = "\U5f1f\U5f1f\U9876\U9876\U9876\U9876\U9876";
//    "data_approval" =             {
//        "is_approval" = "<null>";
//        "new_user" = "<null>";
//    };
//    "data_feed" =             {
//        user = "<null>";
//    };
//    "data_user" =             {
//        avatar = "http://wly.iheima.com/./Public/uploads/avatar/545c77a612d8b.png";
//        "member_id" = 1;
//        nickname = "\U87d1\U8782";
//        "real_name" = "\U529b\U91cf";
//    };
//    "feedcontent_id" = 7;
//    "forward_content" = "<null>";
//    "forward_status" = 0;
//    "forward_title" = "";
//    "from_type" = 0;
//    "hot_status" = 0;
//    "pic_content" =             (
//                                 "http://www.baidu.com/img/bd_logo1.png",
//                                 "http://www.baidu.com/img/bd_logo1.png",
//                                 "http://www.baidu.com/img/bd_logo1.png"
//                                 );
//    "recommend_status" = 0;
//    "top_status" = 0;
//    "video_content" = "<null>";
//    "videoimg_content" = "<null>";
//},

@property( nonatomic, assign) int add_time_int;
@property( nonatomic, strong) NSString* add_time_txt;
@property( nonatomic, assign) int approval_count;
@property( nonatomic, strong) NSString* content;
@property( nonatomic, strong) NSDictionary* data_approval;
//@property( nonatomic, strong) FeedObject*feedObject;
@property( nonatomic, strong) PersonalInfoModel* personModel;
@property( nonatomic, assign) int feedcontent_id;
@property( nonatomic, strong) NSString* forward_content;
@property( nonatomic, assign) int forward_status;
@property( nonatomic, strong) NSString* forward_title;
@property( nonatomic, assign) int from_type;
@property( nonatomic, assign) int hot_status;
@property( nonatomic, strong) NSArray* pic_content;
@property( nonatomic, assign) int recommend_status;
@property( nonatomic, assign) int top_status;
@property( nonatomic, strong) NSString* video_content;
@property( nonatomic, strong)NSString* videoimg_content;
@property( nonatomic, assign)int feed_type;
@property( nonatomic, assign)int comment_count;
-(id)initWithValueDic:(NSDictionary*)dataDic;
-(void)setValueForProperty:(NSDictionary*)dataDic;
@end
