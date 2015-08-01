//
//  CommentViewController.h
//  WeiLuYan
//
//  Created by 张亮 on 14-9-23.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YcKeyBoardView.h"
#import "ForwardFeedObject.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshFooterView.h"
#import "ActiveObject.h"

@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YcKeyBoardViewDelegate,MJRefreshBaseViewDelegate>
@property( nonatomic, strong)UITableView*mainTableView;
@property (nonatomic,strong)YcKeyBoardView *key;
@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@property( nonatomic, strong)ActiveObject*forwardFeedObject;
@property( nonatomic, assign) BOOL isCommentBton;
@property( nonatomic, strong) NSMutableArray*dataArray;
@property( nonatomic, strong) NSMutableArray*refreshDataArray;
@property( nonatomic, assign) NSUInteger number;
@end
