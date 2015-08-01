//
//  AddPictureView.h
//  WeiLuYan
//
//  Created by 张亮 on 14-10-15.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LineAndPlacherTextView;
@class UIButtonIndexPath;
@interface AddPictureView : UIView
@property( nonatomic, strong) UIButtonIndexPath*addBton;
@property( nonatomic, strong) UILabel*addLable;
@property( nonatomic, strong) UIImageView*addPicture;
@property( nonatomic, strong) UILabel*placherText;
@property( nonatomic, strong) LineAndPlacherTextView*lineAndPlacherTextView;
@property( nonatomic, strong) UIImageView*addPictureImageView;

-(id)initWithFrame:(CGRect)frame andBtonAddText:(NSString*)btonText :(NSString*)placherText;
-(void)addPicture:(UIImage*)image;
@end
