//
//  ProjectDetailObject.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/27.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
#import "NewCollectMoneyObject.h"

@interface ProjectDetailObject : NSObject<Expose>

array_item_def(C_Backers)
@property(nonatomic,strong)NSArray * C_Backers;

array_item_def(C_Comments)
@property(nonatomic,strong)NSArray * C_Comments;

@property(nonatomic,strong)NewCollectMoneyObject * C_Info;

array_item_def(C_Parks);
@property(nonatomic,strong)NSArray * C_Parks;

@property(nonatomic,assign)int P_IndId;
@property(nonatomic,strong)NSString * P_Name;
@property(nonatomic,assign)int P_AddrID;
@property(nonatomic,assign)int P_EditTime;
@property(nonatomic,strong)NSString * P_DescUrl;
@property(nonatomic,assign)int P_FundedPeopleCount;
@property(nonatomic,assign)int P_CommentedPeopleCount;

array_item_def(P_TeamMembers);
@property(nonatomic,strong)NSArray * P_TeamMembers;


@end
