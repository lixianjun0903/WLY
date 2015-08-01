//
    //  WMineViewController.m
//  WeiLuYan
//
//  Created by jikai on 14-12-11.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WEditViewController.h"
#import "UserInfoRequest.h"
#import "MenuSheet.h"
#import "PersonalInfoModel.h"
#import "UIButton+WebCache.h"
#import "AppDelegate.h"
#import "MBProgressHUD+Show.h"
#import "AccountModel.h"
#import "PersonInfoEditeObject.h"
#import "UserInfoObject.h"
#import "TagObject.h"
#import "descAlertView.h"

#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define hiehtce  35

@interface WEditViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *headerIcon;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *officeTextField;
@property (nonatomic,strong) MenuSheet * sheet;
@property (nonatomic,strong) UserInfoObject * userInfo;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (nonatomic,strong) UITextView * inputView;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UIButton *descButton;
@property (nonatomic,strong) UIView * descAlert;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollVIew;
@property (nonatomic,strong) descAlertView * alert;
@end

@implementation WEditViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerIcon.layer.masksToBounds = YES;
    _headerIcon.layer.cornerRadius = _headerIcon.frame.size.height/2;
    _nameTextField.delegate = self;
    _companyTextField.delegate = self;
    _officeTextField.delegate = self;
   // _mainScrollVIew.backgroundColor = [UIColor whiteColor];
    
    [self loadUserData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordHide) name:UIKeyboardWillHideNotification object:nil];

}

#pragma mark 键盘弹出
-(void)keybordShow
{
    [UIView animateWithDuration:.5 animations:^{
        
        self.view.frame = CGRectMake(0, -140, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

#pragma mark 键盘隐藏
-(void)keybordHide
{
    [UIView animateWithDuration:.5 animations:^{
      
        self.view.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

#pragma mark textField的代理函数

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
    [self createRightItem];
}

#pragma mark 设置导航右按钮
-(void)createRightItem
{
    UIButton * save = [UIButton buttonWithType:UIButtonTypeCustom];
    save.frame = CGRectMake(0, 0, 60, 40);
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor colorWithRed:191/255.0 green:41/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    [save addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:save];
}

#pragma mark 保存信息
-(void)saveInfo
{
    NSString * str = _nameTextField.text;
    str = _companyTextField.text;
    str = _officeTextField.text;
    str = _descButton.titleLabel.text;
    if(!_nameTextField.text){
        _nameTextField.text = @"";
    }
    if(!_companyTextField.text){
        _companyTextField.text = @"";
    }
    if(!_officeTextField.text){
        _officeTextField.text = @"";
    }
    if(!_descButton.titleLabel.text){
        _descButton.titleLabel.text = @"";
    }
    
    NSDictionary * dic = @{@"user_name":_nameTextField.text,@"company":_companyTextField.text,@"office":_officeTextField.text,@"address":@"peking",@"desc":_descButton.titleLabel.text};
    [UserInfoRequest editUserInfo:^(NSDictionary *responseDic) {
        
        [[[UIAlertView alloc] initWithTitle:nil message:@"保存信息成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        [[AppDelegate instance].MainBar btnClick];
        
    } fail:^(int errCode, NSError *err) {
        if(errCode == 2024){
            [[[UIAlertView alloc] initWithTitle:nil message:@"编辑失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        }
    } :dic];
    
}

#pragma mark 判断邮箱是否正确
-(BOOL)judge:(NSString *)email
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if(![emailTest evaluateWithObject:email])
    {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:nil message:@"邮箱输入有误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
    }
    return [emailTest evaluateWithObject:email];
}


#pragma mark 获取用户信息
-(void)loadUserData
{
    [UserInfoRequest getShowEditInfo:^(PersonInfoEditeObject *userDic) {

        [self refreshUI:userDic.user_arr];
    }];
}

- (void)refreshUI:(UserInfoObject *)userInfo
{
    if(![userInfo.avatar isEqualToString:@""]){
        [_headerIcon sd_setImageWithURL:[NSURL URLWithString:userInfo.avatar] forState:UIControlStateNormal];
    }
    else{
        [_headerIcon setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    }
    if([userInfo.user_name isEqualToString:@""]){
        _nameTextField.text = userInfo.nick_name;
    }
    else{
        _nameTextField.text = userInfo.user_name;
    }
    _companyTextField.text = userInfo.company;
    _officeTextField.text = userInfo.office;
    [self sureClick:userInfo.desc];
}

#pragma mark 地址的点击函数
- (IBAction)addressClick {
    
}

#pragma mark 个人简介
- (IBAction)descClick {
    [self.view endEditing:YES];
    
    _alert = [[descAlertView alloc] initWithFrame:self.view.frame];
    _alert.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [_alert setTitle:@"个人简介" buttonTitle:@"确定"];
    [_alert setInfo:_descButton.titleLabel.text];
    __weak WEditViewController * we = self;
    _alert.cancle = ^{
        [we.alert removeFromSuperview];
    };
    _alert.ensure = ^(NSString * str){
        [we sureClick:str];
        [we.alert removeFromSuperview];
    };
    [self.view addSubview:_alert];
    
}

-(void)sureClick:(NSString *)str;
{
    [self.view endEditing:YES];
    _descButton.titleLabel.numberOfLines = 0;
    [_descButton setTitle:str forState:UIControlStateNormal];
    [_descAlert removeFromSuperview];
    CGRect frame = _descButton.frame;
    frame = CGRectMake(110, 10, 196, 25);
    CGSize size = [str boundingRectWithSize:CGSizeMake(196, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    if(size.height < 25){
        return;
    }
    _descButton.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    frame = _descView.frame;
    _descView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height + 20);
    frame = _infoView.frame;
    _infoView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, _descView.frame.origin.y + _descView.frame.size.height + 20);
    _lineView.frame = CGRectMake(0, _descView.frame.size.height - 1, self.view.frame.size.width, 1);
    _mainScrollVIew.contentSize = CGSizeMake(WIDTH, _infoView.frame.size.height + 200 + 50);
    _mainScrollVIew.scrollEnabled = YES;
    
}

#pragma mark 更改头像

- (IBAction)headerIconClick {
    
    [AppDelegate instance].MainBar.BarBtn.hidden = YES;
    self.sheet = [[MenuSheet alloc] initWithController:self targetImage:_headerIcon isID:NO];
    self.sheet.dimissBlock = ^{
        
    };
    self.sheet.cancelBlock = ^{
        [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    };
    
    [self.sheet show];
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
