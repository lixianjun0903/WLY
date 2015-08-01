//
//  AuthenticationViewController.m
//  WeiLuYan
//
//  Created by jikai on 15/3/13.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "AppDelegate.h"
#import "MenuSheet.h"
#import "UserInfoRequest.h"


@interface AuthenticationViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *company;
@property (weak, nonatomic) IBOutlet UIButton *identificationButton;
@property (nonatomic,strong) MenuSheet * menuSheet;
@property (nonatomic,strong) AFRequestState * state;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (nonatomic,strong) UIImage * image;

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _Name.delegate = self;
    _company.delegate = self;
    
}



#pragma mark 上传图片
- (IBAction)uploadClick {
    
    self.menuSheet = [[MenuSheet alloc] initWithController:self targetImage:self.identificationButton isID:YES];
    [AppDelegate instance].MainBar.BarBtn.hidden = YES;
    __weak AuthenticationViewController * au = self;
    
    self.menuSheet.dimissBlock = ^{
        [au dismissViewControllerAnimated:YES completion:nil];
        [AppDelegate instance].MainBar.BarBtn.hidden = NO;
        
    };
    self.menuSheet.cancelBlock = ^{
        [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    };
    
    self.menuSheet.finishBlock = ^(UIImage * image){
        au.uploadButton.hidden = YES;
        au.identificationButton.backgroundColor = [UIColor colorWithPatternImage:image];
        au.image = image;
    };
    
    [self.menuSheet show];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 提交
- (IBAction)submitClick {
    
    NSString * str = [NSString stringWithFormat:@"%@%@",_Name.text,_company.text];
    if(self.state.running){
        return;
    }
    NSArray * imageArray = @[self.image];
    
    self.state = [UserInfoRequest submitPersonalId:^(NSDictionary * dic) {
        [self.navigationController popViewControllerAnimated:YES];
        
    } data:@{@"remark":str,@"feedcontent_pic":imageArray} fail:^(int errCode, NSError *err) {
        if(errCode == 2032)
        {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的认证信息正在审核" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil] show];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
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
