//
//  WFeedbackViewController.m
//  WeiLuYan
//
//  Created by dev on 14/12/12.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WFeedbackViewController.h"
#import "MBProgressHUD+Show.h"
#import "UserInfoRequest.h"
#import "AppDelegate.h"

@interface WFeedbackViewController ()<UITextViewDelegate>
{

    __weak IBOutlet UITextView *_textView;
}
@property (nonatomic,strong) AFRequestState * state;
@end

@implementation WFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)commitClick:(id)sender
{
    if(self.state.running){
        return;
    }
    MBProgressHUD * mbHud = [MBProgressHUD mbHubShow];
    self.state = [[UserInfoRequest feedBack:^(NSDictionary * userDic) {
        
        [[[UIAlertView alloc] initWithTitle:nil message:@"反馈成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        [[AppDelegate getNav] popViewControllerAnimated:YES];
        
    } :_textView.text fail:^(int errCode, NSError *err) {
        
        if(errCode == 5529){
            [[[UIAlertView alloc] initWithTitle:nil message:@"反馈内容不能为空或内容最短10个字符" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        }
        else{
            [AFAppRequest error_hanlde:errCode Witherr:err];
        }
        
    }] addNotifaction:mbHud];
    

    [_textView resignFirstResponder];
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self.view endEditing:YES];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
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
