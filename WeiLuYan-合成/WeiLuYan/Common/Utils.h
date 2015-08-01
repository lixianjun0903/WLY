//
//  Utils.h
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/15.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>


#define alloc_with_xib(xib_file) \
+(id)alloc \
{ \
    static BOOL loading = NO; \
    \
    if( loading ){ \
        return [super alloc]; \
    } \
    \
    loading = YES; \
    id obj = [[NSBundle mainBundle]loadNibNamed:@#xib_file owner:nil options:nil][0]; \
    \
    loading = NO; \
    \
    return obj; \
}


@interface Utils : NSObject

@end
