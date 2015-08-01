//
//  NewWRPasswordViewController.m
//  WeiLuYan
//
//  Created by weiluyan on 15/3/13.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "NewWRPasswordViewController.h"
#import "GeneralizedProcessor.h"
#import "AccountRequest.h"
#import "UserInfoRequest.h"
#define Placeholder  15
#define TeHight  45
#define JianJuHight  10

@interface NewWRPasswordViewController ()

@end

@implementation NewWRPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#f9f9f9"];
    _oneimage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    _twoimage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    _thrimage.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    _fouriamge.backgroundColor=[GeneralizedProcessor hexStringToColor:@"d8d8d8"];
    _achieveBtn.layer.cornerRadius = 5;
    _achieveBtn.layer.masksToBounds = YES;
    _achieveBtn.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:Placeholder];
    _achieveBtn.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#ea2a2a"];
   
    
    [_achieveBtn addTarget:self action:@selector(TiJiao) forControlEvents:UIControlEventTouchUpInside];

    
    
    [_originalPasswordTF setSecureTextEntry:YES];
    [_passwordTowTF setSecureTextEntry:YES];
    [_passwordTF setSecureTextEntry:YES];

    
    // Do any additional setup after loading the view from its nib.
}
-(void)TiJiao
{
    BOOL mima=[GeneralizedProcessor CheckInput:_passwordTF.text];

    if (mima) {
        
        if ([_passwordTF.text isEqualToString:_passwordTowTF.text])
        {
            NSLog(@"tetet=%@,dadada=%@",_originalPasswordTF.text,_passwordTF.text);
//            [ AccountRequest   accountChangePassWord:^(NSDictionary *userDic) {
//                NSLog(@"userDic=%@",userDic);
//            } :_originalPasswordTF.text :_passwordTF.text ];
             [UserInfoRequest modifyUserPass:^(NSDictionary *userDic) {
                 NSLog(@"userdic=%@",userDic);
             } :_originalPasswordTF.text :_passwordTowTF.text];
            

        }else
        {
            [self setauial:@"两次输入的密码不一致"];
        }
        
    }else
    {
    
        [self setauial:@"密码为6-16位字母，数字，特殊字符"];

    
    }
}
#pragma mark----dele
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_originalPasswordTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [_passwordTowTF resignFirstResponder];
    
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    
    if (_passwordTowTF.text.length>0)
    {
    }
    [_passwordTowTF resignFirstResponder];
    
}
-(void)setauial:(NSString*)str
{
    
    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [al show];
    
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
