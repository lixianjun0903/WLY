//
//  AttestationViewController.h
//  WeiLuYan
//
//  Created by weiluyan on 14/10/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuSheet.h"


@interface AttestationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>

@property(nonatomic,strong)UITableView *Mytabview;
@property(nonatomic,retain)UIImageView *img_p;
@property(nonatomic,retain)UITextView * textview;
@property(nonatomic,retain)UILabel *textLa;
@property(nonatomic,retain)UILabel *uilabel;

@property(nonatomic,retain)UIImageView *userimg;

@end
