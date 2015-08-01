//
//  PeopleAddress_machine.h
//  AudioRecordDemo1
//
//  Created by cankr on 14-1-6.
//  Copyright (c) 2014年 jtyb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>

#import "MyChineseOrder_machine.h"
#import "MyOwn_machine.h"

@interface PeopleAddress_machine : NSObject
{
    NSMutableArray *_allThePeopleInfoArr;
}

+ (id)shareAddress;
- (NSString *)getNameByPhoneNum:(NSString *)phoneNum;

-(NSMutableArray *)ReadAllPeoples;
- (NSMutableArray *)getOrderNameArr;
- (NSMutableArray *)getOrderInfoArr;
- (NSMutableArray *)getNumArrFromName:(NSString *)nameStr andInfoArr:(NSMutableArray *)infoArr;
- (NSMutableArray *)getAllNumArr;

- (BOOL)judgeIsRegistedWithNum:(NSString *)phoneNum;

@end
