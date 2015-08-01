//
//  MyProjectTableViewController.m
//  WeiLuYan
//
//  Created by 张亮 on 14/10/27.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "MyProjectTableViewController.h"
#import "PersonInfoCell.h"
#import "UIButtonIndexPath.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
///

///
@interface MyProjectTableViewController ()
@property( nonatomic, strong)NSMutableArray*arrayHeight;
@property( nonatomic, strong)NSMutableArray* array;
@property( nonatomic, strong)NSData*fileData;

@end

@implementation MyProjectTableViewController
/////




////
- (void)viewDidLoad {
    [super viewDidLoad];
    
        _arrayHeight=[NSMutableArray arrayWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:60], nil], [NSNumber numberWithFloat:245],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],[NSNumber numberWithFloat:44],nil];
         _array=[NSMutableArray arrayWithObjects:[NSArray arrayWithObjects:@"项目名称",@"项目LOGO", nil],@"", [NSArray  arrayWithObjects:@"上传介绍视频",@"所属区域",@"团队介绍", @"项目阶段",@"上传路演视频",nil],    [NSArray  arrayWithObjects:@"添加过往融资",@"时间",@"投资机构/人",@"投资金额(万)",@"估值(万)",nil],@"保存", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    int rowCount=0;
    
    if (section==0) {
        rowCount=2;
    }else if (section==1)
    {
        rowCount=1;
    }else if (section==2)
    {
        rowCount=5;
    }
    else if (section==3)
    {
        rowCount=5;
    }else if (section==4)
    {
        rowCount=1;
    }
    return rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"Cell";
         PersonInfoCell *cell = (PersonInfoCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   [cell.viewkeyAndTextField removeFromSuperview];
    [cell.textView removeFromSuperview];
    [cell.addPictureView removeFromSuperview];
    [cell.addMediaView removeFromSuperview];
    [cell.myProjectLogoView removeFromSuperview];
    if (cell==nil)
    {
        cell=[[PersonInfoCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell setFrame:CGRectMake(0, 0, self.view.frame.size.width, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
    
    
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            [cell addKeyAndTextFieldValue:[[_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        }else
        {
            [cell addProjectLogoView:@"项目LOGO"];
        
        }
    }else if(indexPath.section==1)
    {
        [cell addCellTextview:140 :@"请输入项目介绍"];
    }else if (indexPath.section==2)
    {
        if (indexPath.row==0 ||indexPath.row==4)
        {
            [cell addMedia:[[_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
            [cell.addMediaView.addBton setIndexPath:indexPath];
            [cell.addMediaView.addBton addTarget:self action:@selector(addRaiseMoneyMedia:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }else
        {
            [cell addKeyAndTextFieldValue:[[_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        }
    }else if (indexPath.section==3)
    {
        if (indexPath.row==0)
        {
            [cell addMedia:[[_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        }else
        {
            [cell addKeyAndTextFieldValue:[[_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        }
    }else if (indexPath.section==4)
    {
        [cell addKeyAndCenterTextFieldValue:[_array objectAtIndex:indexPath.section]];
    }

    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0;
    
    if (indexPath.section==0)
    {
        height=[[[_arrayHeight objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] floatValue];
    }else
    {
        height=[[_arrayHeight objectAtIndex:indexPath.section] floatValue];
    
    }
    return height;
}
-(void)addRaiseMoneyMedia:(id)sender
{
    //UIButtonIndexPath*addBton=(UIButtonIndexPath*)sender;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                   imagePicker.delegate = self;
                     imagePicker.allowsEditing = YES;
                     imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSString *Type = [NSString stringWithFormat:@"%@",kUTTypeMovie];
                     imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: Type,nil];
        [self presentViewController:imagePicker animated:YES completion:nil];
    
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
 {
       if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeMovie])
       {
         NSString *videoPath = [[info objectForKey:UIImagePickerControllerMediaURL] absoluteString];
        self.fileData = [NSData dataWithContentsOfFile:videoPath];
           
        }
       [picker dismissViewControllerAnimated:YES completion:nil];
}


-(UIImage*)getMediaViewImage:(NSString*)filePath
{
    NSString *movpath =filePath;
    MPMoviePlayerViewController*  mpviemController =[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:movpath]];
    MPMoviePlayerController *mp=[mpviemController moviePlayer];
    UIImage *thumbImage=[mp thumbnailImageAtTime:2 timeOption:MPMovieTimeOptionNearestKeyFrame];
    return thumbImage;
}
 - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
 {
         [picker dismissViewControllerAnimated:YES completion:nil];
}
////////

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableView])
    {
        NSLog(@"aaa%@",[NSString stringWithFormat:@"Cell %ld in Section %ld is selected",(long)indexPath.row,(long)indexPath.section]);
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==4)
    {
     UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
    if ([tableView isEqual:self.tableView])
    {
        result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
        
    }
 return result;
    }
    return UITableViewCellEditingStyleNone;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //NSUInteger row = [indexPath section];
        [_array removeObjectAtIndex:indexPath.section];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]withRowAnimation:UITableViewRowAnimationLeft];
        [tableView deleteRowsAtIndexPaths:_array withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{

        return @"删除";
 
}

///////

@end
