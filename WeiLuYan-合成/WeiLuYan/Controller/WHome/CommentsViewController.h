//
//  CommentsViewController.h
//  WeiLuYan
//
//  Created by weiluyan on 14-10-13.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextLimitView.h"

@interface CommentsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property(nonatomic,retain)UITableView *mytabview;
@property(nonatomic,retain)UILabel *textLa;
@property(nonatomic,retain)UILabel *textLatwo;
@property(nonatomic,retain)TextLimitView * textview;



@end
