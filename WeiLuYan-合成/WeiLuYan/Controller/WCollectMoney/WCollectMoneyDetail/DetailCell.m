//
//  TableViewCell1.m
//  UIAlertController
//
//  Created by dev on 14/12/30.
//  Copyright (c) 2014年 dev. All rights reserved.
//

#import "DetailCell.h"
#import "UIImageView+WebCache.h"

@implementation DetailCell

- (void)awakeFromNib {
    
    [_userIcon.layer setCornerRadius:CGRectGetHeight([_userIcon bounds]) / 2 + 1];
    [_userIcon.layer setMasksToBounds:YES];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)config:(Team *)dic
{
    
//   _comeFromLab.text = [NSString stringWithFormat:@"来自于：%@",dic.real_name];
    _midLab.text = dic.nick_name;
    
//    if (dic[@"named_name"] != NULL) {
//        _midLab.text = dic[@"named_name"];
//    }
    
    NSString * url = dic.avatar;
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
}

@end
