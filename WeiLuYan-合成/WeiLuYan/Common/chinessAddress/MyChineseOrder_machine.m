//
//  MyChineseOrder_machine.m
//  AudioRecordDemo1
//
//  Created by cankr on 13-12-30.
//  Copyright (c) 2013年 jtyb. All rights reserved.
//

#import "MyChineseOrder_machine.h"

@implementation MyChineseOrder_machine

static MyChineseOrder_machine *myCO_machine;

+ (id)shareChineseOrder_machin
{
    if (myCO_machine == nil)
    {
        myCO_machine = [[MyChineseOrder_machine alloc] init];
    }
    return myCO_machine;
}
- (NSArray *)getOrderArrWithBaseArr:(NSArray *)baseArr
{
    //:获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[baseArr count];i++){
        ChineseString *chineseString=[[ChineseString alloc]init];
        
        chineseString.string=[NSString stringWithString:[baseArr objectAtIndex:i]];
        
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        if(![chineseString.string isEqualToString:@""]){
            NSString *pinYinResult=[NSString string];
            for(int j=0;j<chineseString.string.length;j++){
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                
                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin=pinYinResult;
        }else{
            chineseString.pinYin=@"";
        }
        [chineseStringsArray addObject:chineseString];
    }
    //按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray *result=[NSMutableArray array];
    for(int i=0;i<[chineseStringsArray count];i++)
    {
        NSString *cUnitStr = ((ChineseString*)[chineseStringsArray objectAtIndex:i]).string;
        if (![self arrayAddObjectWithArr:result andObject:cUnitStr])        //不存在已存名字
        {
            [result addObject:((ChineseString*)[chineseStringsArray objectAtIndex:i]).string];
        }
    }
    return result;
}
//判断一个数组里面是否存在名字字符串
- (BOOL)arrayAddObjectWithArr:(NSMutableArray *)resultArr andObject:(NSString *)nameStr
{
    for (int i=0; i<resultArr.count; i++)
    {
        NSString *unitStr = [NSString stringWithFormat:@"%@",[resultArr objectAtIndex:i]];
        if ([nameStr isEqualToString:unitStr])
        {
            return YES;
        }
    }
    return NO;
}

//- (NSArray *)getInfoArrWithBaseArr:(NSArray *)baseArr
//{
//    //:获取字符串中文字的拼音首字母并与字符串共同存放
//    NSMutableArray *chineseStringsArray=[NSMutableArray array];
//    for(int i=0;i<[baseArr count];i++){
//        ChineseString *chineseString=[[ChineseString alloc]init];
//        
//        chineseString.string=[NSString stringWithString:[[baseArr objectAtIndex:i] objectForKey:@"peopleName"]];
//        
//        if(chineseString.string==nil){
//            chineseString.string=@"";
//        }
//        
//        if(![chineseString.string isEqualToString:@""]){
//            NSString *pinYinResult=[NSString string];
//            for(int j=0;j<chineseString.string.length;j++){
//                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
//                
//                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
//            }
//            chineseString.pinYin=pinYinResult;
//        }else{
//            chineseString.pinYin=@"";
//        }
//        [chineseStringsArray addObject:chineseString];
//    }
//    //按照拼音首字母对这些Strings进行排序
//    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
//    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
//    
//    NSMutableArray *result=[NSMutableArray array];
//    for(int i=0;i<[chineseStringsArray count];i++){
//        [result addObject:((ChineseString*)[chineseStringsArray objectAtIndex:i]).string];
//    }
//    return result;
//}

@end
