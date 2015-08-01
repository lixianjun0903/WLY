//
//  MyFindViewController.m
//  WeiLuYan
//
//  Created by gaob on 14/12/9.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WFindViewController.h"
#import "WProjectViewController.h"
#import "WFriendViewController.h"
#import "AppDelegate.h"
#import "WEditViewController.h"

@interface WFindViewController ()

@property (weak, nonatomic) IBOutlet UIButton *projectButton;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (nonatomic,strong) UITabBarController * Ground;

@end

@implementation WFindViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self createGround];
    [self projectClick:self.projectButton];
}

#pragma mark - 创建二级TabBar
-(void)createGround
{
    WProjectViewController * proViewController = [WProjectViewController new];
    
    [proViewController setFindViewController:self];
    
    WFriendViewController * friViewController = [WFriendViewController new];
    
    _Ground =[[UITabBarController alloc]init];
    
    _Ground.viewControllers = @[proViewController,friViewController];
    
    _Ground.view.frame = CGRectMake(0, 65, WIDTH, HEIGHT - 10 - 45 - 10 - 70);
    _Ground.tabBar.hidden = YES;
    [self.view addSubview:_Ground.view];
}

#pragma mark AlertView的代理函数
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        [_Ground setSelectedIndex:1];
    }
    else
    {
        //跳转到编辑页面
        WEditViewController * mine = [WEditViewController new];
        [[AppDelegate getNav] pushViewController:mine animated:YES];
        [_Ground setSelectedIndex:1];
    }
}


- (IBAction)projectClick:(UIButton *)sender
{

    if(sender.selected){
        return;
    }
    
    self.projectButton.selected = YES;
    self.friendButton.selected = NO;
    [_Ground setSelectedIndex:0];
}

- (IBAction)friendClick:(UIButton *)sender
{

    if(sender.selected){
        return;
    }
    
    self.projectButton.selected = NO;
    self.friendButton.selected = YES;
    [[[UIAlertView alloc] initWithTitle:@"补充个人信息" message:@"建议您现在补全个人信息，以方便您交到更多的朋友，为您的投资，创业助力！" delegate:self cancelButtonTitle:@"跳过" otherButtonTitles:@"马上补充",nil] show];
}



- (void)didReceiveMemoryWarning
{
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
