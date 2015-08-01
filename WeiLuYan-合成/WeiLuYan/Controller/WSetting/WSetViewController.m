//
//  WSetViewController.m
//  WeiLuYan
//
//  Created by dev on 14/12/11.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

//
#import "WSetViewController.h"
#import "GeneralizedProcessor.h"
#import "AppDelegate.h"
#import "MBProgressHUD+Show.h"
#import "WLoginViewController.h"
#import "WSetCell.h"
#import "WBindAndQuit.h"

#define KEY  @"2614596120"
#define URLR @"http://lyb.qinminwang.cn"

@interface WSetViewController ()
{
    __weak IBOutlet UITableView *_tableView;
    NSString * weibodengli;
    NSString * qqdengli;
    
    BOOL bangdingWeibo;
    BOOL bangdingQQ;
    
    int tag;
    
    BOOL section;
    
}

@property(nonatomic,retain) NSArray * arrcelltext;

@end

@implementation WSetViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self hasWeiboAndQQ];
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
    
    
}

-(void)hasWeiboAndQQ
{
    AccountModel * mod = [AccountModel instance];
    weibodengli = mod.personInfoModel.weibo_name;
    qqdengli = mod.personInfoModel.qq_name;
    
    if ([qqdengli  isEqualToString:@""])
    {
        bangdingQQ = false;
    }
    else
    {
        bangdingQQ = true;
    }
    
    
    if ([weibodengli isEqualToString:@""])
    {
        bangdingWeibo = false;
    }
    else
    {
        bangdingWeibo = true;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:@"WSetCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    _arrcelltext = [NSArray arrayWithObjects:@"绑定QQ",@"绑定微博",@"修改密码",@"反馈",@"关于", nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 5;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
   WSetCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self setCellContent:indexPath :cell];
    
    return cell;
}

-(void)setCellContent:(NSIndexPath *)indexPath :(WSetCell *)cell
{
    if (indexPath.section == 0)
    {
        cell.textLabel.text = [_arrcelltext objectAtIndex:indexPath.row];
        
        if (indexPath.row == 1)
        {
            if (bangdingWeibo == true)
            {
                [cell Config:@"已绑定"];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else{
                [cell Config:@""];
            }
        }
        
        if (indexPath.row == 0)
        {
            if (bangdingQQ == true)
            {
                [cell Config:@"已绑定"];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else{
                [cell Config:@""];
            }
        }
    }
    
    if (indexPath.section == 1 && indexPath.row == 0){
        cell.textLabel.text = @"退出登录";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        
        section = NO;
        [WBindAndQuit ControllersForPush:self.navigationController :indexPath];
        
        [WBindAndQuit BindForQQ:indexPath :self];
        
        [WBindAndQuit bindForWeibo:indexPath :self];
    }
    
    
    if (indexPath.section == 1)
    {
        
        section = YES;
        [WBindAndQuit Quit:bangdingWeibo];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户已退出" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [[AppDelegate instance] appLogout];
    }
}

-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response
{
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (section) {
        return;
    }
    [AppDelegate instance].MainBar.BarBtn.hidden = YES;
    [AppDelegate instance].MainBar.NaveBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
