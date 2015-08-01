//
//  UserInfoRequest.h
//  WeiLuYan
//
//  Created by 张亮 on 14/11/5.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AFAppRequest.h"
#import "PersonInfoEditeObject.h"
#import "UserObject.h"

@interface UserInfoRequest : AFAppRequest

+(void)getShowEditInfo:(void (^)(PersonInfoEditeObject * userDic))succ;

//获取用户标签
+(void)getUserTagInfo:(void (^)(NSArray *userTagDic))succ;
//上传用户信息
+(void)editUserInfo:(void (^)(NSDictionary*responseDic))succ fail:(void (^)(int errCode, NSError * err))fail :(NSDictionary*)editDic;
//获取用户信息
+(void)getUserInfo:(void (^)(NSDictionary*userDic))succ;

//是否关注好友
+(void)Attention:(void (^)(NSDictionary * userDic))succ data:(NSArray *)user_id isAttention:(BOOL)is_Attention;

+(void)friendaLists:(void (^)(NSArray*dic))succ :(NSString*)friendurl :(int)page :(int)tag_id fail:(void(^)(int errCode,NSError * err))fail;


//发布
+(void)publish:(void (^)(NSNumber *))succ :(NSString*)path :(NSDictionary*)dic fail:(void(^)(int errCode, NSError *err))faile;

////发布动态（old）
//+(void)publish:(void (^)(NSNumber *))succ data:(NSDictionary *)dic fail:(void(^)(int errCode,NSError * err))fail;

//发布动态
+(AFRequestState *)publish:(NSDictionary *)publishDic with:(void(^)(NSDictionary *result))succ;


//批量上传图片
+(void)uploadImage:(void (^)(NSDictionary *))succ data:(NSArray *)arr fail:(void(^)(int errCode,NSError * err))fail;

//上传标签
+(void)editUserTagInfo:(void (^)(NSDictionary*userDic))block :(NSArray*)saveTagArray;

//添加标签

+(void)getMyFriendBiaoQqian:(void (^)(NSArray*userDic))succ;


//获取通讯录
+(void)uploadContact:(void (^)(NSDictionary*userDic, NSError *error))block :(NSArray*)userarr;

//删除好友friend/delFriend
+(void)delFriend:(void (^)(NSDictionary*userDic))succ :(int)friend_id;

//反馈common/feedback
+(AFRequestState *)feedBack:(void (^)(NSDictionary *))succ :(NSString *)feedtext fail:(void (^)(int errCode, NSError * err))fail;

////修改密码/user/modifyUserPass
//
//编辑发送feed/publish

+(void)publish:(void (^)(NSDictionary*userDic, NSError *error))block :(NSArray*)feedcontent_pic :(NSString*)text;

+(void)Ceshipublish:(void (^)(NSDictionary*userDic))succ :(UIImage*)feedcontent_pic;


+(AFRequestState *)getUserInfoID:(void (^)(UserObject * userObject))succ userid:(int)suerid;

///project/getMyProjectFavorites
+(void)getMyProjectFavorites:(void (^)(NSDictionary*userDic))succ :(int)pag;

//user/showBindPhone
+(void)showBindPhone:(void (^)(NSDictionary*userDic))succ ;
///user/saveBindPhone
+(void)saveBindPhone:(void (^)(NSDictionary*userDic))succ :(NSString*)iphone :(NSString*)password;

+(void)modifyUserPass:(void (^)(NSDictionary*userDic))succ :(NSString*)old_pass :(NSString*)new_pass;

///project/getMyVoteProjects
+(void)getMyVoteProjects:(void (^)(NSDictionary*userDic))succ ;
//上传项目project/uploadLogo
+(void)uploadLogo:(void (^)(NSDictionary*userDic))succ :(int)project_id :()logo ;
//编辑页面上传头像
+(void)uploadImage:(void (^)(NSString * backUrl))succ :(UIImage *)inputImage fail:(void(^)(int errCode, NSError *err))faile isID:(BOOL)flag;
//实名认证
+ (AFRequestState *)submitPersonalId:(void (^)(NSDictionary *))succ data:(NSDictionary *)data fail:(void(^)(int errCode, NSError * err))fail;
//合格投资人认证
+(AFRequestState *)agree:(void (^)(NSDictionary *))succ fail:(void(^)(int errCode,NSError * err))fail;
@end
