//
//  WLY_LoginViewController.m
//  WLY—-ONE
//
//  Created by weiluyan on 14-9-17.
//  Copyright (c) 2014年 weiluyan. All rights reserved.
//

#import "WLoginViewController.h"
#import "GeneralizedProcessor.h"
#define KEY  @"2614596120"
#define URLR @"http://lyb.qinminwang.cn"
#import "AppDelegate.h"
#import "WRegisteredViewController.h"
#import "WRetrievePasswordViewController.h"
#import "GeneralizedProcessor.h"
#import "UIImageView+WebCache.h"
#import "AccountRequest.h"
#import "MBProgressHUD+Show.h"
#import "UserInfoRequest.h"


#define Placeholder  13
#define TeHight  45
#define JianJuHight  10

#define TEXTFIELDWIDTH 220

//#define WIDTH

@interface WLoginViewController ()

@property(nonatomic,strong)GeneralizedProcessor *mygen;
@end

@implementation WLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}
-(void)clinkreg{
}

-(void)MailNext
{
    [_nameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [AppDelegate getNav].navigationBar.hidden = NO;
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
}

#pragma mark 第三方登陆


- (void)loginByWay:(int)way name:(NSString *)mName
{
    

    NSString *platformName = mName;
    
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        
        if (response.responseCode == UMSResponseCodeSuccess){
            
            UMSocialAccountEntity * snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
            
            [AccountRequest loginweiboAndqq:^(NSDictionary *dic)
             {
                 [AppDelegate getNav].navigationBar.hidden = NO;
                 [AppDelegate instance].MainBar.NaveBar.hidden = NO;
                 
                 [[AppDelegate instance] createMain];

             } with:snsAccount withWay:way];
        }
    });
    
}

-(void)UPWBQQ:(UIButton*)sender
{

    [AppDelegate getNav].navigationBar.hidden = YES;
    [AppDelegate instance].MainBar.NaveBar.hidden = YES;
    
    switch (sender.tag)
    {
        case 888:
            [self loginByWay:2 name:@"sina"];
            break;
            
        case 889:
            [self loginByWay:1 name:UMShareToQzone];
            break;
            
        default:
            break;
    }
    
    
}


#pragma mark 用户注册
-(void)personRegister
{
    WRegisteredViewController *reg = [[WRegisteredViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
    //    [self presentViewController:reg animated:YES completion:nil];
}

#pragma mark 忘记密码
-(void)forgetpassword{
    
    WRetrievePasswordViewController *RP=[[WRetrievePasswordViewController alloc]init];
    
    [self.navigationController pushViewController:RP animated:YES];
    //    [self presentViewController:RP animated:YES completion:nil];
}


#pragma mark 登陆
- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _nameField.delegate = self;
    _nameField.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    _nameField.layer.borderWidth = 0.6;
    _nameField.layer.cornerRadius = 5;
    _nameField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _nameField.layer.masksToBounds = YES;
    _nameField.keyboardType = UIKeyboardTypeNumberPad;
                
    _passwordField.delegate = self;
    _passwordField.tag = 1000;
    _passwordField.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    _passwordField.layer.borderWidth = 0.6;
    _passwordField.layer.cornerRadius = 5;
    _passwordField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _passwordField.layer.masksToBounds = YES;
    _passwordField.secureTextEntry = YES;


    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    _loginBtn.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#ca2a2a"];
    
    [_registerBtn addTarget:self action:@selector(personRegister) forControlEvents:UIControlEventTouchUpInside];
    _registerBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    [_registerBtn setTintColor:[GeneralizedProcessor hexStringToColor:@"#ca2a2a"]];

    [_forgetBtn addTarget:self action:@selector(forgetpassword) forControlEvents:UIControlEventTouchUpInside];
    [_forgetBtn setTintColor:[GeneralizedProcessor hexStringToColor:@"#ca2a2a"]];
    _forgetBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    
    
    
    [_sinaBtn addTarget:self action:@selector(UPWBQQ:) forControlEvents:UIControlEventTouchUpInside];
    _sinaBtn.tag=888;

    [_qqBtn addTarget:self action:@selector(UPWBQQ:) forControlEvents:UIControlEventTouchUpInside];
    _qqBtn.tag = 889;

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1000&&[string isEqualToString:@""]) {
        return YES;
    }
    
    if (textField.tag == 1000&& textField.text.length > 15) {
        return NO;
    }
    
    return  YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    
}



#pragma mark---UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    
    [self Changepassword];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIButton*nextBton=(UIButton*)[self.view viewWithTag:8888];
    [nextBton setHidden:YES];
    
    if (_nameField.text.length>0)
    {
        [nextBton setHidden:NO];
    }
    [_nameField resignFirstResponder];
    
    
    if (_passwordField.text.length>0)
    {
        [nextBton setHidden:NO];
    }
    [_passwordField resignFirstResponder];
}
-(void)Changepassword
{
    [_passwordField resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setauial:(NSString*)str
{
    
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [al show];
    
}

- (IBAction)loginClick:(id)sender
{
    BOOL ye=  [GeneralizedProcessor isMobileNumber:_nameField.text ];
    
    if ([ _nameField.text isEqualToString:@""]) {
        [self setauial:@"请输入手机号"];
    }else
    {
        if (ye==true) {
            
            
            if ([[NSString stringWithFormat:@"%@",  _passwordField.text ] isEqualToString:@""]) {
                
                [self setauial:@"请输入密码"];
            }else
            {
                MBProgressHUD * mbHud = [[MBProgressHUD alloc]initWithView:self.view];
                [self.view addSubview:mbHud];
                mbHud.dimBackground = YES;
                [mbHud showAnimated:YES whileExecutingBlock:^
                 {
                     
                     [AccountRequest accountLogin:^(NSDictionary *dic)
                      {
                          
                          [[AccountModel instance] saveFromData:dic];
                          
                          CATransition * caSwitch = [CATransition animation];
                          caSwitch.delegate=self;
                          caSwitch.duration=2;
                          caSwitch.timingFunction=UIViewAnimationCurveEaseInOut;
                          caSwitch.type=@"rippleEffect";
                          //超级动画效果 哈哈哈
                          [[self.navigationController.view layer]addAnimation:caSwitch forKey:@"switch"];
                          
                          [[AppDelegate instance] createMain];
                          
                      } name:_nameField.text pass:_passwordField.text fail:^(int errCode, NSError *err) {
                          if(errCode == 5006)
                          {
                              [self setauial:@"手机号或密码错误"];
                              
                          }
                          
                      }];
                 } completionBlock:^{
                     [mbHud removeFromSuperview];
                 }];
            }
        }
        if (ye==false)
        {
            [self setauial:@"请输入正确手机号"];
        }
    }

}


@end
