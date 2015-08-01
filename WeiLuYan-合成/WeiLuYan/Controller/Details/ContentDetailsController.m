//
//  ContentDetailsController.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/30.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ContentDetailsController.h"

@interface ContentDetailsController ()

@end

@implementation ContentDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _contentDetails.text = [NSString stringWithFormat:@"%@",self.content];
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
