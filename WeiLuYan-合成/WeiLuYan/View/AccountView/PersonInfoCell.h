//
//  ListTableViewCellModel.h
//  WeiLuYan
//
//  Created by 张亮 on 14-10-13.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextViewForLength.h"
#import "UIViewkeyAndTextField.h"
#import "AddPictureView.h"
#import "AddMediaView.h"
#import "MyProjectLogoView.h"
#import "UserInfoObject.h"
@interface PersonInfoCell : UITableViewCell

@property( nonatomic, strong)UIPlaceHolderTextViewForLength*textView;
@property( nonatomic, strong)UIViewkeyAndTextField*viewkeyAndTextField;
@property( nonatomic, strong)AddPictureView*addPictureView;
@property( nonatomic, strong)AddMediaView*addMediaView;
@property( nonatomic, strong)MyProjectLogoView*myProjectLogoView;

@property (nonatomic,strong) NSArray * jobStateArray;
@property (nonatomic,strong) NSArray * jobArray;
@property (nonatomic,strong) NSArray * tagInfoArray;
@property (strong,nonatomic)void(^reLoadBlock)(NSMutableArray *,NSMutableArray *);

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView model:(UserInfoObject *)model controller:(UIViewController *)vc tagInfoArray:(NSArray *)tagArray jobArray:(NSArray *)jobArray;

-(void)addKeyAndTextFieldValue:(NSString*)key;
-(void)addKeyAndTextFieldValue:(NSString*)key :(NSString*)textFieldValue indexPath:(int)index;

-(void)addKey:(NSString*)key andBtonValue:(NSString*)value;

-(void)addKeyAndCenterTextFieldValue:(NSString*)key;

-(void)addCellTextview:(NSInteger)maxLength :(NSString*)placherText;

-(void)addPicture:(NSString*)addBtonText :(NSString*)placherText;

-(void)addMedia:(NSString*)addBtonText;

-(void)addNews:(NSString*)newsText :(NSString*)dateStr;

-(void)addProjectLogoView:(NSString*)addLogoText;
@end
