//
//  WZGuideViewController.m
//  WZGuideViewController
//
//  Created by Wei on 13-3-11.
//  Copyright (c) 2013年 ZhuoYun. All rights reserved.
//

#import "WZGuideViewController.h"
#import "AppDelegate.h"
#import "MainNaviBar.h"
#import "MainBar.h"
#import "WRegisteredViewController.h"
#import "WLoginViewController.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define DIPHONE4 390
#define DIPHONE5 490
@interface WZGuideViewController ()

@property(nonatomic,strong)AppDelegate *app;

@end

@implementation WZGuideViewController

@synthesize animating = _animating;

@synthesize pageScroll = _pageScroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark -
+ (instancetype)loadLunchView{
    return [[[NSBundle mainBundle] loadNibNamed:@"LYLunchOnePageView" owner:self options:nil] lastObject];
}

- (CGRect)onscreenFrame
{
	return [UIScreen mainScreen].applicationFrame;
}

- (CGRect)offscreenFrame
{
	CGRect frame = [self onscreenFrame];
	switch ([UIApplication sharedApplication].statusBarOrientation)
    {
		case UIInterfaceOrientationPortrait:
			frame.origin.y = frame.size.height;
			break;
		case UIInterfaceOrientationPortraitUpsideDown:
			frame.origin.y = -frame.size.height;
			break;
		case UIInterfaceOrientationLandscapeLeft:
			frame.origin.x = frame.size.width;
			break;
		case UIInterfaceOrientationLandscapeRight:
			frame.origin.x = -frame.size.width;
			break;
	}
	return frame;
}

- (void)showGuide
{
	if (!_animating && self.view.superview == nil)
	{
		[WZGuideViewController sharedGuide].view.frame = [self offscreenFrame];
		[[self mainWindow] addSubview:[WZGuideViewController sharedGuide].view];
		
		_animating = YES;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(guideShown)];
		[WZGuideViewController sharedGuide].view.frame = [self onscreenFrame];
		[UIView commitAnimations];
	}
}

- (void)guideShown
{
	_animating = NO;
}

- (void)hideGuide
{
	if (!_animating && self.view.superview != nil)
	{
		_animating = YES;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(guideHidden)];
		[WZGuideViewController sharedGuide].view.frame = [self offscreenFrame];
		[UIView commitAnimations];
        
	}
}

- (void)guideHidden
{
	_animating = NO;
	[[[WZGuideViewController sharedGuide] view] removeFromSuperview];
}

- (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

+ (void)show
{
    [[WZGuideViewController sharedGuide].pageScroll setContentOffset:CGPointMake(0.f, 0.f)];
	[[WZGuideViewController sharedGuide] showGuide];
}

+ (void)hide
{
	[[WZGuideViewController sharedGuide] hideGuide];
}

#pragma mark - 

+ (WZGuideViewController *)sharedGuide
{
    @synchronized(self)
    {
        static WZGuideViewController *sharedGuide = nil;
        if (sharedGuide == nil)
        {
            sharedGuide = [[self alloc] init];
        }
        return sharedGuide;
    }
}

- (void)pressCheckButton:(UIButton *)checkButton
{
    [checkButton setSelected:!checkButton.selected];
}

- (void)pressEnterButton:(UIButton *)enterButton
{
    [self hideGuide];
   

    if(enterButton.tag == 101){
        [[AppDelegate instance] createMainNavBar:YES];
    }
    else{
        [[AppDelegate instance] createMainNavBar:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *imageNameArray = [NSArray arrayWithObjects:@"yingdaoye1", @"yingdaoye2", @"yingdaoye3", @"yingdaoye4", nil];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    _pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.pageScroll.pagingEnabled = YES;
    self.pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * imageNameArray.count, self.view.frame.size.height);
    [self.view addSubview:self.pageScroll];
    self.pageScroll.showsHorizontalScrollIndicator = NO;
    self.pageScroll.showsVerticalScrollIndicator = NO;
 
    UIButton *enterButtonTwo = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 70,25)];
    [enterButtonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterButtonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    enterButtonTwo.tag = 101;
    [enterButtonTwo setCenter:CGPointMake(self.view.center.x-45, iPhone5? DIPHONE5:DIPHONE4)];
    [enterButtonTwo setBackgroundImage:[UIImage imageNamed:@"登录"] forState:UIControlStateNormal];
    [enterButtonTwo setBackgroundImage:[UIImage imageNamed:@"登录"] forState:UIControlStateHighlighted];
    [enterButtonTwo addTarget:self action:@selector(pressEnterButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterButtonTwo];

    UIButton *enterButton = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f,70, 25)];
    //            [enterButton setTitle:@"开始使用牛投" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    enterButton.tag = 102;
    [enterButton setCenter:CGPointMake(self.view.center.x+40, iPhone5? DIPHONE5:DIPHONE4)];
    [enterButton setBackgroundImage:[UIImage imageNamed:@"注册"] forState:UIControlStateNormal];
    [enterButton setBackgroundImage:[UIImage imageNamed:@"注册"] forState:UIControlStateHighlighted];
    [enterButton addTarget:self action:@selector(pressEnterButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterButton];


    NSString *imgName = nil;
    UIView *view;
    
    for (int i = 0; i < imageNameArray.count; i++) {
        imgName = [imageNameArray objectAtIndex:i];

        UIImageView* bgIv = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        bgIv.image = [UIImage imageNamed:iPhone5 ? [NSString stringWithFormat:@"yindaoye%d_ip5",i+1] : [NSString stringWithFormat:@"yingdaoye%d",i+1]];
        [self.pageScroll addSubview:bgIv];
        
       }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
