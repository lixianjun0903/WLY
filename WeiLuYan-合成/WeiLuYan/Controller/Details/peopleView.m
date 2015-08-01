//
//  peopleView.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "peopleView.h"
#import "WMineViewController.h"

@implementation peopleView
alloc_with_xib(ForPeopleView)

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

-(void)awakeFromNib
{
    _moneyLabel.layer.masksToBounds = YES;
    _moneyLabel.layer.cornerRadius = 5;
}

-(void)setFlag:(int)flag
{
    if(flag == 0)
    {
        _moneyLabel.hidden = YES;
        
    }
    else
    {
        _moneyLabel.hidden = NO;
    }
    
}

- (IBAction)userClick:(id)sender {
    
    WMineViewController * vc = [[WMineViewController alloc] init];
    vc.useridd = self.ID;
    [_controller.navigationController pushViewController:vc animated:YES];
}

@end
