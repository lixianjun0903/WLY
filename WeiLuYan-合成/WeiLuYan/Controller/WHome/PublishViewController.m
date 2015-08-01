//
//  FaBuViewController.m
//  WeiLuYan
//
//  Created by weiluyan on 14/11/14.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "PublishViewController.h"
#import  "UserInfoRequest.h"
#import  "MBProgressHUD+Show.h"
#import "TextLimitView.h"
#import "GeneralizedProcessor.h"
#import "AppDelegate.h"

@interface PublishViewController ()
{
    UIView * viewBG;
    TextLimitView * _textView;
    //导航按钮
    UIButton * _butn;
}
@end

@implementation PublishViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    [[AppDelegate instance] MainBar].BarBtn.hidden = NO;
    [_butn removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#eeeae7"];
    
    [self createView];
    
    //观察键盘出现 消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)createView
{
    //底层view
    viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT - 60)];
    viewBG.backgroundColor = [GeneralizedProcessor hexStringToColor:@"#eeeae7"];
    [self.view addSubview:viewBG];
    _textView = [[TextLimitView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 170)];
    _textView.LimitNumber = 140;
    
    [viewBG addSubview:_textView];
    
    
    _cameraInBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_cameraInBtn setFrame:CGRectMake(20, 170, 40, 40)];
    [_cameraInBtn setImage:[UIImage imageNamed:@"publish_camera"] forState: UIControlStateNormal];
    [_cameraInBtn addTarget:self action:@selector(cameraIn:) forControlEvents:UIControlEventTouchUpInside];
    [viewBG addSubview:_cameraInBtn];
    
    
    UIButton *photoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setFrame:CGRectMake(70, 170, 40, 40)];
    [photoBtn addTarget:self action:@selector(choosePhoto) forControlEvents:UIControlEventTouchUpInside];
    [photoBtn setImage:[UIImage imageNamed:@"publish_photo"] forState: UIControlStateNormal];
    [viewBG addSubview:photoBtn];
    
    self.myima=[[UIImageView alloc]initWithFrame:CGRectMake(120,170,40,40)];
    [viewBG  addSubview:self.myima];
    
    _publishBtn=[UIButton  buttonWithType:UIButtonTypeRoundedRect];
    [_publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    _publishBtn.frame=CGRectMake(10,210,290, 35);
    [_publishBtn setTintColor:[UIColor whiteColor]];
    _publishBtn.layer.cornerRadius = 4.0;
    _publishBtn.layer.masksToBounds = YES;
    _publishBtn.layer.borderWidth = 1.0;
    _publishBtn.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#ca2a2a"];
    _publishBtn.layer.borderColor = [[GeneralizedProcessor hexStringToColor:@"#eeeae7"] CGColor];
    [_publishBtn setTitle:@"发送" forState:UIControlStateNormal];
    _publishBtn.titleLabel.font=[UIFont fontWithName:@"CourierNewPS-ItalicMT" size:14];
    _publishBtn.tag=1111;
    [viewBG addSubview:_publishBtn];


}
#pragma mark - 键盘出现 消失
-(void)keyboardShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        viewBG.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    }];
}
-(void)keyboardHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        viewBG.frame = CGRectMake(0, 60, WIDTH, HEIGHT);
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textView.textView resignFirstResponder];
}

-(void)publishClick
{
    if ([_textView.textView.text isEqualToString:@""] ) {
       
        [MBProgressHUD creatembHub:@"请填写动态"];
        
    }else if(self.myima.image == nil)
    {
        [MBProgressHUD creatembHub:@"请选择一张图片"];
    }else
    {
        MBProgressHUD * mbHud = [MBProgressHUD mbHubShow];
         
        NSDictionary *dic=[NSDictionary dictionaryWithObject:_textView.textView.text forKey:@"text"];
        NSArray *arr=[NSArray arrayWithObjects:dic, nil];
        NSMutableArray *muarr=[NSMutableArray arrayWithObjects:[GeneralizedProcessor imageWithImage:self.myima.image scaledToSize:CGSizeMake(640, 640)], nil];
        NSDictionary *mydicc=[NSDictionary dictionaryWithObjectsAndKeys:arr,@"feed_params",muarr,@"feedcontent_pic", nil];
            

            [UserInfoRequest publish:^(NSNumber * number)

             {
                 [mbHud removeFromSuperview];
                 [MBProgressHUD creatembHub:@"发布成功"];

                 //页面跳转
                 [self.navigationController popToRootViewControllerAnimated:YES];
    
                
            } :@"feed/publish" :mydicc fail:^(int errCode, NSError *err) {

                
            }];
    }
}



#pragma mark - 选择图图片
-(void)choosePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [[AppDelegate instance] MainBar].BarBtn.hidden = YES;

        [self presentViewController:picker animated:YES completion:nil];
        
    }else
    {
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"" message:@"只能在真机中使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}
-(void)cameraIn:(UIButton *)sender
{
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    
    picker.delegate = self;
    
    picker.allowsEditing=YES;
    
    picker.sourceType=sourceType;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    _butn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _butn.frame = CGRectMake(260, 20, 40, 40);
    
    [_butn addTarget:self action:@selector(disMissPick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_butn setTitle:@"取消" forState:UIControlStateNormal];
    
    [_butn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [picker.view addSubview:butn];
    
    [[AppDelegate instance].MainBar.NaveBar addSubview:_butn];
    
    [[AppDelegate instance] MainBar].BarBtn.hidden = YES;
    
    	
    
}

-(void)disMissPick:(UIButton *)sender
{
    
    [sender removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark - 当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        //得到选择后沙盒中图片的完整路径
        _filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        self.myima.image=image;
        [picker dismissViewControllerAnimated:YES completion:^{
            AppDelegate * app = [AppDelegate instance];
//            app.mainBtn.hidden = NO;
        }];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:^{
        AppDelegate * app = [AppDelegate instance];
//        app.mainBtn.hidden = NO;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
