//
//  MyFollowViewController.m
//  WeiLuYan
//
//  Created by gaob on 14/12/9.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WFollowViewController.h"
#import "FirstFriendViewController.h"
#import "SecondFriendViewController.h"

#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

@interface WFollowViewController ()
{
    UITabBarController * _tabBarController;
    UIButton * _firFriendButton;
    UIButton * _secFriendButton;
    UIButton * _flagButton;
}
@property (weak, nonatomic) IBOutlet UIButton *firstFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *secondFriendButton;

@end

@implementation WFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self firstFriendClick];
    [self createTabBar];
}


#pragma mark 创建内嵌tabBar
-(void)createTabBar
{
    //创建tabBar
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.view.frame = CGRectMake(0, 50, WIDTH, HEIGHT - 49);
    _tabBarController.tabBar.hidden = YES;
    [self.view addSubview:_tabBarController.view];
    
    //初始化tabBar页面
    FirstFriendViewController * first = [[FirstFriendViewController alloc] init];
    SecondFriendViewController * sec = [[SecondFriendViewController alloc] init];
    _tabBarController.viewControllers = @[first,sec];
}

- (IBAction)firstFriendClick {
    if(self.firstFriendButton.selected){
        return;
    }
    self.firstFriendButton.selected = YES;
    self.secondFriendButton.selected = NO;
    [_tabBarController setSelectedIndex:0];
}

- (IBAction)secondFriendClick {
    if(self.secondFriendButton.selected){
        return;
    }
    self.secondFriendButton.selected = YES;
    self.firstFriendButton.selected = NO;
    [_tabBarController setSelectedIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

