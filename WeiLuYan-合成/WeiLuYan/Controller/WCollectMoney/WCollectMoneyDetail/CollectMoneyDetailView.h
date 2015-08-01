//
//  WDetailView.h
//  UIAlertController
//
//  Created by dev on 14/12/30.
//  Copyright (c) 2014年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectMoneyDetailView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *_mainScrollView;
//@property (weak, nonatomic) IBOutlet UIImageView *_headerIcon;
//@property (weak, nonatomic) IBOutlet UILabel *_topLabel;
//@property (weak, nonatomic) IBOutlet UILabel *_middleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *_bottomLabel;
@property (strong, nonatomic)  UILabel *_bottomLab;
@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (strong, nonatomic) IBOutlet UIView *_headerView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSString * strDetails;
@property (nonatomic, strong) NSString * details;

-(void)refreshHeight;
@end
