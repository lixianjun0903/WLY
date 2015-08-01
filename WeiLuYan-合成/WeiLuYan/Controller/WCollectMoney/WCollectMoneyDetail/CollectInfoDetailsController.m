//
//  CollectInfoDetailsController.m
//  WeiLuYan
//
//  Created by gaob on 15/1/9.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "CollectInfoDetailsController.h"

@implementation CollectInfoDetailsController


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITextView * textV = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 140)];
    
    textV.textColor = [UIColor lightGrayColor];
    textV.editable = NO;
    textV.text = self.str;
    textV.font = [UIFont systemFontOfSize:16];
    [self.view addSubview: textV];
    
}

@end
