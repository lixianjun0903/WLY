//
//  LoginAndRegistRequest.h
//  WeiLuYan
//
//  Created by weiluyan on 14/11/5.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AFAppRequest.h"
#import "UMSocial.h"

@interface AccountRequest : AFAppRequest
//获取验证码
+(void)getMoblieCheckCode:(void (^)(int error_code))succ :(NSString*)moblieNumber :(int) way :(int)has_phone;
//注册
+(void)accountRegister:(void (^)(NSDictionary*accessToken))succ :(NSString*)moblieNumber :(NSString*)passWord :(NSString*)checkCode fail:(void (^)(int errCode, NSError * err))fail;
//登陆
+(void)accountLogin:(void (^)(NSDictionary*dic))succ name:(NSString*)name pass:(NSString*)passWord fail:(void (^)(int errCode, NSError * err))fail;
//忘记密码
+(void)accountFoundPass:(void (^)(NSDictionary*dic))succ :(NSString*)muName :(NSString*)muPass :(NSString*)mCode fail:(void (^)(int errCode, NSError * err))fail;

//QQ 微博登陆
+(void)loginweiboAndqq:(void (^)(NSDictionary*dic))block with:(UMSocialAccountEntity *)snsAccount withWay:(int)way;

+(void)LoginWeiboAndQQ:(void(^)(NSDictionary * result))succ :(int)way :(NSString *)token :(NSString *)uid :(NSString *)user_name :(NSString *)avatar;

+(NSString*)sortDesc:(NSString*)str;

//绑定第三方账号
+(void)accountBindThird:(int)num with:(void (^)(NSDictionary*dic))succ;

//退出登录user/logout
+(void)accountLogout:(void (^)(NSDictionary*userDic))succ;
//修改密码/user/modifyUserPass
+(void)accountChangePassWord:(void (^)(NSDictionary*userDic))succ :(NSString*)old_pass :(NSString*)new_pass;
+(void)modifyPWD:(void(^)(NSNumber * result))succ :(NSString *)old_pwd :(NSString *)new_pwd;


//收藏项目
+(void)accountCollectWithId:(int)collectId with:(void(^)(NSDictionary * result))succ;


//
/////////////////网络更新12.15//////////////
//
//+(void)modifyUserPassNew:(void (^)(NSDictionary*dic))succ :(NSString*)old_pass :(NSString*)new_pass;
//
//+(void)logoutNew:(void (^)(NSDictionary*dic))succ ;
//
//+(void)registerAccountNew:(void (^)(NSDictionary*dic))succ :(NSString*)moblieNumber :(NSString*)passWord :(NSString*)checkCode;

/////////////longin
//+(AFRequestState*)LonginNew:(void (^)(NSDictionary*commentDic))succ name:(NSString*)name pass:(NSString*)passWord;


@end
