//
//  CommentTableViewCell.h
//  WLY-TeamCommentView
//
//  Created by weiluyan on 14/12/29.
//  Copyright (c) 2014年 JX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(void)config:(NSDictionary *)dic;
-(CGFloat)getCellHeight;
@end
