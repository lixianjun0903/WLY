//
//  WProjectViewController.h
//  WeiLuYan
//
//  Created by dev on 14/12/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFindViewController.h"

@interface WProjectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) WFindViewController * find;

-(void)setFindViewController:(WFindViewController *)findVC;

@end
