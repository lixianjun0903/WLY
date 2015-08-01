//
//  WLY_RegisteredViewController.m
//  WLY—-ONE
//
//  Created by weiluyan on 14-9-22.
//  Copyright (c) 2014年 weiluyan. All rights reserved.
//

#import "WRegisteredViewController.h"
#import "GeneralizedProcessor.h"
#import "AFAppRequest.h"
#import "AppDelegate.h"
#import "AccountRequest.h"
#import "MBProgressHUD+Show.h"
#define fontFame    14
#define Placeholder  13
#define TeHight  45
#define JianJuHight  10

#define TEXTFIELDWIDTH 220


@interface WRegisteredViewController ()
@property(nonatomic,strong)UIButton*CodeButton2;

@end

@implementation WRegisteredViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)fanhuiBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}
-(void)BTNFROM
{
    
    [_iphoneTextFiled resignFirstResponder];
    [_NetPassswordTextFiled resignFirstResponder];
    [_VerificationCodeTextFiled resignFirstResponder];
    
    
    BOOL ye=  [GeneralizedProcessor isMobileNumber:_iphoneTextFiled.text ];
    BOOL mima=[GeneralizedProcessor CheckInput:_NetPassswordTextFiled.text];
    
    if( ye )
    {
        if ([_NetPassswordTextFiled.text isEqualToString:@""])
        {
            [self setauial:@"请输入密码"];
        }
        else
        {
            if (mima)
            {
                [AccountRequest getMoblieCheckCode:^(int error_code) {
                    
                    if (error_code ==5009) {
                        [self setauial:@"获取激活码失败"];
                    }if (error_code==5008) {
                        [self setauial:@"获取激活码间隔时间太短"];
                    }if (error_code==5004) {
                        [self setauial:@"手机号已注册"];
                    }
                    if (error_code==00) {
                        [self daojishi];
                    }
                    
                } :_iphoneTextFiled.text :1:1];
                
            }else
            {
                [self setauial:@"密码为6-16位字母，数字，特殊字符"];
            }
        }
    }
    else
    {
        if ([_iphoneTextFiled.text isEqualToString:@""]) {
            [self setauial:@"请输入手机号"];
        }else
        {
            [self setauial:@"请输入正确的手机号"];
        }
    }
}
-(void)daojishi
{
    
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0)
        { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_CodeButton2 setTitle:@"获取激活码(60)" forState:UIControlStateNormal];
                _CodeButton2.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                if ([strTime  integerValue]==00) {
                    NSString *stde=@"60";
                    
                    [_CodeButton2 setTitle:[NSString stringWithFormat:@"获取激活码(%@)",stde] forState:UIControlStateNormal];
                    
                    
                }else
                {
                    
                    [_CodeButton2 setTitle:[NSString stringWithFormat:@"获取激活码(%@)",strTime] forState:UIControlStateNormal];
                    
                    _CodeButton2.userInteractionEnabled = NO;
                    
                }
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

-(void)ZhuceWanCheng
{
    
    if ([ _iphoneTextFiled.text isEqualToString:@""])
    {
        [self setauial:@"请输入手机号"];
        return;
    }
    if ([_NetPassswordTextFiled.text isEqual:@""])
    {
        [self setauial:@"请输入密码"];
        return;
    }
    
    
    BOOL mima=[GeneralizedProcessor CheckInput:_NetPassswordTextFiled.text];
    
    if (mima==true) {
        [AccountRequest accountRegister:^(NSDictionary *accessToken) {
            
            [[AccountModel instance] saveFromData:accessToken];
            [MBProgressHUD creatembHub:@"注册成功"];
            
            CATransition * caSwitch = [CATransition animation];
             caSwitch.delegate=self;
             caSwitch.duration=2;
             caSwitch.timingFunction=UIViewAnimationCurveEaseInOut;
             caSwitch.type=@"rippleEffect";
             //超级动画效果 哈哈哈
             [[self.navigationController.view layer]addAnimation:caSwitch forKey:@"switch"];
             [[AppDelegate instance] createMain];

            [_iphoneTextFiled resignFirstResponder];
            [_NetPassswordTextFiled resignFirstResponder];
            [_VerificationCodeTextFiled resignFirstResponder];
            
        } :_iphoneTextFiled.text :_NetPassswordTextFiled.text :_VerificationCodeTextFiled.text fail:^(int errCode, NSError *err) {
            if (errCode ==5004) {
                [self setauial:@"手机号已注册"];
                
            }if (errCode ==5002) {
                [self setauial:@"请输入正确的手机号"];
                
            }if (errCode ==5001) {
                [self setauial:@"手机号或密码不能为空"];
                
            }if (errCode ==5008) {
                [self setauial:@"获取激活码间隔时间太短"];
                
            }if (errCode ==5010) {
                [self setauial:@"激活码错误"];
                
            }if (errCode ==5009) {
                [self setauial:@"获取激活码失败"];
                
            }if (errCode ==5005) {
                [self setauial:@"注册失败"];
                
            }
        }];
        
    }
    else
    {
        [self setauial:@"密码为6-16位字母，数字，特殊字符"];
        return;
    }
    
    
}
-(void)setauial:(NSString*)str
{
    
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [al show];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * loginLab = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH - TEXTFIELDWIDTH)/2, 75, 80, 20)];
    
    loginLab.text = @"注册";
    loginLab.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:loginLab];
    
    _iphoneTextFiled=[[UITextField alloc]initWithFrame:CGRectMake((WIDTH - TEXTFIELDWIDTH)/2,100, TEXTFIELDWIDTH, TeHight)];
    _iphoneTextFiled.delegate=self;
    [_iphoneTextFiled setReturnKeyType: UIReturnKeySend];
    [_iphoneTextFiled setPlaceholder:@"请填写中国大陆手机号"];
    _iphoneTextFiled.font=[UIFont systemFontOfSize:14];
    _iphoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [_iphoneTextFiled setBorderStyle:  UITextBorderStyleRoundedRect];
    [self.view addSubview:_iphoneTextFiled];
    
    
    _VerificationCodeTextFiled=[[UITextField alloc]initWithFrame:CGRectMake((WIDTH - TEXTFIELDWIDTH)/2, 100+(TeHight+JianJuHight) * 2,120, TeHight)];
    _VerificationCodeTextFiled.delegate=self;
    [_VerificationCodeTextFiled setReturnKeyType: UIReturnKeySend];
    _VerificationCodeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    
    [_VerificationCodeTextFiled setBorderStyle:  UITextBorderStyleRoundedRect];
    [self.view addSubview:_VerificationCodeTextFiled];
    
    
    
    
    _CodeButton2=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [_CodeButton2 addTarget:self action:@selector(BTNFROM) forControlEvents:UIControlEventTouchUpInside];
    _CodeButton2.frame=CGRectMake(130+(WIDTH - TEXTFIELDWIDTH)/2,100+(TeHight+JianJuHight) * 2, TEXTFIELDWIDTH - 130 , TeHight);
    _CodeButton2.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#f7f7f7"];
    [_CodeButton2 setTintColor:[GeneralizedProcessor hexStringToColor:colorRead]];
    _CodeButton2.layer.masksToBounds = YES;
    _CodeButton2.layer.cornerRadius = 4.0;
    _CodeButton2.layer.borderWidth = 0.8;
    _CodeButton2.layer.borderColor = [[GeneralizedProcessor hexStringToColor:@"#d0d0d0"] CGColor];
    [_CodeButton2 setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:_CodeButton2];
    
    _NetPassswordTextFiled=[[UITextField alloc]initWithFrame:CGRectMake((WIDTH - TEXTFIELDWIDTH)/2, 100+TeHight+JianJuHight, TEXTFIELDWIDTH, 43)];
    _NetPassswordTextFiled.delegate=self;
    [_NetPassswordTextFiled setReturnKeyType: UIReturnKeySend];
    [_NetPassswordTextFiled setPlaceholder:@"请输入新密码6-16位"];
    _NetPassswordTextFiled.font=[UIFont systemFontOfSize:14];
    [_NetPassswordTextFiled setSecureTextEntry:YES];
    
    [_NetPassswordTextFiled setBorderStyle:  UITextBorderStyleRoundedRect];
    [self.view addSubview:_NetPassswordTextFiled];
    
    
    UIButton*nextButton=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [nextButton addTarget:self action:@selector(ZhuceWanCheng) forControlEvents:UIControlEventTouchUpInside];
    nextButton.frame=CGRectMake((WIDTH - TEXTFIELDWIDTH)/2,185+TeHight * 2+JianJuHight * 2, TEXTFIELDWIDTH, 40);
    nextButton.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#ca2a2a"];
    [nextButton setTintColor:[UIColor whiteColor]];
    nextButton.layer.masksToBounds = YES;
    nextButton.layer.cornerRadius = 4.0;
    nextButton.layer.borderWidth = 1.0;
    nextButton.layer.borderColor = [[UIColor clearColor] CGColor];
    [nextButton setTitle:@"完成" forState:UIControlStateNormal];
    nextButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:nextButton];
    
    
    
    UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake((WIDTH - TEXTFIELDWIDTH)/2 + 20,  90+(TeHight+JianJuHight) * 3, 150, 40)];
    la1.text=@"我已经阅读";
    la1.font=[UIFont systemFontOfSize:14];
    la1.backgroundColor=[UIColor clearColor];
    [self.view addSubview:la1];
    
    UILabel *la2=[[UILabel alloc]initWithFrame:CGRectMake((WIDTH - TEXTFIELDWIDTH)/2+88, 90+(TeHight+JianJuHight) * 3, 150, 40)];
    la2.text=@"《xxxx用户协议》";
    la2.textColor=[GeneralizedProcessor hexStringToColor:@"#ca2a2a"];
    la2.font=[UIFont systemFontOfSize:14];
    la2.backgroundColor=[UIColor clearColor];
    [self.view addSubview:la2];
    
}

-(void)btnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark---UITextFieldDelegate
//
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//
//    
//    if ([string isEqualToString:@""]) {
//        return YES;
//    }
//    printf("%s",[string UTF8String]);
//
//    if(textField.text.length<16)
//    {
//        return YES;
//    }
//    return NO;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_iphoneTextFiled resignFirstResponder];
    [_NetPassswordTextFiled resignFirstResponder];
    
    
    [self Changepassword];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIButton*nextBton=(UIButton*)[self.view viewWithTag:8888];
    [nextBton setHidden:YES];
    if (_iphoneTextFiled.text.length>0)
    {
        [nextBton setHidden:NO];
    }
    [_iphoneTextFiled resignFirstResponder];
    [_VerificationCodeTextFiled resignFirstResponder];
    
    if (_NetPassswordTextFiled.text.length>0)
    {
        [nextBton setHidden:NO];
    }
    [_NetPassswordTextFiled resignFirstResponder];
    
}
-(void)Changepassword
{
    [_NetPassswordTextFiled resignFirstResponder];
}

-(void)MailNext
{
    [_iphoneTextFiled resignFirstResponder];
    [_NetPassswordTextFiled resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [GeneralizedProcessor  isMobileNumber:_iphoneTextFiled.text   ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
