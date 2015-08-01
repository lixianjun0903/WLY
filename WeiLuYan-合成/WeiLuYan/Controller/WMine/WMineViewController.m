//
//  MySettingViewController.m
//  WeiLuYan
//
//  Created by gaob on 14/12/9.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WMineViewController.h"
#import "AppDelegate.h"
#import "UserInfoRequest.h"
#import "UIButton+WebCache.h"
#import "WEditViewController.h"
#import "AuthenticationViewController.h"
#import "WChangePWDViewController.h"
#import "WLoginViewController.h"
#import "AccountRequest.h"
#import "AccreditedInvestorViewController.h"
#import "NewWRPasswordViewController.h"
#import "MBProgressHUD+Show.h"
#import "MBProgressHUD.h"

@interface WMineViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *realNameImageView;
@property (nonatomic,strong) AFRequestState * state;
@property (weak, nonatomic) IBOutlet UIButton *setingButton;
@property (nonatomic,strong) UserObject * userInfo;
@property (nonatomic,assign) BOOL attention;
@property (nonatomic,strong) UIButton * rightItem;
@property (nonatomic,assign) int myUserId;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UIButton *editingItem;
@property (weak, nonatomic) IBOutlet UIView *realNameView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@end

@implementation WMineViewController

-(void)viewWillAppear:(BOOL)animated
{
    if(_useridd){
        [_editingItem removeFromSuperview];
        [_setingButton removeFromSuperview];
        [_realNameView removeFromSuperview];
        [self createNav];
    }
    [self loadData];
    
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
    _EditingView.hidden = YES;
    _EditingView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_white"]];
}

-(void)createNav
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nil];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 70, 70);
    _rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightItem.frame = CGRectMake(20, 20, 25, 25);
    [button addTarget:self action:@selector(follow) forControlEvents:UIControlEventTouchUpInside];
    [_rightItem addTarget:self action:@selector(follow) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:_rightItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)follow
{
    _attention = !_attention;

    [UserInfoRequest Attention:^(NSDictionary *userDic) {
        if(_attention){
            [MBProgressHUD creatembHub:@"关注成功"];
        }
        else{
            [MBProgressHUD creatembHub:@"已取消关注"];
        }
        [self refreshNavItem];
    } data:@[[NSNumber numberWithInt:_useridd]] isAttention:_attention];
}

#pragma mark 创建导航
-(void)refreshNavItem
{
    if(_attention){
        [_rightItem setBackgroundImage:[UIImage imageNamed:@"btn_attention_highlight"] forState:UIControlStateNormal];
    }
    else{
        [_rightItem setBackgroundImage:[UIImage imageNamed:@"btn_attention_default"] forState:UIControlStateNormal];
    }
}

-(void)dealloc
{
    _useridd = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideEditeView)]];
    
}

-(void)hideEditeView
{
    _EditingView.hidden = YES;
}


#pragma mark 编辑点击事件
-(void)buttonClick:(UIButton *)sender
{
    WEditViewController * edite = [WEditViewController new];
    
    [self.navigationController pushViewController:edite animated:YES];
}

#pragma mark 加载数据
-(void)loadData
{
    if(self.state.running){
        return;
    }
    self.state = [UserInfoRequest getUserInfoID:^(UserObject * userObject) {
        
        [self refreshUI:userObject];
        _userInfo = userObject;
        _myUserId = userObject.user_id;
        
    } userid:_useridd];
}

#pragma mark 刷新UI
-(void)refreshUI:(UserObject *) user
{
    if(![user.avatar isEqualToString:@""]){
    [_headerIcon sd_setImageWithURL:[NSURL URLWithString:user.avatar] forState:UIControlStateNormal];
    }
    else{
        [_headerIcon setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    }
    _headerIcon.layer.masksToBounds = YES;
    _headerIcon.layer.cornerRadius = _headerIcon.frame.size.height/2;
    if([user.user_name isEqualToString:@""]){
        _nameLabel.text = user.nick_name;
    }
    else{
        _nameLabel.text = user.user_name;
    }
    
    if(user.card_status == 1){
        _realNameImageView.image = [UIImage imageNamed:@"btn_choice"];
    }
    _companyLabel.text = user.company;
    _officeLabel.text = user.office;

    _addressLabel.text = user.address;
    _descLabel.text = user.desc;
    _attention = user.is_attention;
    
    CGRect frame = _descLabel.frame;
    CGSize size = [user.desc boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    if(size.height < 20){
        size.height = 20;
    }
    _descLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    frame = _descView.frame;
    _descView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 20 + size.height);
    frame = _realNameView.frame;
    
    _realNameView.frame = CGRectMake(frame.origin.x, _descView.frame.size.height + _descView.frame.origin.y, frame.size.width, frame.size.height);
    frame = _descView.frame;
    if(_useridd){
        _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, frame.origin.y + frame.size.height + 100);
    }
    else{
        _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _realNameView.frame.size.height + _realNameView.frame.origin.y + size.height);
    }
    
    [self refreshNavItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark 设置按钮点击
- (IBAction)settingClick {
    
    _EditingView.hidden = !_EditingView.hidden;
    
}

#pragma mark 实名认证
- (IBAction)realNameAuthentication {
    
    AuthenticationViewController * authentication = [AuthenticationViewController new];
    [self.navigationController pushViewController:authentication animated:YES];
    
}

#pragma mark 合格投资人认证
- (IBAction)investorsCertification {
    if(!_userInfo.card_status){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"您还没有实名认证" message:@"请先进行实名认证" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    AccreditedInvestorViewController * ac = [AccreditedInvestorViewController new];
    [self.navigationController pushViewController:ac animated:YES];
}

#pragma mark 编辑个人中心
- (IBAction)EditPersonInfo {
    
    _EditingView.hidden = YES;
    WEditViewController * edite = [WEditViewController new];
    [self.navigationController pushViewController:edite animated:YES];
    
}

#pragma mark 修改密码
- (IBAction)changPassword {
    NewWRPasswordViewController * wr = [NewWRPasswordViewController new];
    [self.navigationController pushViewController:wr animated:YES];
}

#pragma mark 退出登录
- (IBAction)logout:(id)sender {
    
    [AccountRequest accountLogout:^(NSDictionary *userDic)
     {
         [[AccountModel instance] clearTokenAndInfo];
         
     }];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户已退出" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [[AccountModel instance] clearTokenAndInfo];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[AppDelegate instance] appLogout];
}

@end
