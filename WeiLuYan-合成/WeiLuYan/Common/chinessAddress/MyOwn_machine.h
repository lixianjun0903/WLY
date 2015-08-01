//
//  MyOwn_machine.h
//  AudioRecordDemo1
//
//  Created by jtyb on 14-5-14.
//  Copyright (c) 2014年 jtyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOwn_machine : NSObject

+ (id)shareOwnMachine;
- (BOOL)judgePhoneNum:(NSString *)phoneNum;

@end
