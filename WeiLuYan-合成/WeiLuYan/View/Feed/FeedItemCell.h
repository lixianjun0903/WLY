//
//  WLY_UserDateTableViewCell.h
//  WeiLuYan
//
//  Created by 张亮 on 14-9-18.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedHeaderView.h"
#import "ShareActivity.h"
#import "UMSocialShakeService.h"
#import "CollectMoneyObject.h"
#import "ActivityInfo.h"

typedef NS_ENUM(NSInteger, FeedCellType) {
    Home = 0,
    Expand = 1,
    Project = 2,
    Separator = 16,
    
    Fproject = 10,
    Fperson = 11,
};

@class ActiveObject;

@interface FeedItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *CellBG;

@property (weak, nonatomic) IBOutlet FeedHeaderView *headerView;

@property( nonatomic, strong) CollectMoneyObject * Data;
@property(nonatomic,strong) ActivityInfo * ActData;
@property( nonatomic, strong) UIViewController * Controller;
@property (nonatomic) FeedCellType Style;


@property( nonatomic, readonly) CGFloat CellHeight;
@property( nonatomic, readonly, getter=isExpand) BOOL Expand;
@property (nonatomic) FeedCellType CellType;
@property (strong,nonatomic) void (^reLoadBlock)(void);

+(CGFloat)getCellHeight:(NSInteger)style;
//-(CGFloat)getCellHeight:(NSInteger)style;
-(void)setStyle:(FeedCellType)Style;
-(void)initView;


@end
