//
//  WLY_RetrievePasswordViewController.m
//  WLY—-ONE
//
//  Created by weiluyan on 14-9-18.
//  Copyright (c) 2014年 weiluyan. All rights reserved.
//

#import "WRetrievePasswordViewController.h"
#import "GeneralizedProcessor.h"
#import "AccountRequest.h"
#import "AppDelegate.h"
#import "MBProgressHUD+Show.h"


#define Hight    40
#define TeHight  43
#define JianJuHight  10

@interface WRetrievePasswordViewController ()
@property(nonatomic,strong)UIButton*CodeButton2;

@end

@implementation WRetrievePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)backBT{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setNavarBar
{
    
    //    [self.navigationController.navigationBar setBarTintColor:[GeneralizedProcessor hexStringToColor:@"#ca2a2a"]];
    
    UIView *naview=[[UIView alloc]initWithFrame:CGRectMake(0,0, 320, 64)];
    naview.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#ca2a2a"];
    [self.view addSubview:naview];
    
    
    UIButton*leftBton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBton setFrame:CGRectMake(15, 20, 40, 40)];
    [leftBton setImage:[UIImage imageNamed:@"closed_W"] forState: UIControlStateNormal];
    [leftBton addTarget:self action:@selector(backBT) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBton];
    
    
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 100, 30)];
    t.font = [UIFont systemFontOfSize:18];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSLineBreakByCharWrapping;
    t.text = @"忘记密码";
    [naview addSubview:t];
}
-(void)viewWillAppear:(BOOL)animated{
    
//    [self setNavarBar];
}
-(void)httprequestgetMoblieCheckCode
{
    
    [AccountRequest getMoblieCheckCode:^(int error_code)
     {
         NSLog(@"验证码%d",error_code);
         
     } :_iphoneTextFiled.text :2:0];
    
    ////倒计时
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
//                NSLog(@"____%@",strTime);
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
-(void)ButtonS:(UIButton*)sender
{
    NSLog(@"获取验证");
    
    
    BOOL mima=[GeneralizedProcessor  CheckInput:_NetPassswordTextFiled.text];
    BOOL iphone=  [GeneralizedProcessor isMobileNumber:_iphoneTextFiled.text ];
    
    
    
    if ([_iphoneTextFiled.text  isEqualToString:@""])
    {
        [self setauial:@"请输入手机号"];
        
    }else
    {
        
        if (iphone)
        {
            
            if ([_NetPassswordTextFiled.text  isEqualToString:@""]&&[_AgainPassswordTextFiled.text isEqualToString:@""])
            {
                [self setauial:@"请输入密码"];
            }
            else
            {
                if (mima)
                {
                    
                    if ([_NetPassswordTextFiled.text isEqualToString:_AgainPassswordTextFiled.text])
                    {
                        
                        [   self httprequestgetMoblieCheckCode ];
                        
                    }else
                    {
                        [ self setauial:@"两次输入密码不一样"];
                    }
                    
                    
                }else
                {
                    [self setauial:@"密码为6-16位字母，数字，特殊字符"];
                    
                }
                
                
            }
            
            
        }else
        {
            
            [self setauial:@"输入正确的手机号有误"];
            
        }
        
    }
    
}

-(void)setauial:(NSString*)str
{
    
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [al show];
    
}

-(void)ZhuCeRequest
{
    
    [AccountRequest accountFoundPass:^(NSDictionary *dic)
    {
        if ( [[dic objectForKey:@"error_code"] intValue]==0)
        {
            
            [[AccountModel instance] savePersonalInfoFromDic:[dic objectForKey:@"data"]];
            
            
        }

        
    } :_iphoneTextFiled.text :_NetPassswordTextFiled.text :_VerificationCodeTextFiled.text fail:^(int errCode, NSError *err) {
        
    }];
    
    
    
}
-(void)wancheng
{
    BOOL mima=[GeneralizedProcessor  CheckInput:_NetPassswordTextFiled.text];
    BOOL iphone=  [GeneralizedProcessor isMobileNumber:_iphoneTextFiled.text ];
    
    if([_NetPassswordTextFiled.text isEqualToString:@""])
    {
        [self setauial:@"请输入密码"];
        return;
    }
    
    if(!mima)
    {
        [self setauial:@"密码格式不正确或长度不对，请重新输入"];
        return;
    }
    
    if([_AgainPassswordTextFiled.text isEqualToString:@""])
    {
        [self setauial:@"请再次输入密码"];
        return;
    }
    
    if(![_NetPassswordTextFiled.text isEqualToString:_AgainPassswordTextFiled.text])
    {
        [self setauial:@"两次输入密码不一致，请重新输入"];
        return;
    }
    
    if([_iphoneTextFiled.text isEqualToString:@""])
    {
        [self setauial:@"请输入手机号"];
        return;
    }
    
    if(!iphone)
    {
        [self setauial:@"手机号格式不正确"];
        return;
    }
    
    if([_VerificationCodeTextFiled.text isEqualToString:@""])
    {
        [self setauial:@"请输入验证码"];
        return;
    }
    [AccountRequest accountFoundPass:^(NSDictionary *dic) {
        [MBProgressHUD creatembHub:@"修改成功"];
        [[AppDelegate getNav] popViewControllerAnimated:YES];

        
    } :_iphoneTextFiled.text :_NetPassswordTextFiled.text :_VerificationCodeTextFiled.text fail:^(int errCode, NSError *err) {
        if(errCode == 5010)
        {
            [self setauial:@"激活码不匹配"];
        }
        
    }];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#eeeae7"];
    
    _iphoneTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(10,80+TeHight+JianJuHight+TeHight+JianJuHight, 150, TeHight)];
    _iphoneTextFiled.delegate=self;
    [_iphoneTextFiled setReturnKeyType: UIReturnKeyNext];
    [_iphoneTextFiled setPlaceholder:@"  请输入注册手机号"];
    _iphoneTextFiled.font=[UIFont systemFontOfSize:14];
    [_iphoneTextFiled setBorderStyle:  UITextBorderStyleRoundedRect];
    _iphoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_iphoneTextFiled];
    
    
    _CodeButton2=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [_CodeButton2 addTarget:self action:@selector(ButtonS:) forControlEvents:UIControlEventTouchUpInside];
    _CodeButton2.frame=CGRectMake(170, 80+TeHight+JianJuHight+TeHight+JianJuHight,140, TeHight);
    _CodeButton2.tag=888;
    _CodeButton2.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#f7f7f7"];
    [_CodeButton2 setTintColor:[GeneralizedProcessor hexStringToColor:colorRead]];
    _CodeButton2.layer.masksToBounds = YES;
    _CodeButton2.layer.cornerRadius = 4.0;
    _CodeButton2.layer.borderWidth = 1.0;
    _CodeButton2.layer.borderColor = [[GeneralizedProcessor hexStringToColor:@"#d0d0d0"] CGColor];
    [_CodeButton2 setTitle:@"获取激活码(60)" forState:UIControlStateNormal];
    _CodeButton2.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:12];
    [self.view addSubview:_CodeButton2];
    
    _VerificationCodeTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, 80+TeHight+JianJuHight+TeHight+JianJuHight+TeHight+JianJuHight, 300, TeHight)];
    _VerificationCodeTextFiled.delegate=self;
    [_VerificationCodeTextFiled setReturnKeyType: UIReturnKeyNext];
    [_VerificationCodeTextFiled setPlaceholder:@"  请输入验证密码"];
    _VerificationCodeTextFiled.font=[UIFont systemFontOfSize:14];
    [_VerificationCodeTextFiled setBorderStyle:  UITextBorderStyleRoundedRect];
    _VerificationCodeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_VerificationCodeTextFiled];
    
    
    _NetPassswordTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(10,80, 300, TeHight)];
    _NetPassswordTextFiled.delegate=self;
    [_NetPassswordTextFiled setReturnKeyType: UIReturnKeyNext];
    [_NetPassswordTextFiled setPlaceholder:@"  请输入新密码6-16位"];
    _NetPassswordTextFiled.font=[UIFont systemFontOfSize:14];
    [_NetPassswordTextFiled setBorderStyle:  UITextBorderStyleRoundedRect];
    [_NetPassswordTextFiled setSecureTextEntry:YES];
    _NetPassswordTextFiled.tag=888;
    [self.view addSubview:_NetPassswordTextFiled];
    
    _AgainPassswordTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(10,80+TeHight+JianJuHight, 300, TeHight)];
    _AgainPassswordTextFiled.delegate=self;
    [_AgainPassswordTextFiled setReturnKeyType: UIReturnKeySend];
    [_AgainPassswordTextFiled setSecureTextEntry:YES];
    _AgainPassswordTextFiled.tag=889;
    [_AgainPassswordTextFiled setPlaceholder:@"  请再次输入新密码"];
    _AgainPassswordTextFiled.font=[UIFont systemFontOfSize:14];
    
    [_AgainPassswordTextFiled setBorderStyle:  UITextBorderStyleRoundedRect];
    [self.view addSubview:_AgainPassswordTextFiled];
    
    
    
    
    UIButton*nextButton=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [nextButton addTarget:self action:@selector(wancheng) forControlEvents:UIControlEventTouchUpInside];
    nextButton.frame=CGRectMake(10, 80+TeHight+JianJuHight+TeHight+JianJuHight+TeHight+JianJuHight+TeHight+JianJuHight, 300, 41);
    [nextButton setTintColor:[UIColor whiteColor]];
    nextButton.layer.masksToBounds = YES;
    nextButton.layer.cornerRadius = 4.0;
    nextButton.layer.borderWidth = 1.0;
    nextButton.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#ca2a2a"];
    nextButton.layer.borderColor = [[UIColor clearColor] CGColor];
    [nextButton setTitle:@"完成" forState:UIControlStateNormal];
    nextButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:22];
    [self.view addSubview:nextButton];
    
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_iphoneTextFiled resignFirstResponder];
    [_VerificationCodeTextFiled resignFirstResponder];
    [_AgainPassswordTextFiled resignFirstResponder];
    [_NetPassswordTextFiled resignFirstResponder];
    
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIButton*nextBton=(UIButton*)[self.view viewWithTag:8888];
    [nextBton setHidden:YES];
    
    [_iphoneTextFiled resignFirstResponder];
    [_VerificationCodeTextFiled resignFirstResponder];
    [_AgainPassswordTextFiled resignFirstResponder];
    [_NetPassswordTextFiled resignFirstResponder];
    
    
    //    if (_passwordTextFiled.text.length>0)
    //    {
    //        [nextBton setHidden:NO];
    //    }
    [_iphoneTextFiled resignFirstResponder];
    [_VerificationCodeTextFiled resignFirstResponder];
    [_AgainPassswordTextFiled resignFirstResponder];
    [_NetPassswordTextFiled resignFirstResponder];
}
#pragma mark---texfind delete
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    NSLog(@"aaaa");
    
}          // became first responder
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"dadadad");
    
    //BOOL mima=[GeneralizedProcessor CheckInput:_NetPassswordTextFiled.text];
    
    switch (textField.tag) {
        case 888:
        {
            
            
            
            
        }
            break;
        case 889:
        {
            
            
            
        }
            break;
        default:
            break;
    }
    
    
    
    
    
    
    
}            // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

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
