//
//  FirstCell.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/20.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "attentionObject.h"

@interface FirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *user_icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (nonatomic,assign) BOOL is_attention;

@property (nonatomic,copy) void (^ attention)(int member_id);
@property (nonatomic,copy) void (^ cancleAttention)(int member_id);

-(void)setCellData:(attentionObject *)data attention:(BOOL)attention;
-(void)refreshButton;

@end
