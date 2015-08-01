//
//  NewWRViewController.m
//  WeiLuYan
//
//  Created by weiluyan on 15/3/12.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "NewWRViewController.h"
#import "GeneralizedProcessor.h"
#import "AFAppRequest.h"
#import "AppDelegate.h"
#import "AccountRequest.h"
#import "MBProgressHUD+Show.h"

#import "AgreementPushViewController.h"

#define Placeholder  15
#define TeHight  45
#define JianJuHight  10

#define TEXTFIELDWIDTH 220
@interface NewWRViewController ()
@end
@implementation NewWRViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([AppDelegate getNav].viewControllers.count == 1){
        [AppDelegate instance].MainBar.BarBtn.hidden = YES;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#f9f9f9"];
    _iPhoneTextField.delegate = self;
    _iPhoneTextField.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    _iPhoneTextField.layer.borderWidth = 0.6;
    _iPhoneTextField.layer.cornerRadius = 5;
    _iPhoneTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _iPhoneTextField.layer.masksToBounds = YES;
    _iPhoneTextField.keyboardType = UIKeyboardTypeDefault;
    _iPhoneTextField.backgroundColor=[UIColor clearColor];
    _iPhoneTextField.layer.borderColor=[[UIColor clearColor]CGColor];
    _iPhoneTextField.textColor=[GeneralizedProcessor hexStringToColor:@"#929292" ];

    _codeBtn.backgroundColor=[UIColor whiteColor];
    [_codeBtn setTintColor:[GeneralizedProcessor hexStringToColor:@"#ea2a2a"]];
    _codeBtn.layer.masksToBounds = YES;
    _codeBtn.layer.cornerRadius = 4.0;
    _codeBtn.layer.borderWidth = 0.8;
    _codeBtn.layer.borderColor = [[GeneralizedProcessor hexStringToColor:@"#ea2a2a"] CGColor];
    [_codeBtn setTitle:@"获取验证码(60)" forState:UIControlStateNormal];
//    _codeBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [_codeBtn addTarget:self action:@selector(BTNFROM) forControlEvents:UIControlEventTouchUpInside];
    _codeBtn.layer.borderColor = [[GeneralizedProcessor hexStringToColor:@"#ea2a2a"] CGColor];
    _codeBtn.backgroundColor=[UIColor whiteColor];
    [_codeBtn setTintColor:[GeneralizedProcessor hexStringToColor:@"#ea2a2a"]];

    _oneImage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
   _threeImage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    _fImage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    _fourImage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
       _twoImage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    
    _wrBtn.layer.cornerRadius = 5;
    _wrBtn.layer.masksToBounds = YES;
    _wrBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    _wrBtn.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#ea2a2a"];

    _passwordTextField.delegate = self;
    _passwordTextField.tag = 1000;
    _passwordTextField.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    _passwordTextField.layer.borderWidth = 0.6;
    _passwordTextField.layer.cornerRadius = 5;
    _passwordTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.layer.borderColor=[[UIColor clearColor]CGColor];

    _passwordTwoTextField.delegate = self;
    _passwordTwoTextField.tag = 1000;
    _passwordTwoTextField.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    _passwordTwoTextField.layer.borderWidth = 0.6;
    _passwordTwoTextField.layer.cornerRadius = 5;
    _passwordTwoTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _passwordTwoTextField.layer.masksToBounds = YES;
    _passwordTwoTextField.secureTextEntry = YES;
    _passwordTwoTextField.layer.borderColor=[[UIColor clearColor]CGColor];

    _wrBtn.layer.cornerRadius = 5;
    _wrBtn.layer.masksToBounds = YES;
    _wrBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    _wrBtn.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#ea2a2a"];
    [_wrBtn addTarget:self action:@selector(ZhuceWanCheng) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _nikeBtn.tag=1001;
    [_nikeBtn setImage:[UIImage imageNamed:@"success_selected_btn"] forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}
-(void)BTNFROM
{
    
    [_iPhoneTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    BOOL ye=  [GeneralizedProcessor isMobileNumber:_iPhoneTextField.text ];//判断手机号正确
    BOOL mima=[GeneralizedProcessor CheckInput:_passwordTextField.text];//判断密码是否合法
    
    if( ye )
    {
        if ([_passwordTextField.text isEqualToString:@""])
        {
           
                [self setauial:@"请输入密码"];

        }
        else
        {
           
            if ([_passwordTextField.text  isEqualToString:_passwordTwoTextField.text])
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
                        
                    } :_iPhoneTextField.text :1:1];
                    
                }else
                {
                    [self setauial:@"密码为6-16位字母，数字，特殊字符"];
                }
  
            
            
            }else
            {
                [ self setauial:@"两次输入的密码不一致" ];
            }
            
            
        }
    }
    else
    {
        if ([_iPhoneTextField.text isEqualToString:@""]) {
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
    
}-(void)setauial:(NSString*)str
{
    
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [al show];
    
}
-(void)ZhuceWanCheng
{
    
    if ([ _iPhoneTextField.text isEqualToString:@""])
    {
        [self setauial:@"请输入手机号"];
        return;
    }
    if ([_passwordTextField.text isEqual:@""])
    {
        [self setauial:@"请输入密码"];
        return;
    }
    if(_nikeBtn.tag != 1001){
        [self setauial:@"请阅读用户协议"];
        return;
    }
    BOOL mima=[GeneralizedProcessor CheckInput:_passwordTextField.text];
    
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
            
            [_iPhoneTextField resignFirstResponder];
            [_passwordTextField resignFirstResponder];
            [_codeTextField resignFirstResponder];
            
        } :_iPhoneTextField.text :_passwordTextField.text :_codeTextField.text fail:^(int errCode, NSError *err) {
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
#pragma mark----dele
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_iPhoneTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    
    [self Changepassword];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIButton*nextBton=(UIButton*)[self.view viewWithTag:8888];
    [nextBton setHidden:YES];
    if (_iPhoneTextField.text.length>0)
    {
        [nextBton setHidden:NO];
    }
    [_iPhoneTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    
    if (_passwordTextField.text.length>0)
    {
        [nextBton setHidden:NO];
    }
    [_passwordTextField resignFirstResponder];
    
}
-(void)Changepassword
{
    [_passwordTextField resignFirstResponder];
}

-(void)MailNext
{
    [_iPhoneTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [GeneralizedProcessor  isMobileNumber:_iPhoneTextField.text   ];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)NSErrorerrornilxieyiBtn:(id)sender {
    NSLog(@"dadad");
   
    
    AgreementPushViewController  *AP=[[AgreementPushViewController alloc]init];
    
    [self.navigationController pushViewController:AP animated:YES];
    
    
}
- (IBAction)nikeBtn:(UIButton*)tag
{
    switch ( _nikeBtn.tag) {
        case 1001:
        {
         _nikeBtn.tag=1002;
            [_nikeBtn setImage:[UIImage imageNamed:@"success_default_btn"] forState:UIControlStateNormal];

        }
            break;
            
            case 1002:
        {
            _nikeBtn.tag=1001;
            [_nikeBtn setImage:[UIImage imageNamed:@"success_selected_btn"] forState:UIControlStateNormal];

        }
            break;
        default:
            break;
    }
    
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
