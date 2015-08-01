//
//  FaBuViewController.h
//  WeiLuYan
//
//  Created by weiluyan on 14/11/14.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

//@protocol FinshPushState <NSObject>
//
//-(void)finshPushState;
//
//@end

@interface PublishViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationBarDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>


@property(nonatomic,retain)UIButton *cameraInBtn;
@property(nonatomic,retain)UIButton *publishBtn;
@property(nonatomic,retain)NSString* filePath;
@property(nonatomic,retain)UIImage *iamdede;
@property(nonatomic,retain)UIButton*leftBton;
@property(nonatomic,retain)UIImageView *myima;
@property(nonatomic,retain)UIImageView *myimagetwo;
@property(nonatomic,retain)NSMutableArray *muarrr;
//@property(nonatomic, weak)id<FinshPushState>delegate;

@end
