//
//  UserInfoRequest.m
//  WeiLuYan
//
//  Created by 张亮 on 14/11/5.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "UserInfoRequest.h"
#import "AccountRequest.h"
#import "GeneralizedProcessor.h"
#import "MyFriend.h"
#import "TagObject.h"


@implementation UserInfoRequest

+(void)getShowEditInfoo:(void (^)(NSDictionary *))succc
{
    [self postRequestWithToken:@"user/showEditUser" param:nil succ:succc resp:[PersonInfoEditeObject class]];
}

+(void)getShowEditInfo:(void (^)(PersonInfoEditeObject * userDic))succ
{

    [self postRequestWithToken:@"user/showEditUser" param:nil succ:succ resp:[PersonInfoEditeObject class]];
    
}
+(void)getUserTagInfo:(void (^)(NSArray * userTagDic))succ
{

    [self postRequestWithToken:@"tag/tagInfo" param:nil succ:succ resp:[TagObject class]];
}
+(void)editUserInfo:(void (^)(NSDictionary*responseDic))succ fail:(void (^)(int errCode, NSError * err))fail :(NSDictionary*)editDic
{

    [self postRequestWithToken:@"user/saveNewEdit" param:editDic succ:succ fail:fail];

}

+(void)editUserTagInfo:(void (^)(NSDictionary*userDic))succ :(NSArray*)saveTagArray
{
    [self postRequestWithToken:@"tag/saveEdit" param:@{@"data":saveTagArray} succ:succ];
    
}

+(void)getUserInfo:(void (^)(NSDictionary*userDic))succ
{
    [self postRequestWithToken:@"user/userInfo" param:nil succ:succ];
}

+(void)friendaLists:(void (^)(NSArray*dic))succ :(NSString*)friendurl :(int)page :(int)tag_id fail:(void (^)(int, NSError *))fail

{

    [self postRequestWithToken:friendurl param:@{@"page":[NSNumber numberWithInt:page],@"tag_id":[NSNumber numberWithInt:tag_id]}  succ:succ fail:fail resp:[MyFriend class]];
    
}

+(void)getMyFriendBiaoQqian:(void (^)(NSArray * userDic))succ
{

    [self postRequestWithToken:@"user/userTags" param:nil succ:succ];
    
    
}
+(void)uploadContact:(void (^)(NSDictionary*userDic, NSError *error))block :(NSArray*)userarr
{
    NSString *dadadad=@"2132323";
    NSString*iph=@"+86 22323232";
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:dadadad,@"peopleName",iph,@"phoneNum0", nil];
    NSArray *arrrr=[NSArray arrayWithObjects:dic, nil];
    
    
    NSMutableDictionary*parameter= [UserInfoRequest getURLSignaAndTokenDic:@"third/addContact"];
    
    
    NSDictionary*dataParameter=  [NSDictionary dictionaryWithObjectsAndKeys:arrrr,@"data", nil];
    
    NSMutableDictionary*finalParameter=[[NSMutableDictionary alloc]initWithDictionary:parameter];
    [finalParameter setValuesForKeysWithDictionary:dataParameter];
    
    
    [[UserInfoRequest sharedClient] POST:@"third/addContact" parameters:finalParameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        block(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        block(nil,error);
    }];
    
    
}

#pragma mark 是否关注好友
+(void)Attention:(void (^)(NSDictionary * userDic))succ data:(NSArray *)user_id isAttention:(BOOL)is_Attention
{
    NSString * path;
    
    if(is_Attention){
        path = @"user/addUserAttention";
    }
    else{
        path = @"user/cancelUserAttention";
    }
    NSData * data = [NSJSONSerialization dataWithJSONObject:user_id options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self postRequestWithToken:path param:@{@"U_UserIDs":str} succ:succ];
}

+(void)delFriend:(void (^)(NSDictionary*userDic))succ :(int)friend_id
{

    [self postRequestWithToken:@"friend/delFriend" param:@{@"friend_id":[NSNumber numberWithInt:friend_id]} succ:succ];
}

//编辑页面上传头像
+(void)uploadImage:(void (^)(NSString * backUrl))succ :(UIImage *)inputImage fail:(void(^)(int errCode, NSError *err))faile isID:(BOOL)flag
{
    if(!flag){
        [self postImageFlag:YES url:@"user/saveUserAvatar" succ:succ WithData:@{@"feedcontent_pic":@[inputImage]} fail:faile];
    }
    else{
        [self postImageFlag:YES url:@"user/addApprove" succ:succ WithData:@{@"feedcontent_pic":@[inputImage]} fail:faile];
    }
    
}

//实名认证
+ (AFRequestState *)submitPersonalId:(void (^)(NSDictionary *))succ data:(NSDictionary *)data fail:(void (^)(int, NSError *))fail
{
   // return [self postRequestWithToken:@"user/addApprove" param:data succ:succ];
    return [self postImageFlag:NO url:@"user/addApprove" succ:succ WithData:data fail:fail];
}
//合格投资认证
+(AFRequestState *)agree:(void (^)(NSDictionary *))succ fail:(void(^)(int errCode,NSError * err))fail
{
    return [self postRequestWithToken:@"user/addInvestApprove" param:nil succ:succ fail:fail];
}

+(AFRequestState *)feedBack:(void (^)(NSDictionary *))succ :(NSString *)feedtext fail:(void (^)(int errCode, NSError * err))fail
{
    
    return [self postRequestWithToken:@"common/feedback" param:@{@"content":feedtext} succ:succ fail:fail resp:[NSNull class]];
}

+(void)logout:(void (^)(NSDictionary*userDic))succ
{
    

    [self postRequestWithToken:@"user/logout" param:nil succ:succ];

}
+(void)modifyUserPass:(void (^)(NSDictionary*userDic))succ :(NSString*)old_pass :(NSString*)new_pass
{
    NSString*old_passdWord=[GeneralizedProcessor base64StringFromText:[AccountRequest sortDesc:old_pass]];
    NSString *new_paasdWord=[GeneralizedProcessor base64StringFromText:[AccountRequest sortDesc:new_pass]];
    NSDictionary *dataParameter=[NSDictionary dictionaryWithObjectsAndKeys:old_passdWord,@"old_pass",new_paasdWord,@"new_pass", nil];
    [self postRequestWithToken:@"user/modifyUserPass" param:dataParameter succ:succ];
    
}

+(void)Ceshipublish:(void (^)(NSDictionary*userDic))succ :(UIImage*)feedcontent_pic
{

    [self postRequestWithToken:@"index/testImg" param:@{@"feedcontent_pic":feedcontent_pic} succ:succ];
}

+(void)publish:(void (^)(NSNumber *))succ :(NSString*)path :(NSDictionary*)dic fail:(void(^)(int errCode, NSError *err))faile
{
    
    [self postImageFlag:NO url:path succ:succ WithData:dic fail:faile];
    
}

//+(void)publish:(void (^)(NSNumber *))succ data:(NSDictionary *)dic fail:(void (^)(int, NSError *))fail
//{
//    [self postImageFlag:NO url:@"feed/newpublish" succ:succ WithData:dic fail:fail];
//}

//发布动态
+(AFRequestState *)publish:(NSDictionary *)publishDic with:(void(^)(NSDictionary *result))succ{
       return [self postRequestWithToken:@"feed/newpublish" param:publishDic succ:succ];
}

+(void)uploadImage:(void (^)(NSDictionary *))succ data:(NSArray *)arr fail:(void(^)(int errCode,NSError * err))fail{
    [self postImagesFlag:NO url:@"feed/addFeedPics" succ:succ WithData:arr fail:fail];
}

+(AFRequestState *)getUserInfoID:(void (^)(UserObject *userObject))succ userid:(int)suerid

{
    if(suerid){
        return  [self postRequestWithToken:@"user/userInfo" param:@{@"user_id":[NSNumber numberWithInt:suerid]} succ:succ resp:[UserObject class]];
    }
    else{
        return  [self postRequestWithToken:@"user/userInfo" param:nil succ:succ resp:[UserObject class]];
    }
    
}

+(void)saveBindPhone:(void (^)(NSDictionary *))succ :(NSString *)iphone :(NSString *)password
{
    
}

+(void)getMyProjectFavorites:(void (^)(NSDictionary*userDic))succ :(int)pag
{
    
    

    [self postRequestWithToken:@"project/getMyProjectFavorites" param:@{@"p":[NSNumber numberWithInt:pag]} succ:succ];
    
    
}
+(void)showBindPhone:(void (^)(NSDictionary*userDic))succ
{
    
    

    [self postRequestWithToken:@"user/showBindPhone" param:nil succ:succ];
    
    
    
    
}
+(void)getMyVoteProjects:(void (^)(NSDictionary*userDic))succ ;
{
    
    

    [self postRequestWithToken:@"project/getMyVoteProjects" param:nil succ:succ];
    
    
    
    
}


@end
