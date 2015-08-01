//
//  NewPublishViewController.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/13.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessagePhotoView.h"
@protocol FinshPushState <NSObject>

-(void)finshPushState;

@end

@interface NewPublishViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationBarDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet MessagePhotoView *MessagePhotoView;
@property (weak, nonatomic) IBOutlet UIView *textBG;
@property(nonatomic,retain)NSString* filePath;
@property(nonatomic, weak)id<FinshPushState>delegate;
@property (nonatomic,assign) CGFloat previousTextViewContentHeight;

@end
