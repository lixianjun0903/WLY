//
//  LoginAndRegistRequest.m
//  WeiLuYan
//
//  Created by weiluyan on 14/11/5.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AccountRequest.h"
#import "UserInfoRequest.h"
#import "GeneralizedProcessor.h"
#import "AFAppRequest.h"
#import "AccountModel.h"
#import "MBProgressHUD+Show.h"
@implementation AccountRequest

+(void)getMoblieCheckCode:(void (^)(int error_code))succ :(NSString*)moblieNumber :(int) way :(int)has_phone
{
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:moblieNumber,@"muname",[NSNumber numberWithInt:way],@"way",[NSNumber numberWithInt:has_phone],@"has_phone", nil];
    
    [[AccountRequest sharedClient] POST:@"wly/getPhoneCode" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         succ((int)[[responseObject objectForKey:@"error_code"] integerValue]);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
    
}

+(NSString*)sortDesc:(NSString*)str
{
    NSArray* array= [str componentsSeparatedByString:@""];
    
    NSMutableArray*arrySortDec=[NSMutableArray array];
    
    for (int i=(int)[array count]-1; i>=0; i--) {
        
        [arrySortDec addObject:[array objectAtIndex:i]];
    }
    
    NSMutableString*sortDescStr=[[NSMutableString alloc]init];
    
    for (int i=0; i<[arrySortDec count];i++) {
        
        [sortDescStr appendFormat:@"%@",[arrySortDec objectAtIndex:i]];
    }
    
    return sortDescStr;
}

+(void)accountRegister:(void (^)(NSDictionary*accessToken))block :(NSString*)moblieNumber :(NSString*)passWord :(NSString*)checkCode fail:(void (^)(int errCode, NSError * err))fail
{
    
    NSString *baseStr = [GeneralizedProcessor setPassWord:passWord];

    
    NSDictionary*parameterDic=[NSDictionary dictionaryWithObjectsAndKeys:moblieNumber,@"muname",baseStr,@"mupass",[NSNumber numberWithInt:[checkCode intValue]],@"mcode", nil];
    
    [AFAppRequest postRequestWithPost:@"wly/register" param:parameterDic succ:block fail:fail resp:nil];
}

+(void)accountLogin:(void (^)(NSDictionary*dic))succ name:(NSString *)name pass:(NSString *)passWord fail:(void (^)(int errCode, NSError * err))fail
{

    
    NSString *baseStr = [GeneralizedProcessor setPassWord:passWord];
    
    

//    NSString*baseStr=[GeneralizedProcessor base64StringFromText:[AccountRequest sortDesc:haPass]];
    
    
    NSDictionary *lonDic=@{@"muname":name,@"mupass":baseStr};
    
    
    [AFAppRequest postRequestWithPost:@"wly/login" param:lonDic succ:succ fail:fail resp:nil];
    
}

+(void)accountFoundPass:(void (^)(NSDictionary*dic))succ :(NSString*)muName :(NSString*)muPass :(NSString*)mCode fail:(void (^)(int errCode, NSError * err))fail
{
    NSString*baseStr=[GeneralizedProcessor setPassWord:muPass];
    
    NSDictionary*parameterDic=[NSDictionary dictionaryWithObjectsAndKeys:muName,@"muname",baseStr,@"mupass",[NSNumber numberWithInt:[mCode intValue]],@"mcode", nil];
    
    
    [AFAppRequest postRequestWithPost:@"wly/foundPass" param:parameterDic succ:succ fail:fail resp:nil];
    
    
    
    
}

+(void)loginweiboAndqq:(void (^)(NSDictionary*dic))succ with:(UMSocialAccountEntity *)snsAccount withWay:(int)way
{
    
    
    NSDictionary * parameterDic = @{@"way":[NSNumber numberWithInt:way],@"token":snsAccount.accessToken,@"uid":snsAccount.usid,@"user_name":snsAccount.userName,@"avatar":snsAccount.iconURL};
    
    NSDictionary * sign = @{@"third_params":parameterDic};
    
    [AFAppRequest postRequestWithPost:@"wly/thirdLogin" param:sign succ:^(NSDictionary * dic)
    {
        [[AccountModel instance] saveFromData:dic];
        succ(dic);
    }
     fail:^(int errCode, NSError *err)
    {
         if(errCode == 5012)
         {
             [MBProgressHUD creatembHub:@"服务器出错啦，请稍后再试"];
         }
         
    } resp:nil];
}

+(void)LoginWeiboAndQQ:(void (^)(NSDictionary *))succ :(int)way :(NSString *)token :(NSString *)uid :(NSString *)user_name :(NSString *)avatar
{
    NSDictionary * parameterDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:way ],@"way",token,@"token",[NSNumber numberWithInt:(int)[uid integerValue] ],@"uid",user_name,@"user_name",avatar,@"avatar", nil];
    
    NSDictionary * dataParameter = [NSDictionary dictionaryWithObjectsAndKeys:parameterDic,@"third_params", nil];
    
    [self postRequestWithToken:@"wly/thirdLogin" param:dataParameter succ:succ];
}


+(void)accountLogout:(void (^)(NSDictionary*userDic))succ
{
    
    NSMutableDictionary*parameter= [UserInfoRequest getURLSignaAndTokenDic:@"user/logout"];
    
    
    [AFAppRequest postRequestWithToken:@"user/logout" param:parameter succ:succ];
    
    
    
}
+(void)accountChangePassWord:(void (^)(NSDictionary*userDic))succ :(NSString*)old_pass :(NSString*)new_pass
{
    NSMutableDictionary*parameter= [UserInfoRequest getURLSignaAndTokenDic:@"user/modifyUserPass"];
    
    NSString*old_passdWord=[GeneralizedProcessor setPassWord:old_pass];
    
    NSString *new_paasdWord=[GeneralizedProcessor setPassWord:new_pass];
    
    NSDictionary *dataParameter=[NSDictionary dictionaryWithObjectsAndKeys:old_passdWord,@"old_pass",new_paasdWord,@"new_pass", nil];
    NSMutableDictionary*finalParameter=[[NSMutableDictionary alloc]initWithDictionary:parameter];
    [finalParameter setValuesForKeysWithDictionary:dataParameter];
    
    
    [AFAppRequest postRequestWithPost:@"user/modifyUserPass" param:finalParameter succ:succ fail:^(int errCode, NSError *err) {
        
    } resp:nil];
}


+(void)modifyPWD:(void (^)(NSNumber * result))succ :(NSString *)old_pwd :(NSString *)new_pwd
{
    NSString * old_passdWord = [GeneralizedProcessor setPassWord:old_pwd];
    
    NSString * new_paasdWord = [GeneralizedProcessor setPassWord:new_pwd];
    
    NSDictionary * dataParameter = [NSDictionary dictionaryWithObjectsAndKeys:old_passdWord,@"old_pass",new_paasdWord,@"new_pass", nil];
    
    [self postRequestWithToken:@"user/modifyUserPass" param:dataParameter succ:succ];
}

//第三方绑好账号
+(void)accountBindThird:(int)num with:(void (^)(NSDictionary*dic))succ
{
    NSDictionary * param = @{@"type":[NSNumber numberWithInt:num]};
    
    [self postRequestWithToken:@"/user/bindThirdRes" param:param succ:succ];
}




@end
