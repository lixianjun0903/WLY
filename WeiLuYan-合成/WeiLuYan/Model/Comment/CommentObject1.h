//
//  CommentObject.h
//  WeiLuYan
//
//  Created by 张亮 on 14/11/13.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalInfoModel.h"

@interface CommentObject1 : NSObject
@property( nonatomic, strong)PersonalInfoModel*commentPersonModel;
@property( nonatomic, strong)NSString*commentContent;
@property( nonatomic, strong)PersonalInfoModel*replyPersonModel;
@property( nonatomic, strong)NSString* timeStr;

-(id)initWithValueDic:(NSDictionary*)dataDic;
@end
