//
//  WBindAndQuit.m
//  WeiLuYan
//
//  Created by dev on 14/12/12.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WBindAndQuit.h"
#import "WAboutUsViewController.h"
#import "WChangePWDViewController.h"
#import "WFeedbackViewController.h"
#import "AccountRequest.h"
#import "AppDelegate.h"

@implementation WBindAndQuit

+(void)ControllersForPush:(UINavigationController *)con :(NSIndexPath *)indexPath
{
    if (indexPath.row == 4)
    {
        WAboutUsViewController * ab = [[WAboutUsViewController alloc]initWithNibName:@"WAboutUsViewController" bundle:nil];
        [con pushViewController:ab animated:YES];
    }
    
    if (indexPath.row == 3)
    {
        WFeedbackViewController * fee = [[WFeedbackViewController alloc]initWithNibName:@"WFeedbackViewController" bundle:nil];
        [con pushViewController:fee animated:YES];
    }
    
    if (indexPath.row == 2)
    {
        WChangePWDViewController * chpass = [[WChangePWDViewController alloc]initWithNibName:@"WChangePWDViewController" bundle:nil];
        [con pushViewController:chpass animated:YES];
    }
}

+(void)BindForQQ:(NSIndexPath *)indexPath :(WSetViewController *)ViewCon
{
    if (indexPath.row == 0)
    {
        NSString * platformName = @"qzone";
        
        [UMSocialControllerService defaultControllerService].socialUIDelegate = ViewCon;
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
        
        
        
        snsPlatform.loginClickHandler(ViewCon,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
        {
            //获取微博用户名、uid、token等
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
                NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
                
                [AccountRequest LoginWeiboAndQQ:^(NSDictionary *result)
                {
                    NSLog(@"LoginWeiboAndQQ result:%@",result);
                    [[AccountModel instance] setPersonalToken:[result objectForKey:@"token"]];
                } :1 :snsAccount.accessToken :snsAccount.usid :snsAccount.userName :snsAccount.iconURL];
            }
        });
    }
}

+(void)bindForWeibo:(NSIndexPath *)indexPath :(WSetViewController *)ViewCon
{
    if (indexPath.row == 1)
    {
        NSString * platformName = @"sina";
        
        [UMSocialControllerService defaultControllerService].socialUIDelegate  = ViewCon;
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
        
        snsPlatform.loginClickHandler(ViewCon,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
        {
            //获取微博用户名、uid、token等
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
                NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
                
                [AccountRequest LoginWeiboAndQQ:^(NSDictionary *result)
                {
                    [[AccountModel instance]setPersonalToken:[result objectForKey:@"token"]];
                } :2 :snsAccount.accessToken :snsAccount.usid :snsAccount.userName :snsAccount.iconURL];
            }
        });
    }
}

+(void)Quit:(BOOL)BindToWeibo
{
    if (BindToWeibo == false)
    {
        [AccountRequest accountLogout:^(NSDictionary *userDic)
        {
                [[AccountModel instance] clearTokenAndInfo];
        }];
    }
    
    if (BindToWeibo == true)
    {
        [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
            NSLog(@"response is %@",response);
        }];
    }

    
    [[AccountModel instance] clearTokenAndInfo];
}

@end
