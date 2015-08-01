//
//  NewCollectMoneyObject.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/27.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface NewCollectMoneyObject : NSObject<Expose>

@property(nonatomic,assign)int C_FundTarget;
@property(nonatomic,assign)int C_Funded;
@property(nonatomic,assign)int C_LeftTime;
@property(nonatomic,assign)int C_ImageType;
@property(nonatomic,strong)NSString * C_ImageURL;
@property(nonatomic,strong)NSString * C_VideoName;
@property(nonatomic,strong)NSString * C_VideoUnique;
@property(nonatomic,strong)NSString * C_LongDescrip;
@property(nonatomic,strong)NSString * C_ShortDescrip;

@end
