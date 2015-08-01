//
//  TableViewCell1.h
//  UIAlertController
//
//  Created by dev on 14/12/30.
//  Copyright (c) 2014年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoneyDetailObject.h"

@interface DetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *comeFromLab;

@property (weak, nonatomic) IBOutlet UILabel *midLab;

@property (weak, nonatomic) IBOutlet UILabel *cityLab;

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;

-(void)config:(MoneyDetailObject *)dic;

@end
