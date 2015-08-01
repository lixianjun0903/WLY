//
//  InvestmentViewController.m
//  WeiLuYan
//
//  Created by weiluyan on 14-10-17.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "InvestmentViewController.h"

@interface InvestmentViewController ()

@end

@implementation InvestmentViewController
-(void)setNavarBar
{
//    [self.navigationController.navigationBar setBarTintColor:[GeneralizedProcessor hexStringToColor:colorRead]];
    
    UIButton*leftBton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBton setFrame:CGRectMake(10, 0, 40, 40)];
    [leftBton setImage:[UIImage imageNamed:@"closed_W"] forState: UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:leftBton];
    
    
    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    t.font = [UIFont systemFontOfSize:18];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    t.text = @"绑定手机号";
    t.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:20];
    self.navigationItem.titleView = t;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self setNavarBar];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(10,94,80, 35)];
    la.text=@"投资份数:";
    [self.view addSubview:la];
    
    self.view.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#eeeae7"];
    _moneyTF=[[UITextField alloc]initWithFrame:CGRectMake(90,94,210, 35)];
    _moneyTF.delegate=self;
    [_moneyTF setReturnKeyType: UIReturnKeySend];
    _moneyTF.font=[UIFont fontWithName:@"Helvetica" size:14];
    [_moneyTF setBorderStyle:  UITextBorderStyleRoundedRect];
    [self.view addSubview:_moneyTF];
    
    UILabel *lamoney=[[UILabel alloc]initWithFrame:CGRectMake(10, 139,80, 35)];
    lamoney.text=@"投资金额:";
    [self.view addSubview:lamoney];
    
    UILabel *lamoenyTwo=[[UILabel alloc]initWithFrame:CGRectMake(90, 139,80, 35)];
    lamoenyTwo.text=@"1000元";
    [self.view addSubview:lamoenyTwo];

    UIButton*nextButton=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [nextButton addTarget:self action:@selector(Bangding) forControlEvents:UIControlEventTouchUpInside];
    nextButton.frame=CGRectMake(10,184, 300, 40);
    nextButton.backgroundColor=[GeneralizedProcessor hexStringToColor:colorRead];
    [nextButton setTintColor:[UIColor whiteColor]];
    nextButton.layer.masksToBounds = YES;
    nextButton.layer.cornerRadius = 4.0;
    nextButton.layer.borderWidth = 1.0;
    nextButton.layer.borderColor = [[UIColor clearColor] CGColor];
    [nextButton setTitle:@"提交" forState:UIControlStateNormal];
    nextButton.titleLabel.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:20];
    [self.view addSubview:nextButton];
    

    // Do any additional setup after loading the view.
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
