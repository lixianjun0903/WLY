//
//  UIButtonIndexPath.h
//  WeiLuYan
//
//  Created by 张亮 on 14-9-18.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonIndexPath : UIButton
@property( nonatomic, strong)NSIndexPath*indexPath;
@property( nonatomic, assign)int value_id;
@property( nonatomic, assign)BOOL isSelected;
@end
