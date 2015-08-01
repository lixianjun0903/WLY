//
//  WTagViewController.m
//  WeiLuYan
//
//  Created by gaob on 15/1/30.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "WTagViewController.h"

@interface WTagViewController ()

@end

@implementation WTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",self.tag_arr);
    
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
