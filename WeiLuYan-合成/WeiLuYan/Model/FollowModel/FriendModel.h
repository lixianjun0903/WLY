//
//  FirFriendModel.h
//  WeiLuYan
//
//  Created by jikai on 14-12-10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject

-(void )loadFriendData:(int)tid urlbool:(BOOL)yrlbool controller:(UIViewController *)vc finish:(void(^)(NSArray *))block;

@end
