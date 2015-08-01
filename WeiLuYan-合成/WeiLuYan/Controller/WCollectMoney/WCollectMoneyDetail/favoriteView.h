//
//  favoriteView.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 14-12-30.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoneyDetailObject.h"

@interface favoriteView : UIView
@property (weak, nonatomic) IBOutlet UITableView *favoriteView;

-(void)setData:(MoneyDetailObject *)data;
@end
