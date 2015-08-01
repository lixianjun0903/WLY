//
//  WSetCell.h
//  WeiLuYan
//
//  Created by dev on 14/12/12.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

-(void)Config:(NSString *)content;

@end
