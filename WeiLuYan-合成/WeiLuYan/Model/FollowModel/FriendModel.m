//
//  FirFriendModel.m
//  WeiLuYan
//
//  Created by jikai on 14-12-10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "FriendModel.h"
#import "MBProgressHUD+Show.h"
#import "UserInfoRequest.h"

@implementation FriendModel
#pragma mark 刷新数据
-(void )loadFriendData:(int)tid urlbool:(BOOL)yrlbool controller:(UIViewController *)vc finish:(void (^)(NSArray *))block
{
    int pag=1;
    NSString *userurl;
    if (yrlbool==YES) {
        //一度人脉
        userurl=@"friend/friendaLists";
    }else
    {
        //二度人脉
        userurl=@"friend/friendbLists";
    }
    
    // NSLog(@"一度二度人脉的标签==pag=%d,biapqian=%d,userl=%@",pag,biaoqian,userurl);
    
    // [self.oldDataArray removeAllObjects ];
    // NSLog(@"_arrBiaoQiantag_id+%@",  [_arrBiaoQiantag_id  objectAtIndex:0]);
    
    MBProgressHUD * mbHud = [MBProgressHUD mbHubShow];
    
    
    [UserInfoRequest friendaLists:^(NSArray *dic) {
        block(dic);
        [mbHud removeFromSuperview];
    } :userurl :pag :tid fail:^(int errCode, NSError *err) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"请补全你的信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        [mbHud removeFromSuperview];
    }];
    
    
    // _fu.hidden=YES;
}

@end
