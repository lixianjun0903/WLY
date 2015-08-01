//
//  AttestationViewController.m
//  WeiLuYan
//
//  Created by weiluyan on 14/10/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AttestationViewController.h"
#import "MenuSheet.h"
#import "GeneralizedProcessor.h"


@interface AttestationViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) MenuSheet *actionSheet;
@property(nonatomic,retain)    NSString* filePath;
@end

@implementation AttestationViewController
-(void)TIjiao{

    [_textview resignFirstResponder];

}
-(void)fanhui
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setNavarBar
{
//    self.navigationController.navigationBarHidden=YES;
//
//    
//    [self.navigationController.navigationBar setBarTintColor:[GeneralizedProcessor hexStringToColor:colorRead]];
//    
//    UIButton*leftBton = [[UIButton alloc]initWithFrame:CGRectMake(10,0,40,40)];
//    [leftBton setImage:[UIImage imageNamed:@"Arrow"]forState:UIControlStateNormal];
//    [leftBton addTarget:self action:@selector(fanhui)forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBton];
//    self.navigationItem.leftBarButtonItem= leftItem;
//    
//    
//    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
//    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    t.font = [UIFont systemFontOfSize:18];
//    t.textColor = [UIColor whiteColor];
//    t.backgroundColor = [UIColor clearColor];
//    t.textAlignment = UITextAlignmentCenter;
//    t.text = @"实名认证";
//    t.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:20];
//
//    UIButton*nextButton = [[UIButton alloc]initWithFrame:CGRectMake(250,5,50,30)];
//        [nextButton addTarget:self action:@selector(TIjiao) forControlEvents:UIControlEventTouchUpInside];
////        nextButton.frame=CGRectMake(250,5, 50, 30);
//        nextButton.backgroundColor=[GeneralizedProcessor hexStringToColor:colorRead];
//        [nextButton setTintColor:[UIColor whiteColor]];
//        nextButton.layer.masksToBounds = YES;
//        nextButton.layer.cornerRadius = 4.0;
//        nextButton.layer.borderWidth = 1.0;
//        nextButton.layer.borderColor = [[UIColor whiteColor] CGColor];
//        [nextButton setTitle:@"提交" forState:UIControlStateNormal];
//        nextButton.titleLabel.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:14];
//    [leftBton addTarget:self action:@selector(fanhui)forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:nextButton];
//    self.navigationItem.rightBarButtonItem= rightItem;

    
    
    
    
    UIView *naview=[[UIView alloc]initWithFrame:CGRectMake(0,0, 320, 64)];
    naview.backgroundColor=[GeneralizedProcessor hexStringToColor:colorRead];
    [self.view addSubview:naview];
    
    UIButton*leftBton = [[UIButton alloc]initWithFrame:CGRectMake(10,20,50,40)];
    [leftBton setImage:[UIImage imageNamed:@"Arrow"]forState:UIControlStateNormal];
    [leftBton addTarget:self action:@selector(fanhui)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBton];
    [naview addSubview:leftBton];

    
    
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    t.font = [UIFont systemFontOfSize:20];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    t.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:20];
    t.text = @"实名认证";
    [naview addSubview:t];
    
             UIButton*nextButton = [[UIButton alloc]initWithFrame:CGRectMake(250,25,50,30)];
            [nextButton addTarget:self action:@selector(TIjiao) forControlEvents:UIControlEventTouchUpInside];
    //        nextButton.frame=CGRectMake(250,5, 50, 30);
            nextButton.backgroundColor=[GeneralizedProcessor hexStringToColor:colorRead];
            [nextButton setTintColor:[UIColor whiteColor]];
            nextButton.layer.masksToBounds = YES;
            nextButton.layer.cornerRadius = 4.0;
            nextButton.layer.borderWidth = 1.0;
            nextButton.layer.borderColor = [[UIColor whiteColor] CGColor];
            [nextButton setTitle:@"提交" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(addID:) forControlEvents:UIControlEventTouchUpInside];
            nextButton.titleLabel.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:14];
           [naview addSubview:nextButton];


}

-(void)addID:(id)sender
{
    NSLog(@"dsdsadd");
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_userimg.image,@"img",_textview.text,@"remark", nil];
//    [uploadImageRequest uploadImage:^(NSDictionary *userDic) {
//        
//            if ([userDic objectForKey:@"error_code"]==0)
//            {
//                NSLog(@"上传成功！");
//                
//            }else{
//                NSLog(@"上传失败！");
//            }
//            
//            
//        }:dic];
}
-(void)viewWillAppear:(BOOL)animated{
    [self setNavarBar];
    [self.tabBarController.tabBar setHidden:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
        [self.tabBarController.tabBar setHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#eeeae7"];

    _Mytabview=[[UITableView alloc]initWithFrame:CGRectMake(0,10, 320, 560) style:UITableViewStyleGrouped];
    _Mytabview.tag=100;
    _Mytabview.delegate=self;
    _Mytabview.backgroundColor=[UIColor clearColor];
    _Mytabview.dataSource=self;
    [self.view addSubview:_Mytabview];

    
    
    
    // Do any additional setup after loading the view.
}
-(void)PHOT{


    
//    self.actionSheet = [[LXActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"相册"]];
//    [self.actionSheet showInView:self.view];

    
    

}
#pragma MARK TAB-----
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
        return 2;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        return 50;

    }else{
    
    
        return 180;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSString *CellIdentifier=@"cellid";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
    }
    if (indexPath.section==0    ) {
        cell.textLabel.text=@"上传身份证";
        UIButton*nextButton=[UIButton  buttonWithType:UIButtonTypeCustom];
        [nextButton addTarget:self action:@selector(PHOT) forControlEvents:UIControlEventTouchUpInside];
        nextButton.frame=CGRectMake(120, 5, 40, 40);
        [nextButton setImage:[UIImage imageNamed:@"verification_camera"] forState:UIControlStateNormal];
        [cell addSubview:nextButton];
        _userimg=[[UIImageView alloc]initWithFrame:CGRectMake(120, 5, 60, 40)];
        [cell addSubview:_userimg];
        
    }else
    {
    
        _textview=[[UITextView alloc] initWithFrame:CGRectMake(0,0, 320, 180)]; //初始化大小并自动释放
        _textview.textColor = [UIColor blackColor];//设置textview里面的字体颜色
        _textview.font = [UIFont fontWithName:@"Arial"size:18.0];//设置字体名字和字体大小
        _textview.delegate = self;//设置它的委托方法
        _textview.font=[UIFont systemFontOfSize:16];
        _textview.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
        _textview.returnKeyType = UIReturnKeyDefault;//返回键的类型
        _textview.tintColor = [UIColor redColor];
        _textview.keyboardType = UIReturnKeySend;//键盘类型
    
        _textview.scrollEnabled = YES;//是否可以拖动
        [cell addSubview:_textview];
        _textLa=[[UILabel alloc]initWithFrame:CGRectMake(240, 170, 100, 40)];
        _textLa.text=@"0/140";
        [cell addSubview:_textLa];
      
        _uilabel=[[UILabel alloc]init];
        _uilabel.frame =CGRectMake(10,5, 200, 40);
        _uilabel.text = @"请输入个人简介...";
        _uilabel.font = [UIFont fontWithName:@"Arial"size:14];//设置字体名字和字体大小
        _uilabel.enabled = NO;//lable必须设置为不可用
        _uilabel.backgroundColor = [UIColor clearColor];
        [cell addSubview:_uilabel];
    
    
    }
    
    
    
    return cell;
    
}
#pragma mark tex====


-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _uilabel.text = @"请填写审批意见...";
    }else{
        _uilabel.text = @"";
    }
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{


    [_textview resignFirstResponder];

    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textview resignFirstResponder];
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    

    NSInteger NSInteger =   [_textview.text length];
    NSString  *str=                [NSString stringWithFormat: @"%ld/140", (long)NSInteger];
    _textLa.text=str;
    
    
    if (   [_textview.text length]>=140) {
        _textLa.textColor=[UIColor redColor];
        NSString  *str=                [NSString stringWithFormat: @"-%ld/140", (long)NSInteger];
        _textLa.text=str;
    }if ( [_textview.text length]<=140) {
        _textLa.textColor=[UIColor blackColor];
        NSString  *str= [NSString stringWithFormat: @"%ld/140", (long)NSInteger];
        _textLa.text=str;
        
    }
    
    return YES;
    
}
#pragma mark - LXActionSheetDelegate

- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex
{
    NSLog(@"%d",(int)buttonIndex);
    if ((int)buttonIndex==1)
    {
        [self LocalPhoto];

    }else if (buttonIndex==0)
    {
    
        [self takePhoto];
    
    }
}
#pragma mark---- 相机和相册
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        //[self presentModalViewController:picker animated:YES];
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    //[self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:YES completion:nil];

}
//当选择一张图片后进入这里
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
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果

//        UIImageView *smallimage = [[UIImageView alloc] initWithFrame:
//                                    CGRectMake(50, 120, 40, 40)];
        
        _userimg.image = image;
        //加在视图中
//        [self.view addSubview:smallimage];
        

        //加在视图中
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)selectPic:(UIImage*)image

{
    
    NSLog(@"image%@",image);
    
  UIImageView*  imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    [self.view addSubview:imageView];
    
    
    
   // [self performSelectorInBackground:@selector(detect:) withObject:nil];
    
}

-(void)imagePickerControllerDIdCancel:(UIImagePickerController*)picker

{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}




//////////
- (void)didClickOnDestructiveButton
{
    NSLog(@"destructuctive");
}

- (void)didClickOnCancelButton
{
    NSLog(@"cancelButton");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
