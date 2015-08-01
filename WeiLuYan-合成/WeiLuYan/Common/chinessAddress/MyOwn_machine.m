//
//  MyOwn_machine.m
//  AudioRecordDemo1
//
//  Created by jtyb on 14-5-14.
//  Copyright (c) 2014年 jtyb. All rights reserved.
//

#import "MyOwn_machine.h"

@implementation MyOwn_machine

static MyOwn_machine*own_machine;

+ (id)shareOwnMachine
{
    if (own_machine == nil)
    {
        own_machine = [[MyOwn_machine alloc] init];
    }
    return own_machine;
}
- (BOOL)judgePhoneNum:(NSString *)phoneNum
{
    if (phoneNum.length>11)
    {
        phoneNum = [phoneNum substringWithRange:NSMakeRange(phoneNum.length-11, 11)];
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:phoneNum];
}

@end
