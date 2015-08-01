//
//  CollectMoneyRequest.h
//  WeiLuYan
//
//  Created by gaob on 15/1/5.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "AFAppRequest.h"
#import "ProjectDetailObject.h"

@interface CollectMoneyRequest : AFAppRequest

//融资项目列表
+(AFRequestState *)collectFinanceLists:(int)page succ:(void (^)(NSDictionary*dic))succ;

//保存融资
+(AFRequestState *)collectSaveFinance:(UIImage * )img project_ID:(int)projectID finance_price:(int)finance_price part_num:(int)part_num share_num:(int)share_num succ:(void (^)(NSDictionary*dic))succ;

//项目投资人列表
+(AFRequestState *)collectFinanceInvestLists:(int)finance_id project_id:(int)project_id page:(int)page succ:(void (^)(NSDictionary*dic))succ;

//我要投资
+(AFRequestState *)collectAddFinanceInvest:(int)finance_id project_id:(int)project_id succ:(void (^)(NSDictionary*dic))succ ;

//保存投资
+(AFRequestState *)collectSaveFinanceInvest:(int)finance_id project_id:(int)project_id num:(int)num succ:(void (^)(NSDictionary*dic))succ ;

+(AFRequestState *)collectFinanceDetails:(int)mid succ:(void (^)(ProjectDetailObject *dic))succ;
//项目点赞人列表
+(AFRequestState *)getProjetApproval:(int)mid succ:(void (^)(NSArray * array))succ;

//项目评论信息
+(AFRequestState *)getProjectComments:(int)mid page:(int)page succ:(void (^)(NSDictionary * dic))succ;

//项目收藏
+(AFRequestState *)collectFinanceCollectWithId:(int)collectId with:(void(^)(NSDictionary * result))succ;

//项目取消收藏
+(AFRequestState *)collectFinanceUnCollectWithId:(int)collectId with:(void(^)(NSDictionary * result))succ;

//收藏项目列表页
+(AFRequestState *)collectFavoriteListsWithPage:(int)page with:(void(^)(NSDictionary * result))succ fail:(void (^)(int errCode, NSError * err))fail;
//项目分类
+(AFRequestState *)collectIndustry:(int)industry withPage:(int)page with:(void(^)(NSDictionary * result))succ;

@end
