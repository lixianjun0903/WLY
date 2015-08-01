//
//  WUserEditController.m
//  WeiLuYan
//
//  Created by gaob on 15/1/27.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "WUserEditController.h"
#import "UserInfoRequest.h"
#import "MBProgressHUD+Show.h"
#import "UIImageView+WebCache.h"
#import "MenuSheet.h"
#import "AppDelegate.h"
#import "UIButton+WebCache.h"
#import "WTagViewController.h"

#define LABX     [UIScreen mainScreen].bounds.size.width - 220


@interface WUserEditController () <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>


{
    NSArray * titleArray1;
    NSArray * titleArray2;
    NSArray * userInfoArray;
    BOOL isFirst;
    
    UITextField * sexTf;
    UITextField * job_statusTf;//状态
    UITextField * officeTf; //职位
    UITextField * signTf;
    
    UIButton * _button;

}




@property (nonatomic, strong) NSDictionary * userInfoDic;

@property (nonatomic ,strong) NSMutableArray * tfArray;
//用来检测是否有修改过
//@property (nonatomic ,strong) NSMutableArray * tempTFArray;

@property (nonatomic ,strong) NSMutableDictionary *job_arr;

@property (nonatomic ,strong) NSMutableDictionary *office_arr;

@property (nonatomic ,strong) UserInfoObject *user_arr;

@property (nonatomic,strong) NSMutableDictionary * tempInfoDic;

@property (nonatomic, strong) MenuSheet * ms;

@end

@implementation WUserEditController

-(void)viewWillAppear:(BOOL)animated
{
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
    [self createRightItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isFirst = YES;
    //[self createRightItem];
    [self createUI];
    [self createTableViewList];
    [self loadData];
    
}

#pragma mark 设置导航右按钮
-(void)createRightItem
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, 60, 30);
    [_button setTitle:@"保存" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithRed:191/255.0 green:41/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:17];
    [_button addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_button];
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

-(void)saveInfo
{
//    if (tempTf) {
//        [self textFieldDidEndEditing:tempTf];
//    }
//    if (!isEdited) {
//        [[AppDelegate getNav] popViewControllerAnimated:YES];
//        return;
//    }
    if ([[_tfArray[0] text] isEqualToString:@""]) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"😊亲，昵称不能为空哦~😊" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [al show];
        return;
    }
    
    if (![self judge:[_tfArray[3] text]]) {
        return;
    }
    
    [self getNewUserInfo];
}

-(void)getNewUserInfo
{

    
    self.tempInfoDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [_tempInfoDic setObject:[_tfArray[0] text] forKey:@"nick_name"];//昵称
    [_tempInfoDic setObject:[_tfArray[1] text] forKey:@"real_name"];//真实姓名
    [_tempInfoDic setObject:[_tfArray[2] text] forKey:@"address"];//所在地
    //    [_tempInfoDic setObject:_tfArray[3] forKey:];//手机号
    [_tempInfoDic setObject:[_tfArray[3] text] forKey:@"email"];//邮箱
    
    //工作状态
    for (NSString * key in [_job_arr allKeys]) {
        if ([job_statusTf.text isEqualToString:[_job_arr objectForKey:key]])
        {
            [_tempInfoDic setObject:[NSNumber numberWithInt:[key intValue]] forKey:@"job"];
        }
    }
    
    //职位
    for (NSString * key in [_office_arr allKeys]) {
        if ([officeTf.text isEqualToString:[_office_arr objectForKey:key]])
        {
            [_tempInfoDic setObject:[NSNumber numberWithInt:[key intValue]] forKey:@"office"];
        }
    }
    //性别
    if ([sexTf.text isEqualToString:@"男"]) {
        [_tempInfoDic setObject:[NSNumber numberWithInt:1] forKey:@"sex"];

    }else if ([sexTf.text isEqualToString:@"女"])
    {
        [_tempInfoDic setObject:[NSNumber numberWithInt:2] forKey:@"sex"];
    }
    else
    {
        [_tempInfoDic setObject:[NSNumber numberWithInt:0] forKey:@"sex"];
    }

    NSLog(@"%@",_tempInfoDic);
    [self updateUserInfo];
}
#pragma mark 上传信息
-(void)updateUserInfo
{
    [UserInfoRequest editUserInfo:^(NSDictionary *responseDic) {
        
        [MBProgressHUD creatembHub:@"编辑成功"];
//        [[AppDelegate getNav] popViewControllerAnimated:YES];
        
    } fail:nil :_tempInfoDic];
}

-(void)loadData
{
    MBProgressHUD * mb = [MBProgressHUD mbHubShow];
    [UserInfoRequest getShowEditInfo:^(PersonInfoEditeObject *userDic) {
        
        [self getShowFromObj:userDic];
        
        [UserInfoRequest getUserInfo:^(NSDictionary *userDic) {
            //成功
            
            self.userInfoDic = [NSDictionary dictionaryWithDictionary:userDic];
            NSLog(@"%@",self.userInfoDic);
            
//            [self.headerImg sd_setImageWithURL:[NSURL URLWithString:self.user_arr.avatar]];
            
            [self.headerImg sd_setImageWithURL:[NSURL URLWithString:self.userInfoDic[@"avatar"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_user_L"]];
            
            
            isFirst = NO;
            [mb removeFromSuperview];
            [self.tableView reloadData];
            
            
            
        }];
        
    } ];
    
    
    
}

-(void)headerTap
{
    
    self.ms = [[MenuSheet alloc] initWithController:self targetImage:self.headerImg isID:NO];
    [AppDelegate instance].MainBar.BarBtn.hidden = YES;
    self.ms.dimissBlock = ^
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        [AppDelegate instance].MainBar.BarBtn.hidden = NO;

        
    };
    self.ms.cancelBlock = ^
    {
        [AppDelegate instance].MainBar.BarBtn.hidden = NO;

    };
    self.ms.navButn = _button;
    [self.ms show];
}

-(void)getShowFromObj:(PersonInfoEditeObject *)object
{
    self.office_arr = [NSMutableDictionary dictionaryWithCapacity:0];
    self.job_arr = [NSMutableDictionary dictionaryWithCapacity:0];
    
    for (OfficeObject * obj in object.office_arr) {
        [self.office_arr setObject:obj.name forKey:[NSString stringWithFormat:@"%d",obj.named_id]];
    }
    for (JobStateObject *jec in object.job_arr) {
        [self.job_arr setObject:jec.name forKey:[NSString stringWithFormat:@"%d",jec.job_status_id]];
    }
    
    self.user_arr = object.user_arr;
    
    
    
}

-(void)createTableViewList
{
    titleArray1 = @[@"昵称",@"真实姓名",@"性别",@"所在地",@"职位",@"手机号",@"邮箱"];
    titleArray2 = @[@"状态",@"标签"];
    userInfoArray = @[@"nick_name",@"user_name",@"sex",@"address",@"office",@"phone",@"email"];
    self.tfArray = [NSMutableArray arrayWithCapacity:0];
//    self.tempTFArray = [NSMutableArray arrayWithCapacity:0];
    
}

-(void)createUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    
    self.headerImg.layer.cornerRadius = self.headerImg.bounds.size.width/2;
    self.headerImg.layer.masksToBounds = YES;
    self.headerImg.userInteractionEnabled = YES;
    [self.headerImg addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTap)]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return @" ";
    }
    return nil;
}

-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    }else
    {
        return 2;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
        
    }
    
    cell.textLabel.text = indexPath.section == 0 ? titleArray1[indexPath.row] : titleArray2[indexPath.row];
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    [self config:indexPath withCell:cell];
    
    
    return cell;
}

-(void)config:(NSIndexPath *)indexPath withCell:(UITableViewCell *)cell
{
    UITextField * tf;
    if (isFirst){
        
        tf = [[UITextField alloc]initWithFrame:CGRectMake(LABX, 0, 220, 35)];
        tf.textAlignment = NSTextAlignmentCenter;
        tf.tag = 999;
        tf.delegate = self;
        tf.textColor = [UIColor darkGrayColor];
        [self.tfArray addObject:tf];
//        [self.tempTFArray addObject:tf];
        [cell addSubview:tf];
        
    }
    else
    {
        tf = (UITextField *)[cell viewWithTag:999];
    }
    //设置tf的文字，用户的信息显示。
    if (indexPath.section == 0) {
        tf.text = [self.userInfoDic objectForKey:userInfoArray[indexPath.row]];
        
    }
    
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(LABX, 0, 220, 35)];
    UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    lab.textColor = [UIColor darkGrayColor];
    lab.userInteractionEnabled = YES;
    [lab addGestureRecognizer:gr];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            //性别
            sexTf = tf;
            tf.enabled = NO;
            [self.tfArray removeObject:tf];
            [cell addSubview:lab];
            
            switch ([self.userInfoDic[@"sex"] intValue]) {
                case 0:
                    sexTf.text = @"保密";
                    break;
                case 1:
                    sexTf.text = @"男";
                    break;
                case 2:
                    sexTf.text = @"女";
                    break;
                    
                default:
                    break;
            }
            
            return;
        }
        if (indexPath.row == 4) {
            //职位
            officeTf = tf;
            tf.enabled = NO;
            [self.tfArray removeObject:tf];
            [cell addSubview:lab];

            NSString * off = self.userInfoDic[@"office"];
            officeTf.text = [self.office_arr objectForKey:off];
            
            return;
        }
        
        if (indexPath.row == 5) {
            //手机号 暂时不要修改
            tf.enabled = NO;
            [self.tfArray removeObject:tf];
            return;
        }
        
    }
    else
    {
        if (indexPath.row == 0) {
            //状态
            job_statusTf = tf;
            tf.enabled = NO;
            [self.tfArray removeObject:tf];
            [cell addSubview:lab];
            job_statusTf.text = self.userInfoDic[@"job_status"];

            return;
            
        }
        if (indexPath.row == 1) {
            //标签
            signTf = tf;
            tf.enabled = NO;
            [self.tfArray removeObject:tf];
            [cell addSubview:lab];
            
            return;
            
        }
    }
}

-(void)setActionSheetWithTitle:(NSString *)title withArray:(NSArray *)arr withTag:(int)tag
{
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    
    if (tag != 0) {
        sheet.tag = tag;
    }
    
    for (NSString * str in arr) {
        [sheet addButtonWithTitle:str];
    }
    
    [sheet showInView:self.view];
}

-(void)tap:(UIGestureRecognizer *)sender
{
    UITextField * textField = (UITextField *)[sender.view.superview viewWithTag:999];
    
    if (textField == sexTf ) {
        [self setActionSheetWithTitle:@"性别" withArray:@[@"保密",@"男",@"女"] withTag:11];
    }
    if (textField == officeTf ) {
        [self setActionSheetWithTitle:@"职业" withArray:[self.office_arr allValues] withTag:22];
    }
    if (textField == job_statusTf) {
        [self setActionSheetWithTitle:@"状态" withArray:[self.job_arr allValues] withTag:33];
        
    }
    if (textField == signTf ) {
        NSLog(@"标签");
        //在此处添加标签的功能.
        
        WTagViewController * tvc = [WTagViewController new];
        
        NSArray * tempArr = self.userInfoDic[@"tag_arr"];
        
        tvc.tag_arr = [NSMutableArray arrayWithArray:tempArr];
        
        [[AppDelegate getNav] pushViewController:tvc animated:YES];
        
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        return;
    }
    
    switch (actionSheet.tag / 11) {
        case 1:
            //性别
        {
            
            switch (buttonIndex) {
                case 1:
                    sexTf.text = @"保密";
                    break;
                case 2:
                    sexTf.text = @"男";
                    break;
                case 3:
                    sexTf.text = @"女";
                    break;
                    
                default:
                    break;
            }
        }
            
            break;
        case 2:
            //职业
        {
            officeTf.text = [self.office_arr allValues][buttonIndex - 1];
        }
            
            break;
        case 3:
            //状态
        {
            job_statusTf.text = [self.job_arr  allValues][buttonIndex - 1];
        }
            
            break;
            
        default:
            break;
    }
}


-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
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
