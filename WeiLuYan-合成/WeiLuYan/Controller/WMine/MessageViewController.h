//
//  MessageViewController.h
//  WeiLuYan
//
//  Created by weiluyan on 14-10-14.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonIndexPath.h"
@interface MessageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{

    BOOL isOpen;
    int selectedIndex;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *Mytabview;
@property(nonatomic,retain)NSMutableArray *namearr;
//@property(nonatomic,assign)BOOL isOpen;
//@property(nonatomic,assign)NSUInteger selectedIndex;

@property(nonatomic,retain)UIButtonIndexPath *btnJiantou;
@property(nonatomic,retain)NSMutableArray *arr;
@property(nonatomic,retain)NSMutableArray *arrAttachedCell;

@end
