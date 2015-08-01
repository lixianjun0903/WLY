//
//  MainCell.m
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    

        
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)setMainCell:(NSDictionary *)dicc
{
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,5, 200, 25)];
    self.nameLabel = nameLabel;
    nameLabel.backgroundColor=[UIColor clearColor];
    self.nameLabel.text = [dicc objectForKey:@"text"];
    [self.contentView addSubview:self.nameLabel];
    
    UILabel *postLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 200, 10)];
    self.positionLabel = postLable;
    self.positionLabel.textColor=[UIColor grayColor];
    self.positionLabel.font=[UIFont systemFontOfSize:12];
    self.positionLabel.text = [dicc objectForKey:@"day"];
    postLable.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:self.positionLabel];
    
    //        _btnJiantou=[[UIButton   buttonWithType:UIButtonTypeCustom]init];;
    //        _btnJiantou.frame=CGRectMake(270, 10, 20, 20);
    //        [_btnJiantou  setImage:[UIImage imageNamed:@"arrow_R"]];
    //        [self addSubview:_btnJiantou];
    _btnJiantou=[UIButtonIndexPath  buttonWithType:UIButtonTypeCustom];
    _btnJiantou.tag=1001;
    [_btnJiantou  setImage:[UIImage imageNamed:@"arrow_R"] forState:UIControlStateNormal];
    _btnJiantou.frame=CGRectMake(270, 10, 20, 20);
    [self  addSubview:_btnJiantou];

}

@end
