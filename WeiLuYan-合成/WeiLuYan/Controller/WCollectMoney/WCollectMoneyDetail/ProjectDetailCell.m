//
//  ProjectDetailCell.m
//  WeiLuYan
//
//  Created by jikai on 15/2/6.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ProjectDetailCell.h"
#import "ProjectDetailViewController.h"
#import "AppDelegate.h"

@implementation ProjectDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.detailView.numberOfLines = 0;
}
- (IBAction)detailClick {
    ProjectDetailViewController * vc = [ProjectDetailViewController new];
    [[AppDelegate getNav] pushViewController:vc animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
