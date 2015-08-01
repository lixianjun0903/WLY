//
//  Comment.h
//  WLY-TeamCommentView
//
//  Created by weiluyan on 14/12/30.
//  Copyright (c) 2014年 JX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YcKeyBoardView.h"
#import "MoneyDetailObject.h"
#import "CollectMoneyObject.h"
#import "CommentTableViewCell.h"
@interface Comment : UIView
@property (weak, nonatomic) IBOutlet UITableView *myTabView;
@property (nonatomic,strong) YcKeyBoardView * key;
@property (nonatomic, assign) int  project_id;
@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@property (nonatomic,strong) MoneyDetailObject * Data;
@property (nonatomic,strong) CollectMoneyObject * listData;
@property (nonatomic,strong) CommentTableViewCell * cell;
- (void)loadData:(id)notify Num:(int)num;
-(void)initKyeBoard;
-(void)recoverKeybord;
@end
