//
//  AttachedCell.m
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//

#import "AttachedCell.h"

@implementation AttachedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 200, 30)];
//        la.text=@"大大声大声的大大大大达到撒";
//        [self addSubview:la ];
        
        
        
 

        
        
    }
    return self;
}
-(void)setcell:(NSDictionary *)dicCell
{

    UILabel *instructions = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 260, 180)];
    
    NSString *text =[dicCell  objectForKey:@"text"];
    instructions.text = text;
    instructions.textColor=[UIColor blackColor];
    instructions.lineBreakMode = NSLineBreakByCharWrapping; //这个是关键
    instructions.numberOfLines = 0;  //这个是关键
    
    [instructions setTextColor:[UIColor grayColor]];
    CGSize maximumSize = CGSizeMake(300, CGFLOAT_MAX); // 第一个参数是label的宽度，第二个参数是固定的宏定义，CGFLOAT_MAX
    CGSize expectedLabelSize = [instructions.text sizeWithFont:instructions.font
                                             constrainedToSize:maximumSize
                                                 lineBreakMode:NSLineBreakByCharWrapping];
    
    CGRect newFrame = instructions.frame;
    newFrame.size.height = expectedLabelSize.height;
    instructions.frame = newFrame;
    [instructions sizeToFit];
    [self addSubview:instructions];
    
    
    
    
    
    UIButton*nextButton=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [nextButton addTarget:self action:@selector(TJIAO) forControlEvents:UIControlEventTouchUpInside];
    nextButton.frame=CGRectMake(40, expectedLabelSize.height+10, 60, 30);
    [nextButton setTintColor:[UIColor whiteColor]];
    nextButton.layer.masksToBounds = YES;
    nextButton.layer.cornerRadius = 4.0;
    nextButton.layer.borderWidth = 1.0;
    nextButton.backgroundColor=[GeneralizedProcessor hexStringToColor:colorRead];
    nextButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [nextButton setTitle:@"马上完善" forState:UIControlStateNormal];
    nextButton.titleLabel.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:12];
    [self.contentView addSubview:nextButton];
   
    
    

}
-(void)TJIAO
{

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
