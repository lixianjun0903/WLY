//
//  TeamPeopleObject.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/27.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface TeamPeopleObject : NSObject<Expose>

@property(nonatomic,strong)NSString * U_Name;
@property(nonatomic,strong)NSString * U_ID;
@property(nonatomic,strong)NSString * U_Nick_Name;
@property(nonatomic,strong)NSString * U_User_Office;
@property(nonatomic,strong)NSString * U_Avator;
@property(nonatomic,strong)NSString * U_User_Company;
@property(nonatomic,assign)int U_Level;

@end
