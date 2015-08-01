//
//  FavouritePerson.h
//  WeiLuYan
//
//  Created by wly on 15/3/19.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface FavouritePerson : NSObject<Expose>
@property (nonatomic,assign) int attention_user_isnull;
//宏定义 将数组里面的内容转成model
array_item_def(attention_user_arr);
@property (nonatomic,strong) NSMutableArray * attention_user_arr;

@end
