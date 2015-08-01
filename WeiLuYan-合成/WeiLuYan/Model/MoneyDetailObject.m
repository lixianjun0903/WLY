//
//  MoneyDetailObject.m
//  WeiLuYan
//
//  Created by mac on 15/1/14.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "MoneyDetailObject.h"

@implementation Team


@end

@implementation MoneyParks


@end

@implementation PastFinance


@end

@implementation PersonMessage;


@end

@implementation MessageComment


@end

@implementation MoneyDetailObject
//第一个参数为数组名字，第二个参数为类名
array_item_impl(data_team, Team);
array_item_impl(data_financepast,PastFinance);
array_item_impl(data_comment,MessageComment);
array_item_impl(data_parks, MoneyParks);
@end
