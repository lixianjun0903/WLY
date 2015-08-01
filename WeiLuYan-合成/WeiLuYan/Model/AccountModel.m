//
//  AccountModel.m
//  WeiLuYan
//
//  Created by gaob on 14/12/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AccountModel.h"
#define ACCOUNTTOKEN @"accountToken"
#define ACCOUNTUSERINFO @"accountUserInfo"

@implementation AccountModel

static AccountModel * manager = nil;

+(id)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[AccountModel alloc]init];
            manager.personInfoModel = [[PersonalInfoModel alloc]init];
            [manager getUserInfoAndToken];

        }
    });
    
    if (manager.personInfoModel == nil)
    {
        manager.personInfoModel = [[PersonalInfoModel alloc]init];
    }

    [manager getToken];
    
    return manager;
}

-(BOOL)hasToken
{

    if (manager.personalToken == nil || [manager.personalToken isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}
-(void)saveToken:(NSString *)token
{
    if (token && ![token isEqualToString:@""])
    {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        
        //保存登陆的token
        [user setObject:token forKey:ACCOUNTTOKEN];
        
        [user synchronize];
        
    }
    
    manager.personalToken = [NSString stringWithString:token];
    
}

-(void)savePersonalInfoFromDic:(NSDictionary *)infoDic
{
    
    [manager.personInfoModel setValuesForKeysWithDictionary:infoDic];
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:infoDic forKey:ACCOUNTUSERINFO];
    
    [user synchronize];
}

-(void)clearTokenAndInfo
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user removeObjectForKey:ACCOUNTTOKEN];
    
    [user removeObjectForKey:ACCOUNTUSERINFO];
    
    [user removeObjectForKey:@"FLAG"];
    
    [user synchronize];
    
    manager.personalToken = nil;
    
    manager.personInfoModel = nil;
}

-(void)saveFromData:(NSDictionary *)dataDic
{
    NSLog(@"%@",dataDic);
    
    [manager saveToken:dataDic[@"token"]];
    
    [manager savePersonalInfoFromDic:dataDic[@"user_info"]];
    
}

-(NSString *)getToken
{
    return manager.personalToken;
}
-(void)getUserInfoAndToken
{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    manager.personalToken = [user objectForKey:ACCOUNTTOKEN];
    
    NSDictionary * dic = [NSDictionary dictionaryWithDictionary:[user objectForKey:ACCOUNTUSERINFO]];
    [manager.personInfoModel setValuesForKeysWithDictionary:dic];

}

-(void)setIconUrl:(NSString*)iconUrl
{
    
    manager.personInfoModel.avatar = iconUrl;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary * mdic = [user objectForKey:ACCOUNTUSERINFO];
    
    [mdic setObject:iconUrl forKey:@"avatar"];

    [user setObject:mdic forKey:ACCOUNTUSERINFO];
    
    [user synchronize];
    
}

@end
