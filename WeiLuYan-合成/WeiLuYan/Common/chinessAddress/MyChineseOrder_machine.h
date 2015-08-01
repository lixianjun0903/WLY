//
//  MyChineseOrder_machine.h
//  AudioRecordDemo1
//
//  Created by cankr on 13-12-30.
//  Copyright (c) 2013年 jtyb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "pinyin.h"
#import "ChineseString.h"

@interface MyChineseOrder_machine : NSObject

+ (id)shareChineseOrder_machin;
- (NSArray *)getOrderArrWithBaseArr:(NSArray *)baseArr;

@end
