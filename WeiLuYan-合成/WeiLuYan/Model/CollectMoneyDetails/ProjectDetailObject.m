//
//  ProjectDetailObject.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/27.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ProjectDetailObject.h"
#import "InvestPeopleObject.h"
#import "NewCommentObject.h"
#import "CollectParkObject.h"
#import "TeamPeopleObject.h"

@implementation ProjectDetailObject

array_item_impl(C_Backers, InvestPeopleObject);
array_item_impl(C_Comments, NewCommentObject);
array_item_impl(C_Parks, CollectParkObject);
array_item_impl(P_TeamMembers, TeamPeopleObject);         

@end
