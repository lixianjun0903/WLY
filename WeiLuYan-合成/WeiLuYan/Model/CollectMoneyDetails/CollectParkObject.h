//
//  CollectParkObject.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/27.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface CollectParkObject : NSObject<Expose>

@property(nonatomic,assign)int C_Park_ID;
@property(nonatomic,assign)int C_Park_Price;
@property(nonatomic,strong)NSString * C_Park_Name;
@property(nonatomic,strong)NSString * C_Park_Description;
@property(nonatomic,assign)int C_Park_Claimed;


@end
