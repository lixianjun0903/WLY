//
//  VideoPlayController.m
//  WeiLuYan
//
//  Created by mac on 15/1/6.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "VideoPlayController.h"
#import "LTPlayerSDK.h"
#import "AppDelegate.h"

@interface VideoPlayController ()<LTPlayerDelegate>
@property (nonatomic,assign) BOOL m_bScreen;

@end

@implementation VideoPlayController

-(void)viewWillAppear:(BOOL)animated
{
    [AppDelegate getNav].navigationBar.hidden = YES;
    
    [AppDelegate instance].MainBar.NaveBar.hidden = YES;
    
    [AppDelegate instance].ori_flag = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    UIView *view = [LTPlayerSDK getPlayerView];
    [LTPlayerSDK setPlayerViewFrame:CGRectMake(0, 0, 320, 180)];
    [LTPlayerSDK setMoviePlayerShowStyle:LTMoviePlayerShowStyleCustomSize];
    [self.view addSubview:view];
    NSLog(@"%@",[LTPlayerSDK getLTPlayerSDKVersion]);
    
    [LTPlayerSDK showWithUserUnique:@"08618ed261"
                        videoUnique:self.videoUnique
                          videoName:self.videoName
                          payerName:@""
                          checkCode:@""
                                 ap:NO
                   inViewController:self
                     playerDelegate:self];
    
}

- (void)viewWillLayoutSubviews {
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        _m_bScreen = NO;
        [LTPlayerSDK setPlayerViewFrame:CGRectMake(0, 0, 568, 320)];
        [LTPlayerSDK setMoviePlayerShowStyle:LTMoviePlayerShowStyleFullScreen];
        
    }else{
        _m_bScreen = YES;
        [LTPlayerSDK setPlayerViewFrame:CGRectMake(0, 0, 320, 500)];
        [LTPlayerSDK setMoviePlayerShowStyle:LTMoviePlayerShowStyleCustomSize];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) LTPlayerViewFullBtnClickEvent{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
    {
        NSNumber *num = [[NSNumber alloc] initWithInt:(_m_bScreen?UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait)];
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(id)num];
        [UIViewController attemptRotationToDeviceOrientation];
    }
    SEL selector=NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation =[NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = _m_bScreen?UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
    
}

- (void) LTPlayerViewTopBackBtnClickEvent {
    [self LTPlayerViewFullBtnClickEvent];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [LTPlayerSDK dismiss:YES];
    [AppDelegate getNav].navigationBar.hidden = NO;
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
    [AppDelegate instance].ori_flag = 0;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
