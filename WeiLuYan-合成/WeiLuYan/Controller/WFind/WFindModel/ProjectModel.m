//
//  ProjectModel.m
//  WeiLuYan
//
//  Created by 张亮 on 14/11/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "ProjectModel.h"

@implementation ProjectModel
-(id)initWithValueDic:(NSDictionary*)dataDic
{
    self=[super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dataDic];
    }
    return self;
}
-(void)setValueForProperty:(NSDictionary*)dataDic
{
    
}
@end
