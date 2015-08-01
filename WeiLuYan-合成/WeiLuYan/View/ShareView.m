//
//  ShareView.m
//  YaWan
//
//  Created by WL-DZ-PGDN-007 on 15-3-31.
//  Copyright (c) 2015年 Mac-Xuan. All rights reserved.
//

#import "ShareView.h"
#import "GeneralizedProcessor.h"
#import "AppDelegate.h"
#import "FeedRequest.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

@implementation ShareView
alloc_with_xib(ShareView)

-(void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    _view.layer.masksToBounds = YES;
    _view.layer.cornerRadius = 8;
    _sinaImageView.image = [UIImage imageNamed:@""];
    _weixinImageView.image = [UIImage imageNamed:@""];
    _selectTag = 2;
}

- (id)initWithViewController:(UIViewController *)vc ID:(int)projectID
{
    if(self = [super init]){
        self.vc = vc;
        self.projectID = projectID;
    }
    return self;
}

- (void)show
{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    _selectTag = sender.tag - 1000;
    switch (sender.tag - 1000) {
        case 1:
        {
            _sinaImageView.image = [UIImage imageNamed:@"btn_background_highlight"];
            _qqImageView.image = [UIImage imageNamed:@""];
            _weixinImageView.image = [UIImage imageNamed:@""];
            
        }
            break;
            
        case 2:
        {
            _sinaImageView.image = [UIImage imageNamed:@""];
            _qqImageView.image = [UIImage imageNamed:@"btn_background_highlight"];
            _weixinImageView.image = [UIImage imageNamed:@""];
            
        }
            break;
            
        case 3:
        {
            _sinaImageView.image = [UIImage imageNamed:@""];
            _qqImageView.image = [UIImage imageNamed:@""];
            _weixinImageView.image = [UIImage imageNamed:@"btn_background_highlight"];
        }
            break;
            
    }

}

- (IBAction)shareClick {
    
    [_view removeFromSuperview];
    _share = [[shareDesc alloc] initWithFrame:CGRectMake(10, 100, 300, 210)];
    __weak ShareView * sa = self;
    [FeedRequest shareProject:^(ShareObject *data) {
        [sa.share setData:data];
        [self addSubview:_share];
    } fail:^(int errCode, NSError *err) {
        if(errCode == 2022){
            [[[UIAlertView alloc] initWithTitle:nil message:@"该项目目前不能分享" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
            [self cancleClick];
        }
    } ID:_projectID];
    
    _share.cancle = ^{
        [sa cancleClick];
    };
    
    _share.send = ^{
        [sa shareWithTag:sa.selectTag];
    };

}


-(void)shareWithTag:(int)tag
{
    if(self.vc != nil){
    if (tag==3)
        {
            [UMSocialWechatHandler setWXAppId:@"wxd67d380f266769e2" appSecret:@"146e1b3119ebfaa6bc429f80e429ed1c" url:_share.url];
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:_share.contentTextView.text image:_share.projectImg.image location:nil urlResource:nil presentedController:_vc completion:^(UMSocialResponseEntity *response){
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    [[[UIAlertView alloc] initWithTitle:@"分享" message:@"分享成功" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                    [self cancleClick];
                }
                
            }];
        }
        else if (tag==2)
        {
            [UMSocialQQHandler setQQWithAppId:@"1104451983" appKey:@"cwtGukJMHbbHa9hO" url:_share.url];
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:_share.contentTextView.text image:_share.projectImg.image location:nil urlResource:nil presentedController:_vc completion:^(UMSocialResponseEntity *response){
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    [[[UIAlertView alloc] initWithTitle:@"分享" message:@"分享成功" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                    [self cancleClick];
                }
            }];
            
        }
        else{
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:_share.contentTextView.text image:_share.projectImg.image location:nil urlResource:nil presentedController:_vc completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    [[[UIAlertView alloc] initWithTitle:@"分享" message:@"分享成功" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                    [self cancleClick];
                }
                
            }];
            
        }
    }
    //[self cancleClick];
}

- (IBAction)cancleClick {
    
    [self removeFromSuperview];
}

@end

