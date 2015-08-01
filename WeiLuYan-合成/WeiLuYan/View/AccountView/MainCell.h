//
//  MainCell.h
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonIndexPath.h"
@interface MainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *Headerphoto;

@property(nonatomic,retain)UIButtonIndexPath *btnJiantou;

- (void)setMainCell:(NSDictionary *)dicc;
@end
