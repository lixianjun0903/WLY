//
//  PeopleAddress_machine.m
//  AudioRecordDemo1
//
//  Created by cankr on 14-1-6.
//  Copyright (c) 2014年 jtyb. All rights reserved.
//

#import "PeopleAddress_machine.h"

@implementation PeopleAddress_machine

static PeopleAddress_machine *peopleAddress_m;

+ (id)shareAddress
{
    if (!peopleAddress_m)
    {
        peopleAddress_m = [[PeopleAddress_machine alloc] init];
    }
    return peopleAddress_m;
}

- (NSString *)getNameByPhoneNum:(NSString *)phoneNum
{
    _allThePeopleInfoArr = [self ReadAllPeoples];
    NSString *peopleName = @" ";
    for (int i=0; i<[_allThePeopleInfoArr count]; i++)
    {
        NSDictionary *singleDic = (NSDictionary *)[_allThePeopleInfoArr objectAtIndex:i];
        NSString *people_name = [singleDic objectForKey:@"peopleName"];
//        NSString *people_phoneNum0 = [singleDic objectForKey:@"phoneNum0"];
//        NSString *people_phoneNum1 = [singleDic objectForKey:@"phoneNum1"];
//        NSString *people_phoneNum2 = [singleDic objectForKey:@"phoneNum2"];
//        NSString *people_phoneNum3 = [singleDic objectForKey:@"phoneNum3"];
        for (int j=1; j<singleDic.count; j++)
        {
            NSString *keyStr = [[singleDic allKeys] objectAtIndex:j];
            NSString *tempPhoneNum = [NSString stringWithFormat:@"%@",[singleDic objectForKey:keyStr]];
            if ([phoneNum isEqualToString:tempPhoneNum])
            {
                peopleName = people_name;
                return people_name;
            }
        }
    }
    return peopleName;
}
-(NSMutableArray *)ReadAllPeoples
{
    NSMutableArray *allPeopleArr = [NSMutableArray arrayWithCapacity:1];
//    _allPeopleName_Arr = [NSMutableArray arrayWithCapacity:1];
    //取得本地通信录名柄
    ABAddressBookRef tmpAddressBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        tmpAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_semaphore_signal(sema);
                                                 }
                                                 );
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else
    {
        tmpAddressBook = ABAddressBookCreate();
    }
    //取得本地所有联系人记录
    NSArray* tmpPeoples = (__bridge NSArray*)ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
//    NSLog(@"readAllPeoples==========%@",tmpPeoples);
    for(id tmpPerson in tmpPeoples)
    {
        NSMutableDictionary *peopleDic = [NSMutableDictionary dictionary];
        //获取的联系人单一属性:First name
        NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
        if ([tmpFirstName isEqualToString:@"(null)"] || tmpFirstName==nil)
        {
            tmpFirstName = @"";
        }
        //获取的联系人单一属性:Last name
        NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
        NSString *people_name = [NSString stringWithFormat:@"%@%@",tmpLastName,tmpFirstName];
        if (people_name != nil && ![people_name isEqualToString:@"(null)"])
        {
            [peopleDic setObject:people_name forKey:@"peopleName"];
        }
        //获取的联系人单一属性:Generic phone number
        ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
        for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
        {
            NSString* tmpPhoneIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
            
            if (people_name != nil && ![people_name isEqualToString:@"(null)"] && tmpPhoneIndex!=nil && ![tmpPhoneIndex isEqualToString:@"(null)"])
            {
                //去掉空格
                tmpPhoneIndex = [tmpPhoneIndex stringByReplacingOccurrencesOfString:@" " withString:@""];
                //去掉回车
                tmpPhoneIndex = [tmpPhoneIndex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                if (tmpPhoneIndex.length>3)
                {
                    if ([[tmpPhoneIndex substringWithRange:NSMakeRange(0, 3)] isEqualToString:@"+86"])
                    {
                        tmpPhoneIndex = [tmpPhoneIndex substringWithRange:NSMakeRange(3, tmpPhoneIndex.length-3)];
                    }
                }
                if (tmpPhoneIndex.length == 13)
                {
                    tmpPhoneIndex = [NSString stringWithFormat:@"%@%@%@",
                                     [tmpPhoneIndex substringWithRange:NSMakeRange(0, 3)],
                                     [tmpPhoneIndex substringWithRange:NSMakeRange(4, 4)],
                                     [tmpPhoneIndex substringWithRange:NSMakeRange(9, 4)]];
                }
                [peopleDic setObject:tmpPhoneIndex forKey:[NSString stringWithFormat:@"phoneNum%d",j]];
            }
        }
        CFRelease(tmpPhones);
        
        if ([peopleDic objectForKey:@"peopleName"]!=nil && ![[peopleDic objectForKey:@"peopleName"] isEqualToString:@"(null)"])
        {
            [allPeopleArr addObject:peopleDic];
        }
    }
    //释放内存
//    CFRelease(tmpAddressBook);
    return allPeopleArr;
}
- (NSMutableArray *)getOrderNameArr
{
    NSMutableArray *allPeopleArr = [self ReadAllPeoples];
    NSMutableArray *allPeopleNameArr = [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary *infoDic in allPeopleArr)
    {
        NSString *peopleName = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"peopleName"]];
        peopleName = [peopleName stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
//        peopleName = [peopleName stringByReplacingOccurrencesOfString:@"jtyb" withString:@""];
        [allPeopleNameArr addObject:peopleName];
    }
    return [NSMutableArray arrayWithArray:[[MyChineseOrder_machine shareChineseOrder_machin] getOrderArrWithBaseArr:allPeopleNameArr]];
}
//----------------------------根据名字和总数组获取名字对应的数组
- (NSMutableArray *)getNumArrFromName:(NSString *)nameStr andInfoArr:(NSMutableArray *)infoArr
{
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<infoArr.count; i++)
    {
        NSDictionary *sigleInfoDic = [infoArr objectAtIndex:i];
        NSString *peopleName = [sigleInfoDic objectForKey:@"peopleName"];
        if ([peopleName isEqualToString:nameStr])
        {
            for (int j=1; j<sigleInfoDic.count; j++)
            {
                NSString *cIndexStr = [sigleInfoDic objectForKey:[[sigleInfoDic allKeys] objectAtIndex:j]];
                [resultArr addObject:cIndexStr];
            }
        }
    };
    return [self getSoleElementWithArr:resultArr];
};
//------------------------------获取没有重复元素的数组
- (NSMutableArray *)getSoleElementWithArr:(NSMutableArray *)baseArr
{
    NSSet *set = [NSSet setWithArray:baseArr];
    NSMutableArray *rArr = [NSMutableArray arrayWithArray:[set allObjects]];
    return rArr;
}
//========================（管理分组）获取排序数组
- (NSMutableArray *)getOrderInfoArr
{
    NSMutableArray *orderNameArr = [self getOrderNameArr];
    NSMutableArray *allInfoArr = [self ReadAllPeoples];
    NSMutableArray *orderInfoArr = [NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<allInfoArr.count; i++)
    {
        NSDictionary *singleInfoDic = [allInfoArr objectAtIndex:i];
        NSString *nameStr = [NSString stringWithFormat:@"%@",[singleInfoDic objectForKey:@"peopleName"]];
        nameStr = [nameStr stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        
        NSMutableArray *numArr = [NSMutableArray arrayWithCapacity:1];//单个联系人所有电话号码
        for (int k=0; k<singleInfoDic.count; k++)
        {
            NSString *keyStr = [singleInfoDic.allKeys objectAtIndex:k];
            NSString *unitNumStr = [NSString stringWithFormat:@"%@",[singleInfoDic objectForKey:keyStr]];
//            if (unitNumStr.length >=11)     //筛离名字
            if ([[MyOwn_machine shareOwnMachine] judgePhoneNum:unitNumStr])
            {
                [numArr addObject:unitNumStr];
            }
        }
        for (int j=0; j<numArr.count; j++)
        {
            NSString *numStr = [NSString stringWithFormat:@"%@",[numArr objectAtIndex:j]];
            NSMutableDictionary *singleNum_Dic = [NSMutableDictionary dictionaryWithCapacity:1];
            
            [singleNum_Dic setObject:numStr forKey:@"phone"];
            [singleNum_Dic setObject:nameStr forKey:@"name"];
            [orderInfoArr addObject:singleNum_Dic];
        }
    }
    NSMutableArray *resultOrderArr = [NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<orderNameArr.count; i++)
    {
        NSString *orderName = [orderNameArr objectAtIndex:i];
        for (int j=0; j<orderInfoArr.count; j++)
        {
            NSMutableDictionary *singleDic = [orderInfoArr objectAtIndex:j];
            NSString *nameStr = [singleDic objectForKey:@"name"];
            NSString *phoneStr = [singleDic objectForKey:@"phone"];
            if ([nameStr isEqualToString:orderName])
            {
                NSMutableDictionary *singleN_Dic = [NSMutableDictionary dictionaryWithCapacity:1];
                [singleN_Dic setObject:nameStr forKey:@"name"];
                [singleN_Dic setObject:phoneStr forKey:@"phone"];
                [resultOrderArr addObject:singleN_Dic];
            }
        }
    }
//    return orderInfoArr;
    return resultOrderArr;
}
- (NSMutableArray *)getAllNumArr
{
    NSMutableArray *allInfoArr = [self ReadAllPeoples];
    NSMutableArray *allNumArr = [NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<allInfoArr.count; i++)
    {
        NSDictionary *infoDic = [allInfoArr objectAtIndex:i];
        NSArray *keysArr = infoDic.allKeys;
        for (int j=1; j<keysArr.count; j++)
        {
            NSString *phoneNumStr = [NSString stringWithFormat:@"%@",[infoDic objectForKey:[keysArr objectAtIndex:j]]];
            [allNumArr addObject:phoneNumStr];
        }
    }
    return allNumArr;
}

- (BOOL)judgeIsRegistedWithNum:(NSString *)phoneNum
{
    NSMutableArray *registedArr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"registArr"]];
    NSLog(@"扩展之后电话num===============%@",registedArr);
    if (registedArr==nil || registedArr.count==0)
    {
        return NO;
    }
    else
    {
        for (id numObjc in registedArr)
        {
            NSString *numStr = [NSString stringWithFormat:@"%@",numObjc];
            if (phoneNum.length==numStr.length && [phoneNum isEqual:numStr])
            {
                return YES;
            }
        }
    }
    return NO;
}

@end
