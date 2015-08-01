//
//  ZBShareMenuView.m
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-13.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//
#import "MessagePhotoView.h"
#import "ZYQAssetPickerController.h"
#import "AppDelegate.h"

//#define kZBMessageShareMenuPerRowItemCount 4
#define kZBMessageShareMenuPerColum 2

#define kZBShareMenuItemIconSize 60
#define KZBShareMenuItemHeight 80

#define MaxItemCount 10
#define ItemWidth 80
#define ItemHeight 80

@interface MessagePhotoView ()
{
    UIButton *btnphoto;
    UIImageView *_bigImageView;
    UIView *_contentView;
}

@property(nonatomic,strong) UIScrollView * photoScrollView;
@property (nonatomic, weak) UIScrollView * shareMenuScrollView;
@property (nonatomic, weak) UIPageControl * shareMenuPageControl;
@property(nonatomic,weak) UIButton * btnviewphoto;
@end

@implementation MessagePhotoView
@synthesize photoMenuItems;
alloc_with_xib(MessagePhoto)
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{
    UIButton *button = (UIButton *)[self viewWithTag:1];
    [button addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    [self setup];
    _contentView.hidden = YES;
}

- (void)setup{
    _contentView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:_contentView];

    _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 180)];
    _bigImageView.contentMode = UIViewContentModeScaleToFill;
    _photoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 185, CGRectGetWidth(self.frame), 60)];

    _photoScrollView.showsHorizontalScrollIndicator = NO;
    _photoScrollView.showsVerticalScrollIndicator = NO;

    photoMenuItems = [[NSMutableArray alloc]init];
    _itemArray = [[NSMutableArray alloc]init];
    [_contentView addSubview:_bigImageView];
    [_contentView addSubview:_photoScrollView];
    btnphoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnphoto addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.photoScrollView addSubview:btnphoto];
    
    [self initlizerScrollView:self.photoMenuItems];

}

-(void)reloadDataWithImage:(UIImage *)image{
    [self.photoMenuItems addObject:image];
    
    [self initlizerScrollView:self.photoMenuItems];
}

-(void)removeItemView{
    for (MessagePhotoMenuItem * photoItem in _itemArray) {
        [photoItem removeFromSuperview];
    }
    [_itemArray removeAllObjects];
}

-(void)initlizerScrollView:(NSArray *)imgList{
     _photoScrollView.contentSize = CGSizeMake(10+ (imgList.count+1) * (ItemWidth + 5 ), 0);
    if (imgList.count == 0) {
        _contentView.hidden = YES;
    }else{
        _contentView.hidden = NO;
    }
    
    for(int i=0;i<imgList.count;i++){
        
        ALAsset *asset=imgList[i];
        UIImage *tempImg;
        @try {
            tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        }
        @catch (NSException *exception) {
            tempImg = imgList[i];
        }
        @finally {
            
        }
       
        MessagePhotoMenuItem * photoItem = [[MessagePhotoMenuItem alloc]initWithFrame:CGRectMake(10+ i * (ItemWidth + 5 ), 0, ItemWidth, ItemHeight)];
        photoItem.delegate = self;
        photoItem.index = i;
        photoItem.contentImage = tempImg;
        photoItem.image = tempImg;
        [self.photoScrollView addSubview:photoItem];
        [self.itemArray addObject:photoItem];
        
        if (i == imgList.count-1) {
            _bigImageView.image = tempImg;
        }
    }
    
    if(imgList.count<MaxItemCount){
        [btnphoto setFrame:CGRectMake(20 + (ItemWidth + 5) * imgList.count, 0, 60, 60)];//
        [btnphoto setImage:[UIImage imageNamed:@"btn_addimage.png"] forState:UIControlStateNormal];
        [btnphoto setImage:[UIImage imageNamed:@"btn_addimage.png"] forState:UIControlStateSelected];
        [btnphoto addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
        [self.photoScrollView addSubview:btnphoto];
    }

}

-(void)openMenu{
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles:@"打开照相机",@"从手机相册获取", nil];
    [myActionSheet showInView:self.window];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == myActionSheet.cancelButtonIndex){
        NSLog(@"取消");
    }
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self localPhoto];
            break;
        default:
            break;
    }
}

//开始拍照
-(void)takePhoto{
    [AppDelegate instance].MainBar.NaveBar.hidden = YES;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self.delegate addUIImagePicker:picker];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开相册，可以多选
-(void)localPhoto{
    [AppDelegate instance].MainBar.NaveBar.hidden = YES;
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc]init];
    picker.maximumNumberOfSelection = 10;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,NSDictionary *bindings){
        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
            return duration >= 5;
        }else{
            return  YES;
        }
    }];
    
    [self.delegate addPicker:picker];
}

/*
 得到选中的图片
 */
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
        NSLog(@"assets is %lu",(unsigned long)assets.count);
    [self.photoMenuItems addObjectsFromArray:[NSMutableArray arrayWithArray:assets]];
    [self initlizerScrollView:self.photoMenuItems];
    [picker dismissViewControllerAnimated:YES completion:nil];
 }

//相机选择某张照片之后
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if([type isEqualToString:@"public.image"]){
        //先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self reloadDataWithImage:image];
        
        image =  [GeneralizedProcessor imageWithImage:image scaledToSize:CGSizeMake(200, 200)];
        NSData *datas;
        if(UIImagePNGRepresentation(image)==nil){
            datas = UIImageJPEGRepresentation(image, 1.0);
        }else{
            datas = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //把刚才图片转换的data对象拷贝至沙盒中,并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:datas attributes:nil];
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,@"/image.png"];
        
        //创建一个选择后图片的图片放在scrollview中
        
        //加载scrollview中
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)assetPickerController:(ZYQAssetPickerController *)picker didSelectAsset:(ALAsset*)asset{
     //NSLog(@"您取消了选择图片");
}

-(void)assetPickerController:(ZYQAssetPickerController *)picker didDeselectAsset:(ALAsset*)asset{
     //NSLog(@"您取消了选择图片");
}
- (void)reloadData {
    
}
- (void)dealloc {
    //self.shareMenuItems = nil;
    self.photoScrollView.delegate = self;
    self.shareMenuScrollView.delegate = self;
    self.shareMenuScrollView = nil;
    self.shareMenuPageControl = nil;
}

#pragma mark - MessagePhotoItemDelegate
-(void)messagePhotoItemView:(MessagePhotoMenuItem *)messagePhotoItemView didSelectDeleteButtonAtIndex:(NSInteger)index{
    [self.photoMenuItems removeObjectAtIndex:index];
    [self removeItemView];
    [self initlizerScrollView:self.photoMenuItems];
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    //根据当前的坐标与页宽计算当前页码
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    [self.shareMenuPageControl setCurrentPage:currentPage];
}

@end
