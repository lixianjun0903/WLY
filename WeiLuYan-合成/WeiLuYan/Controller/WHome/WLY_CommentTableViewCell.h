//
//  WLY_CommentTableViewCell.h
//  WeiLuYan
//
//  Created by 张亮 on 14-9-23.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentObject1.h"

typedef enum{
    NORMAL  ,
    VIPUser ,
    FUSER
}userStyle;

@interface WLY_CommentTableViewCell : UITableViewCell
@property( nonatomic, strong) UIButton* commentUserIcon;
@property( nonatomic, strong) UIImageView* userLevlIcon;
@property( nonatomic, strong) UILabel* userNameLable;
@property( nonatomic, strong) UILabel* commentContent;
@property( nonatomic, strong) UILabel* comentDate;
@property( nonatomic, assign) userStyle  USERSTYLE;

-(void)setCommentObjectValue:(CommentObject1*)commentObject;

-(CGFloat)getHeightFrom:(CommentObject1*)commentObject;
@end
