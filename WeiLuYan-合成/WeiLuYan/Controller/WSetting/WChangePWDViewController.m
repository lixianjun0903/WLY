//
//  WChangePWDViewController.m
//  WeiLuYan
//
//  Created by dev on 14/12/12.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WChangePWDViewController.h"
#import "UserInfoRequest.h"
#import "AccountRequest.h"
#import "WLoginViewController.h"
#import "AppDelegate.h"

@interface WChangePWDViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    __weak IBOutlet UITextField *prevTextField;
    
    __weak IBOutlet UITextField *newPWD;
    
    __weak IBOutlet UITextField *confirmPWDTextField;
    
    __weak IBOutlet UIButton *savePWDButton;
}

@end

@implementation WChangePWDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [confirmPWDTextField resignFirstResponder];
    [prevTextField resignFirstResponder];
    [newPWD resignFirstResponder];

}

- (IBAction)savePWDClick:(id)sender
{
    if (confirmPWDTextField.text.length < 6 || newPWD.text.length < 6||confirmPWDTextField.text.length > 16 || newPWD.text.length > 16) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码为6-16位，请重新输入！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if ([[NSString stringWithFormat:@"%@", newPWD.text ] isEqualToString:[NSString stringWithFormat:@"%@", confirmPWDTextField.text ]])
    {
        
        
        [AccountRequest modifyPWD:^(NSNumber *result)
        {
            if (result == [NSNumber numberWithLong:1])
            {
                UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"修改成功！请重新登录！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                av.delegate = self;
                [av show];
            }
        } :prevTextField.text :newPWD.text];
    }
    
    else
    {
        NSLog(@"两次输入密码不一样");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"两次输入的密码不一样请从新输入" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[AppDelegate instance] appLogout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
