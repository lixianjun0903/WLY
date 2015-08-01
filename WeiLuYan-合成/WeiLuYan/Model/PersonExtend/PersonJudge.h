//
//  PersonJiCheng.h
//  WeiLuYan
//
//  Created by weiluyan on 14/11/8.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "PersonalInfoModel.h"

@interface PersonJudge : PersonalInfoModel
@property(nonatomic,assign)int is_edit;
@property(nonatomic,assign)int is_friend;
@property(nonatomic,strong)NSString *job;
@property(nonatomic,assign)int  friend_id;

@end
