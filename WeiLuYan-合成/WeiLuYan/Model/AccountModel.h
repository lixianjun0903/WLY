//
//  AccountModel.h
//  WeiLuYan
//
//  Created by gaob on 14/12/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalInfoModel.h"

@interface AccountModel : NSObject

@property (nonatomic, copy) NSString * personalToken;

@property (nonatomic, strong) PersonalInfoModel * personInfoModel;

+(id)instance;
//保存token
-(void)saveToken:(NSString *)token;

//-(void)savePersonalInfo:(PersonalInfoModel * )model;
//是否有token
-(BOOL)hasToken;
//清楚token和数据，用在注销时。
-(void)clearTokenAndInfo;
//将网络获取的用户信息保存进model与本地。
-(void)saveFromData:(NSDictionary *)dataDic;
//获取token
-(NSString *)getToken;
//获取用户信息从数据
-(void)savePersonalInfoFromDic:(NSDictionary *)infoDic;
//获取，设置头像的url
-(void)setIconUrl:(NSString*)iconUrl;
//获得用户信息和token
-(void)getUserInfoAndToken;

@end
