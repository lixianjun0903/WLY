//
//  NewCommentObject.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/27.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface NewCommentObject : NSObject<Expose>

@property(nonatomic,strong)NSString * C_CommentDetail;
@property(nonatomic,strong)NSString * U_Avator;
@property(nonatomic,strong)NSString * U_CommentTime;
@property(nonatomic,strong)NSString * U_ID;
@property(nonatomic,assign)int U_Level;
@property(nonatomic,strong)NSString * U_Name;
@property(nonatomic,strong)NSString * U_Nick_Name;
@property(nonatomic,strong)NSString * U_R_Avator;
@property(nonatomic,assign)int U_R_ID;
@property(nonatomic,assign)int U_R_Level;
@property(nonatomic,strong)NSString * U_R_Name;
@property(nonatomic,strong)NSString * U_User_Company;
@property(nonatomic,strong)NSString * U_User_Office;


@end
