//
//  WTimeViewController.m
//  WeiLuYan
//
//  Created by dev on 14/12/11.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WTimeViewController.h"
#import "EFCircularSlider.h"
#import "ShowProjectViewController.h"
#import "AppDelegate.h"

@interface WTimeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
//@property( nonatomic, strong) EFCircularSlider * circularSlider;

@property (weak, nonatomic) IBOutlet EFCircularSlider *circularSlider;

@end

@implementation WTimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setClock];
}

-(void)setClock
{
//    CGRect sliderFrame = CGRectMake(60, 80, 200, 200);
//    _circularSlider = [[EFCircularSlider alloc] initWithFrame:sliderFrame];
    [_circularSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    //[self.view addSubview:_circularSlider];
    
    _continueButton.layer.borderColor = [[GeneralizedProcessor hexStringToColor:colorRead]CGColor];
}

#pragma mark - 时间条值改变的响应事件
-(void)valueChanged:(EFCircularSlider*)slider
{
    NSString *syr = nil;
    syr = [NSString stringWithFormat:@"%d", slider.currentValue ];
    int a = [syr intValue] / 1.67 + 1;
    
    _valueLabel.text = [NSString stringWithFormat:@"%d",a];
    NSLog(@"a=%d",a);
}

- (IBAction)timeBtn:(id)sender
{
    NSString * syr = nil;
    syr = [NSString stringWithFormat:@"%d",_circularSlider.currentValue];
    int minute = [syr intValue] / 1.67 + 1;
    
    
    ShowProjectViewController * showProjectVC = [[ShowProjectViewController alloc]init];
    showProjectVC.industry_id = self.industry_id;
    showProjectVC.minute = minute;
    NSLog(@"页面跳转中");
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
