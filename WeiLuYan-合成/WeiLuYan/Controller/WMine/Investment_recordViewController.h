//
//  Investment_recordViewController.h
//  WeiLuYan
//
//  Created by weiluyan on 14-10-17.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Investment_recordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *Mytabview;

@property(nonatomic,retain)NSArray *namearr;

@end
