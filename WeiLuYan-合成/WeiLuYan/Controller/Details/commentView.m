//
//  commentView.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "commentView.h"
#import "WMineViewController.h"

@implementation commentView
alloc_with_xib(ForCommentView)

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    return self;
}
- (IBAction)userClick:(id)sender {
    
    WMineViewController * vc = [[WMineViewController alloc] init];
    vc.useridd = self.ID;
    [_controller.navigationController pushViewController:vc animated:YES];
}

-(void)awakeFromNib
{
    
}
@end
