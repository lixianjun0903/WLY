//
//  CollectMoneyRequest.m
//  WeiLuYan
//
//  Created by gaob on 15/1/5.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "CollectMoneyRequest.h"
#import "CollectMoneyObject.h"
#import "NewCollectMoneyObject.h"

@implementation CollectMoneyRequest

//融资项目列表
+(AFRequestState *)collectFinanceLists:(int)page succ:(void (^)(NSDictionary*dic))succ
{
    NSDictionary * param = @{@"page":[NSNumber numberWithInt:page]};
    
    return [self postRequestWithToken:@"/finance/lists" param:param succ:succ resp:[CollectMoneyObject class]];
}

//保存融资
+(AFRequestState *)collectSaveFinance:(UIImage * )img project_ID:(int)projectID finance_price:(int)finance_price part_num:(int)part_num share_num:(int)share_num succ:(void (^)(NSDictionary*dic))succ
{
    NSDictionary * param = @{@"img":UIImagePNGRepresentation(img),
                             @"project_id": [NSNumber numberWithInt:projectID],
                             @"finance_price":[NSNumber numberWithInt:finance_price],
                             @"part_num":[NSNumber numberWithInt:part_num],
                             @"share_num":[NSNumber numberWithInt:share_num]};
    
    return [self postRequestWithToken:@"/finance/saveFinance" param:param succ:succ];
}

//项目投资人列表
+(AFRequestState *)collectFinanceInvestLists:(int)finance_id project_id:(int)project_id page:(int)page succ:(void (^)(NSDictionary*dic))succ;
{
    NSDictionary * param = @{@"finance_id":[NSNumber numberWithInt:finance_id],
                             @"project_id":[NSNumber numberWithInt:project_id],
                             @"page":[NSNumber numberWithInt:page]};
    
    return [self postRequestWithToken:@"/finance/investLists" param:param succ:succ];
}

//我要投资
+(AFRequestState *)collectAddFinanceInvest:(int)finance_id project_id:(int)project_id succ:(void (^)(NSDictionary*dic))succ
{
    NSDictionary * param = @{@"finance_id":[NSNumber numberWithInt:finance_id],
                             @"project_id":[NSNumber numberWithInt:project_id]};
    
    return [self postRequestWithToken:@"/finance/addFinanceInvest" param:param succ:succ];
}

//保存投资
+(AFRequestState *)collectSaveFinanceInvest:(int)finance_id project_id:(int)project_id num:(int)num succ:(void (^)(NSDictionary*dic))succ
{
    NSDictionary * param = @{@"finance_id":[NSNumber numberWithInt:finance_id],
                             @"project_id":[NSNumber numberWithInt:project_id],
                             @"num":[NSNumber numberWithInt:num]};
    
    return [self postRequestWithToken:@"/finance/saveFinanceInvest" param:param succ:succ];
}

+(AFRequestState *)collectFinanceDetails:(int)mid succ:(void (^)(ProjectDetailObject *dic))succ
{
    NSDictionary * param = @{@"P_Id":[NSNumber numberWithInt:mid]};

    return [self postRequestWithToken:@"/project/newDetail" param:param succ:succ resp:[ProjectDetailObject class]];

}

+(AFRequestState *)getProjetApproval:(int)mid succ:(void (^)(NSArray * array))succ
{
    NSDictionary * param = @{@"project_id":[NSNumber numberWithInt:mid]};
    
    return [self postRequestWithToken:@"/project/approvalLists" param:param succ:succ];
    
}

+(AFRequestState *)getProjectComments:(int)mid page:(int)page succ:(void (^)(NSDictionary * dic))succ
{
    
    NSDictionary * param = @{@"project_id":[NSNumber numberWithInt:mid],@"p":[NSNumber numberWithInt:page]};
    
    return [self postRequestWithToken:@"/project/getProjectComments" param:param succ:succ];
}


//项目收藏
+(AFRequestState *)collectFinanceCollectWithId:(int)collectId with:(void(^)(NSDictionary * result))succ
{
    
    NSDictionary * param = @{@"project_id":[NSNumber numberWithInt:collectId]};
    
    return [self postRequestWithToken:@"project/addProjectFavorite" param:param succ:succ];
    
}

//项目取消收藏
+(AFRequestState *)collectFinanceUnCollectWithId:(int)collectId with:(void(^)(NSDictionary * result))succ
{
    
    NSDictionary * param = @{@"project_id":[NSNumber numberWithInt:collectId]};
    
    return [self postRequestWithToken:@"/project/cansleProjectFavorite" param:param succ:succ];
    
}

//收藏项目列表页
+(AFRequestState *)collectFavoriteListsWithPage:(int)page with:(void(^)(NSDictionary * result))succ fail:(void (^)(int errCode, NSError * err))fail
{
    
    NSDictionary * param = @{@"p":[NSNumber numberWithInt:page]};
    
    return [self postRequestWithToken:@"/project/getMyProjectFavorites" param:param succ:succ fail:fail resp:[CollectMoneyObject class]];
    
}

+(AFRequestState *)collectCancelFavoriteWithId:(int)favoId with:(void(^)(NSDictionary * result))succ
{
    NSDictionary * param = @{@"project_id":[NSNumber numberWithInt:favoId]};
    
    return [self postRequestWithToken:@"/project/cansleProjectFavorite" param:param succ:succ];
}

+(AFRequestState *)collectIndustry:(int)industry withPage:(int)page with:(void(^)(NSDictionary * result))succ
{
    NSDictionary * param = @{@"industry_id":[NSNumber numberWithInt:industry],@"p":[NSNumber numberWithInt:page]};

    return [self postRequestWithToken:@"/project/industryProjectLists" param:param succ:succ resp:[CollectMoneyObject class]];

    
}

//=======
//
////项目收藏
//+(AFRequestState *)collectFinanceCollectWithId:(int)collectId with:(void(^)(NSDictionary * result))succ
//{
//    
//    NSDictionary * param = @{@"project_id":[NSNumber numberWithInt:collectId]};
//    
//    return [self postRequestWithToken:@"/project/addProjectFavorite" param:param succ:succ];
//    
//}
////收藏项目列表页
//+(AFRequestState *)collectFavoriteListsWithPage:(int)page with:(void(^)(NSDictionary * result))succ
//{
//    
//    NSDictionary * param = @{@"page":[NSNumber numberWithInt:page]};
//    
//    return [self postRequestWithToken:@"/project/getMyProjectFavorites" param:param succ:succ];
//    
//}
//
//>>>>>>> .r681
@end
