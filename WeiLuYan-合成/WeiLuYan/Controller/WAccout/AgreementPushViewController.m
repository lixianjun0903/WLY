//
//  AgreementPushViewController.m
//  WeiLuYan
//
//  Created by WL-DZ-PGDN-007 on 15-3-17.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "AgreementPushViewController.h"
#import "GeneralizedProcessor.h"
@interface AgreementPushViewController ()

@end

@implementation AgreementPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#f9f9f9"];
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *txtPath = [mainBundle pathForResource:@"regist" ofType:@"txt"];
    //    将txt到string对象中，编码类型为NSUTF8StringEncoding
    NSString *string = [[NSString  alloc] initWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",string);
    

    _TV=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
    _TV.text=string;
    [self.view addSubview:_TV];
    
    
    // Do any additional setup after loading the view.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_TV resignFirstResponder];
    return YES;
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
