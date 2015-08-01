//
//  ForgotpasswordViewController.m
//  WeiLuYan
//
//  Created by WL-DZ-PGDN-007 on 15-3-17.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ForgotpasswordViewController.h"
#import "GeneralizedProcessor.h"
#import "AFAppRequest.h"
#import "AppDelegate.h"
#import "AccountRequest.h"
#import "MBProgressHUD.h"
@interface ForgotpasswordViewController ()

@end

@implementation ForgotpasswordViewController
- (IBAction)codeBtn:(id)sender
{
    [_iphoneTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    
    
    BOOL ye=  [GeneralizedProcessor isMobileNumber:_iphoneTF.text ];
    BOOL mima=[GeneralizedProcessor CheckInput:_passwordTF.text];
    
    if( ye )
    {
        if ([_passwordTF.text isEqualToString:@""])
        {
            [self setauial:@"请输入密码"];
        
        
        }
        else
        {
          
            if ([_passwordTF.text isEqualToString:_passwordTowTF.text]) {
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
                        
                    } :_iphoneTF.text :1:1];
                    
                }else
                {
                    [self setauial:@"密码为6-16位字母，数字，特殊字符"];
                }

                
            }else
            {
                [self setauial:@"两次密码不一致"];

            }
            
            
        }
    }
    else
    {
        if ([_iphoneTF.text isEqualToString:@""]) {
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
                [_codeBtn setTitle:@"获取激活码(60)" forState:UIControlStateNormal];
                _codeBtn.userInteractionEnabled = YES;
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
                    
                    [_codeBtn setTitle:[NSString stringWithFormat:@"获取激活码(%@)",stde] forState:UIControlStateNormal];
                    
                    
                }else
                {
                    
                    [_codeBtn setTitle:[NSString stringWithFormat:@"获取激活码(%@)",strTime] forState:UIControlStateNormal];
                    
                    _codeBtn.userInteractionEnabled = NO;
                    
                }
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}
-(void)setauial:(NSString*)str
{
    
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [al show];
    
}
- (IBAction)fgBtn:(id)sender {

    if ([ _iphoneTF.text isEqualToString:@""])
    {
        [self setauial:@"请输入手机号"];
        return;
    }
    if ([_passwordTF.text isEqual:@""])
    {
        [self setauial:@"请输入密码"];
        return;
    }
    
    
    BOOL mima=[GeneralizedProcessor CheckInput:_passwordTF.text];
    
    if (mima==true) {
        [AccountRequest accountRegister:^(NSDictionary *accessToken) {
            
            [[AccountModel instance] saveFromData:accessToken];
//            [MBProgressHUD creatembHub:@"注册成功"];
            
            CATransition * caSwitch = [CATransition animation];
            caSwitch.delegate=self;
            caSwitch.duration=2;
            caSwitch.timingFunction=UIViewAnimationCurveEaseInOut;
            caSwitch.type=@"rippleEffect";
            //超级动画效果 哈哈哈
            [[self.navigationController.view layer]addAnimation:caSwitch forKey:@"switch"];
            [[AppDelegate instance] createMain];
            
            [_iphoneTF resignFirstResponder];
            [_passwordTF resignFirstResponder];
            [_codeTF resignFirstResponder];
            
        } :_iphoneTF.text :_passwordTF.text :_codeTF.text fail:^(int errCode, NSError *err) {
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



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#f9f9f9"];
    _codeBtn.layer.borderWidth = 0.6;
    _codeBtn.layer.cornerRadius = 5;
    _codeBtn.layer.borderColor=[[GeneralizedProcessor hexStringToColor:@"#ea2a2a"] CGColor];

    _fgBtn.layer.borderWidth = 0.6;
    _fgBtn.layer.cornerRadius = 5;
    _fgBtn.layer.masksToBounds = YES;
    _fgBtn.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#ea2a2a"];
    _fgBtn.layer.borderColor=[[UIColor clearColor ] CGColor];
    
    _twoiamge.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    _threImage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    _fourImage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    _oneImage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    _fiveImage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    
    
    _passwordTF.secureTextEntry = YES;
    _passwordTowTF.secureTextEntry = YES;

    
    
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_iphoneTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    
    
    [self Changepassword];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIButton*nextBton=(UIButton*)[self.view viewWithTag:8888];
    [nextBton setHidden:YES];
    if (_iphoneTF.text.length>0)
    {
        [nextBton setHidden:NO];
    }
    [_iphoneTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    
    if (_passwordTF.text.length>0)
    {
        [nextBton setHidden:NO];
    }
    [_passwordTF resignFirstResponder];
    
}
-(void)Changepassword
{
    [_passwordTF resignFirstResponder];
}

-(void)MailNext
{
    [_iphoneTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [GeneralizedProcessor  isMobileNumber:_iphoneTF.text   ];
    
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
