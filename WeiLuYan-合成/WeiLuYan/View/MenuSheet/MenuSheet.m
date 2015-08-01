//
//  LXActionSheet.m
//  LXActionSheetDemo
//
//  Created by lixiang on 14-3-10.
//  Copyright (c) 2014年 lcolco. All rights reserved.
//

#import "MenuSheet.h"
#import "MBProgressHUD.h"
#import "UserInfoRequest.h"
#import "UIButton+WebCache.h"
#import "WEditViewController.h"
#import "AppDelegate.h"

#define CANCEL_BUTTON_COLOR                     [UIColor colorWithRed:53/255.00f green:53/255.00f blue:53/255.00f alpha:1]
#define DESTRUCTIVE_BUTTON_COLOR                [UIColor colorWithRed:185/255.00f green:45/255.00f blue:39/255.00f alpha:1]
#define OTHER_BUTTON_COLOR                      [UIColor whiteColor]
#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:106/255.00f green:106/255.00f blue:106/255.00f alpha:0.8]
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define CORNER_RADIUS                           5

#define BUTTON_INTERVAL_HEIGHT                  20
#define BUTTON_HEIGHT                           40
#define BUTTON_INTERVAL_WIDTH                   30
#define BUTTON_WIDTH                            260
#define BUTTONTITLE_FONT                        [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]
#define BUTTON_BORDER_WIDTH                     0.5f
#define BUTTON_BORDER_COLOR                     [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor


#define TITLE_INTERVAL_HEIGHT                   15
#define TITLE_HEIGHT                            35
#define TITLE_INTERVAL_WIDTH                    30
#define TITLE_WIDTH                             260
#define TITLE_FONT                              [UIFont fontWithName:@"Helvetica-Bold" size:14]
#define SHADOW_OFFSET                           CGSizeMake(0, 0.8f)
#define TITLE_NUMBER_LINES                      2

#define ANIMATE_DURATION                        0.25f

@interface MenuSheet ()
@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) NSString *actionTitle;
@property (nonatomic,assign) NSInteger postionIndexNumber;
@property (nonatomic,assign) BOOL isHadTitle;
@property (nonatomic,assign) BOOL isHadDestructionButton;
@property (nonatomic,assign) BOOL isHadOtherButton;
@property (nonatomic,assign) BOOL isHadCancelButton;
@property (nonatomic,assign) CGFloat LXActionSheetHeight;

@property (nonatomic,assign) UIViewController * vc;
@property (nonatomic,assign) UIButton * imageButton;
@property (nonatomic,assign) BOOL isID;

@end

@implementation MenuSheet

#pragma mark - Public method

- (id)initWithController:(UIViewController *)vc targetImage:(UIButton *)imageButton isID:(BOOL)flag;
{
    self = [super init];
    if (self) {
    
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        
        NSArray * array = @[@"拍照",@"相册"];
        [self creatButtonsWithTitle:nil cancelButtonTitle:@"取消" destructionButtonTitle:nil otherButtonTitles:array];
        
        self.vc = vc;
        self.imageButton = imageButton;
        self.isID = flag;
    }
    return self;
}

- (void)show
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

#pragma mark - CreatButtonAndTitle method

- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructionButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray
{
    //初始化
    self.isHadTitle = NO;
    self.isHadDestructionButton = NO;
    self.isHadOtherButton = NO;
    self.isHadCancelButton = NO;

    //初始化LXACtionView的高度为0
    self.LXActionSheetHeight = 0;

    //初始化IndexNumber为0;
    self.postionIndexNumber = 0;
    
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backGroundView.backgroundColor = ACTIONSHEET_BACKGROUNDCOLOR;
    
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backGroundView];
    
    if (title) {
        self.isHadTitle = YES;
        UILabel *titleLabel = [self creatTitleLabelWith:title];
        self.LXActionSheetHeight = self.LXActionSheetHeight + 2*TITLE_INTERVAL_HEIGHT+TITLE_HEIGHT;
        [self.backGroundView addSubview:titleLabel];
    }

    if (destructiveButtonTitle) {
        self.isHadDestructionButton = YES;
        
        UIButton *destructiveButton = [self creatDestructiveButtonWith:destructiveButtonTitle];
        destructiveButton.tag = self.postionIndexNumber;
        [destructiveButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.isHadTitle == YES) {
            //当有title时
            [destructiveButton setFrame:CGRectMake(destructiveButton.frame.origin.x, self.LXActionSheetHeight, destructiveButton.frame.size.width, destructiveButton.frame.size.height)];
            
            if (otherButtonTitlesArray && otherButtonTitlesArray.count > 0) {
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+BUTTON_INTERVAL_HEIGHT/2;
            }
            else{
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
            }
        }
        else{
            //当无title时
            if (otherButtonTitlesArray && otherButtonTitlesArray.count > 0) {
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT+(BUTTON_INTERVAL_HEIGHT/2));
            }
            else{
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
            }
        }
        [self.backGroundView addSubview:destructiveButton];
        
        self.postionIndexNumber++;
    }
    
    if (otherButtonTitlesArray) {
        if (otherButtonTitlesArray.count > 0) {
            self.isHadOtherButton = YES;
  
            //当无title与destructionButton时
            if (self.isHadTitle == NO && self.isHadDestructionButton == NO) {
                for (int i = 0; i<otherButtonTitlesArray.count; i++) {
                    UIButton *otherButton = [self creatOtherButtonWith:[otherButtonTitlesArray objectAtIndex:i] withPostion:i];
                    
                    otherButton.tag = self.postionIndexNumber;
                    [otherButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
                    
                    if (i != otherButtonTitlesArray.count - 1) {
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT/2);
                    }
                    else{
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
                    }
                    
                    [self.backGroundView addSubview:otherButton];
                
                    self.postionIndexNumber++;
                }
            }
            
            //当有title或destructionButton时
            if (self.isHadTitle == YES || self.isHadDestructionButton == YES) {
                for (int i = 0; i<otherButtonTitlesArray.count; i++) {
                    UIButton *otherButton = [self creatOtherButtonWith:[otherButtonTitlesArray objectAtIndex:i] withPostion:i];
            
                    otherButton.tag = self.postionIndexNumber;
                    [otherButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
                    [otherButton setFrame:CGRectMake(otherButton.frame.origin.x, self.LXActionSheetHeight, otherButton.frame.size.width, otherButton.frame.size.height)];
                    
                    if (i != otherButtonTitlesArray.count - 1) {
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT/2);
                    }
                    else{
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT);
                    }
                    
                    [self.backGroundView addSubview:otherButton];
                    
                    self.postionIndexNumber++;
                }
            }
        }
    }
    
    if (cancelButtonTitle) {
        self.isHadCancelButton = YES;
        
        UIButton *cancelButton = [self creatCancelButtonWith:cancelButtonTitle];
        
        cancelButton.tag = self.postionIndexNumber;
        [cancelButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        
        //当没title destructionButton otherbuttons时
        if (self.isHadTitle == NO && self.isHadDestructionButton == NO && self.isHadOtherButton == NO) {
             self.LXActionSheetHeight = self.LXActionSheetHeight + cancelButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
        }
        
        //当有title或destructionButton或otherbuttons时
        if (self.isHadTitle == YES || self.isHadDestructionButton == YES || self.isHadOtherButton == YES) {
            [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, self.LXActionSheetHeight, cancelButton.frame.size.width, cancelButton.frame.size.height)];
            self.LXActionSheetHeight = self.LXActionSheetHeight + cancelButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
        }
        
        [self.backGroundView addSubview:cancelButton];
        
        self.postionIndexNumber++;
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.LXActionSheetHeight, [UIScreen mainScreen].bounds.size.width, self.LXActionSheetHeight)];
    } completion:^(BOOL finished) {
    }];
}

- (UILabel *)creatTitleLabelWith:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_INTERVAL_WIDTH, TITLE_INTERVAL_HEIGHT, TITLE_WIDTH, TITLE_HEIGHT)];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.shadowColor = [UIColor blackColor];
    titlelabel.shadowOffset = SHADOW_OFFSET;
    titlelabel.font = TITLE_FONT;
    titlelabel.text = title;
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.numberOfLines = TITLE_NUMBER_LINES;
    return titlelabel;
}

- (UIButton *)creatDestructiveButtonWith:(NSString *)destructiveButtonTitle
{
    UIButton *destructiveButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
    destructiveButton.layer.masksToBounds = YES;
    destructiveButton.layer.cornerRadius = CORNER_RADIUS;
    
    destructiveButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    destructiveButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    destructiveButton.backgroundColor = DESTRUCTIVE_BUTTON_COLOR;
    [destructiveButton setTitle:destructiveButtonTitle forState:UIControlStateNormal];
    destructiveButton.titleLabel.font = BUTTONTITLE_FONT;
    
    [destructiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [destructiveButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return destructiveButton;
}

- (UIButton *)creatOtherButtonWith:(NSString *)otherButtonTitle withPostion:(NSInteger )postionIndex
{
    UIButton *otherButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT + (postionIndex*(BUTTON_HEIGHT+(BUTTON_INTERVAL_HEIGHT/2))), BUTTON_WIDTH, BUTTON_HEIGHT)];
    otherButton.layer.masksToBounds = YES;
    otherButton.layer.cornerRadius = CORNER_RADIUS;
    
    otherButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    otherButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    otherButton.backgroundColor = OTHER_BUTTON_COLOR;
    [otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
    otherButton.titleLabel.font = BUTTONTITLE_FONT;
    [otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [otherButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return otherButton;
}

- (UIButton *)creatCancelButtonWith:(NSString *)cancelButtonTitle
{
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = CORNER_RADIUS;
    
    cancelButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    cancelButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    cancelButton.backgroundColor = CANCEL_BUTTON_COLOR;
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = BUTTONTITLE_FONT;
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return cancelButton;
}

- (void)clickOnButtonWith:(UIButton *)button
{
    if(button.tag == 0){
        NSLog(@"相机");
        [self takePhoto];
        [self certain];
    }
    else if(button.tag == 1){
        NSLog(@"相册");
        [self LocalPhoto];
        [self certain];
    }else
    {
        [self tappedCancel];
    }
    
}

#pragma mark 拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = sourceType;
        
        [self.navButn removeFromSuperview];

        [AppDelegate instance].MainBar.NaveBar.hidden = YES;
        
        [AppDelegate instance].MainBar.BarBtn.hidden = YES;
        
        [self.vc presentViewController:picker animated:YES completion:nil];
        
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

#pragma mark 访问本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    [self.vc presentViewController:picker animated:YES completion:nil];

    [AppDelegate instance].MainBar.NaveBar.hidden = YES;
    [AppDelegate instance].MainBar.BarBtn.hidden = YES;
}

-(void)createRightItem:(NSString *)text with:(UIViewController*)picker
{
    UIButton * _butn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _butn.frame = CGRectMake(260, 20, 40, 40);
    
    [_butn addTarget:self action:@selector(disMissPick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_butn setTitle:text forState:UIControlStateNormal];
    
    [_butn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [picker.view addSubview:_butn];
    
//    [[AppDelegate instance].MainBar.NaveBar addSubview:_butn];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
     self.dimissBlock();
    [picker dismissViewControllerAnimated:YES completion:nil];
}



-(void)dealloc
{
    
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage * newImage = [GeneralizedProcessor imageWithImage:image scaledToSize:CGSizeMake(200, 200)];
        //NSData * imageData = UIImageJPEGRepresentation(newImage, 0.1);\
        //NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:imageData,@"img", nil];
        
        [AppDelegate instance].MainBar.NaveBar.hidden = NO;
        [AppDelegate instance].MainBar.BarBtn.hidden = NO;
        [picker dismissViewControllerAnimated:YES completion:nil];
        if(self.isID){
            self.finishBlock(newImage);
            return;
        }
        MBProgressHUD * mbHud = [[MBProgressHUD alloc]initWithView:self.vc.view];
        [self.vc.view addSubview:mbHud];
        mbHud.dimBackground = YES;
        [mbHud show:YES];
        [UserInfoRequest uploadImage:^(NSString * backUrl)  {
            [self.imageButton sd_setImageWithURL:[NSURL URLWithString:backUrl] forState:UIControlStateNormal];
            //[self.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:backUrl] forState:UIControlStateNormal];
                AccountModel * model = [AccountModel instance];
                PersonalInfoModel * per_model = model.personInfoModel;
                per_model.avatar = backUrl;
            
            [mbHud removeFromSuperview];
            
            
        } :newImage fail:^(int errCode, NSError *err) {
            [mbHud removeFromSuperview];
            
            
        } isID:self.isID];
    }
    
}

- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.cancelBlock();
            [self removeFromSuperview];
        }
    }];
}

-(void)certain
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            
            [self removeFromSuperview];
        }
    }];
}



- (void)tappedBackGroundView
{
    //
}

@end
