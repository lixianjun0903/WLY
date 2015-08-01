//
//  NoDataView.h
//  WeiLuYan
//
//  Created by wly on 15/3/25.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDataView : UIView
{
    UIView *_noDataView;
    UILabel *_noDataLabel;
}

-(UIView *)initNoDataView:(NSString *)msg andFrame:(CGRect)frame;
@end
