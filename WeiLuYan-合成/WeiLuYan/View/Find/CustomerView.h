//
//  CustomerView.h
//  SM_Adv_system
//
//  Created by UC on 14-3-17.
//  Copyright (c) 2014年 UC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIButtonIndexPath;
@interface CustomerView : UIView
@property( nonatomic, assign) int shortLineCount;
@property( nonatomic, strong) UIView* untilOne;
@property( nonatomic, strong) UIView* untilTwo;
@property( nonatomic, strong) UIView* untilThree;
@property( nonatomic, strong) UIButtonIndexPath*goodBton;
@property( nonatomic, strong) UIButtonIndexPath*commentBton;
@property( nonatomic, strong) UIButtonIndexPath*shareButon;
@property( nonatomic, strong) UIButtonIndexPath*emogLikeBton;
@property( nonatomic, strong) UILabel*commentLable;
@property( nonatomic, strong) UILabel*likeCountLale;
- (id)initWithFrame:(CGRect)frame :(int)shortLineCount;

-(void)setUntiViewOneValue:(CGRect)viewFrame :(UIImage*)normalImage :(UIImage*)selectImage;

-(void)setUntiViewTwoValue:(CGRect)viewFrame :(CGRect)lableFrame :(UIImage*)normalImage :(NSString*)commentText;

-(void)setUntiViewThreeValue:(CGRect)shareViewFrame :(UIImage*)shareNormalImage :(CGRect)viewFrame :(CGRect)lableFrame :(UIImage*)normalImage :(NSString*)text;
@end
