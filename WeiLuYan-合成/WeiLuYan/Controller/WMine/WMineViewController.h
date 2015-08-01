//
//  MySettingViewController.h
//  WeiLuYan
//
//  Created by gaob on 14/12/9.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHeaderIcon.h"

@interface WMineViewController : UIViewController

@property (nonatomic,retain) WHeaderIcon * myview;
@property(nonatomic)int useridd;
@property (nonatomic,strong) NSArray * tagInfoArray;

@property (weak, nonatomic) IBOutlet UIView *EditingView;
@property (weak, nonatomic) IBOutlet UIButton *headerIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *officeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end
