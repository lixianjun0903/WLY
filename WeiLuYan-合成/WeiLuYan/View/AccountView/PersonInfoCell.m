//
//  ListTableViewCellModel.m
//  WeiLuYan
//
//  Created by 张亮 on 14-10-13.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "PersonInfoCell.h"
#import "UIViewkeyAndTextField.h"
#import "UIPlaceHolderTextView.h"
#import "PickerViewAlertViewController.h"
#import "UserInfoRequest.h"
#import "JobStateObject.h"
#import "OfficeObject.h"
#import "TagObject.h"
#import "AppDelegate.h"
#import "WEditViewController.h"

#define CELL_LEFT_LINE 14
#define CELL_TOP_LINE 12

@interface PersonInfoCell()<BtonDelgate>

@property (nonatomic,strong) NSArray * arrayUser;
@property (nonatomic,strong) NSArray * userArrayTwo;
@property (nonatomic,strong) UserInfoObject * model;
@property (nonatomic,assign) WEditViewController * vc;

@end

@implementation PersonInfoCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView model:(UserInfoObject *)model controller:(UIViewController *)vc tagInfoArray:(NSArray *)tagArray jobArray:(NSArray *)jobArray
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self.viewkeyAndTextField removeFromSuperview];
        self.tagInfoArray = tagArray;
        self.jobArray = jobArray;
        self.model = model;
        self.vc = vc;
        self.arrayUser = [NSArray arrayWithObjects:@"昵称",@"真实姓名",@"性别",@"所在地",@"职位",@"手机号",@"邮箱", nil];
        self.userArrayTwo = [NSArray arrayWithObjects:@"状态",@"标签",@"实名认证", nil];

        if (indexPath.section==0)
        {
            if (indexPath.row==0) {
                //昵称
                [self addKeyAndTextFieldValue: [self.arrayUser objectAtIndex:indexPath.row] :self.model.nick_name indexPath:(int)indexPath.row];
            }
            if (indexPath.row==1) {
                //姓名
                [self addKeyAndTextFieldValue: [self.arrayUser objectAtIndex:indexPath.row] :self.model.user_name indexPath:(int)indexPath.row];
            } if (indexPath.row==2) {
                NSString*sex=nil;
                if (self.model.sex==0)
                {
                    sex=@"保密";
                }else if (self.model.sex==1){
                    sex=@"男";
                }else{
                    sex=@"女";
                }
                //性别
                [ self addKey: [self.arrayUser objectAtIndex:indexPath.row] andBtonValue: sex];
                [self.viewkeyAndTextField.valueButton addTarget:self action:@selector(choice:) forControlEvents:UIControlEventTouchUpInside];
                [self.viewkeyAndTextField.valueButton setIndexPath:indexPath];
                [self.viewkeyAndTextField.valueButton setTag:4000+indexPath.row];
            } if (indexPath.row==3) {
                //所在地
                [self addKeyAndTextFieldValue: [self.arrayUser objectAtIndex:indexPath.row] :model.address indexPath:(int)indexPath.row];
            } if (indexPath.row==4)
            {
                //职位
                JobStateObject * job = self.jobArray[self.model.office];
                NSString * str = job.name;
                [ self addKey:[self.arrayUser objectAtIndex:indexPath.row] andBtonValue:str];
                
                
                [self.viewkeyAndTextField.valueButton addTarget:self action:@selector(choice:) forControlEvents:UIControlEventTouchUpInside];
                [self.viewkeyAndTextField.valueButton setIndexPath:indexPath];
                [self.viewkeyAndTextField.valueButton setTag:4000+indexPath.row];
            } if (indexPath.row==5) {
                //手机号
                [self addKeyAndTextFieldValue: [self.arrayUser objectAtIndex:indexPath.row] :self.model.phone indexPath:(int)indexPath.row];
                
            } if (indexPath.row==6) {
                //邮箱
                [self addKeyAndTextFieldValue: [self.arrayUser objectAtIndex:indexPath.row] :self.model.email indexPath:(int)indexPath.row];
            }
            
        }else
        {
            
            if (indexPath.row==2)
            {
//                if (model.card_status==0) {
//                    //实名认证
//                    [ self addKey:[self.userArrayTwo objectAtIndex:indexPath.row] andBtonValue:@"未认证"];
//                }else{
//                    [ self addKey:[self.userArrayTwo objectAtIndex:indexPath.row] andBtonValue:@"已认证"];
//                }
                
            }else if (indexPath.row==0)
            {
                //状态
                [ self addKey:[self.userArrayTwo objectAtIndex:indexPath.row] andBtonValue:model.job_status];
                [self.viewkeyAndTextField.valueButton setIndexPath:indexPath];
                [self.viewkeyAndTextField.valueButton addTarget:self action:@selector(choice:) forControlEvents:UIControlEventTouchUpInside];
                [self.viewkeyAndTextField.valueButton setTag:5000];
            }else if (indexPath.row==1)
            {
                //标签
                NSArray*readIDArray=[self readAllTagInfo:self.model.tag_arr];
                
                [self createTagsWithArray:(NSMutableArray *)readIDArray];
                
                [self addKey:[self.userArrayTwo objectAtIndex:indexPath.row] andBtonValue:nil];
                [self.viewkeyAndTextField.valueButton setIndexPath:indexPath];
                [self.viewkeyAndTextField.valueButton addTarget:self action:@selector(choice:) forControlEvents:UIControlEventTouchUpInside];
                [self.viewkeyAndTextField.valueButton setTag:5000+1];
            }
        }
   
        if (self.viewkeyAndTextField) {
            self.viewkeyAndTextField.block = ^(BOOL b,CGFloat height)
            {
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    if (b) {
                        
                        tableView.frame = CGRectMake(0, 116, tableView.superview.frame.size.width, tableView.superview.frame.size.height - 116 - height);
                    }
                    else
                    {
                        tableView.frame = CGRectMake(0, 116, tableView.superview.frame.size.width, tableView.superview.frame.size.height - 116);
                    }
                }];
            };
            
        }

    }
    return self;
}

-(void)choice:(UIButtonIndexPath*)sender
{
    //结束编辑
    [self.vc.view endEditing:YES];
    
    if (sender.tag==5000)
    {
        
        [self actionShow:_jobStateArray sender:sender tag:1];
        
    }else if (sender.tag==5001)
    {
        [self testPickerView];
    }else if (sender.tag==4004){
        
        [self actionShow:_jobArray sender:sender tag:2];
    }
    else if (sender.tag==4002){
        [self actionShow: [NSArray arrayWithObjects:   [NSDictionary dictionaryWithObjectsAndKeys:@"保密",@"name",[NSNumber numberWithInt:0],@"sex_id", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"男",@"name",[NSNumber numberWithInt:1],@"sex_id", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"女",@"name",[NSNumber numberWithInt:2],@"sex_id", nil], nil] sender:sender tag:3];
    }
}

-(void)actionShow:(NSArray*)array sender:(UIButtonIndexPath*)sender tag:(int)flag
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"请选择"
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i=0; i<[array count]+1; i++)
    {
        
        if (i==[array count])
        {
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"确定"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     self.vc.button.userInteractionEnabled = YES;
                                     [self.vc dismissViewControllerAnimated:YES completion:nil];
                                     [AppDelegate instance].MainBar.BarBtn.hidden = NO;
                                 }];
            [alert addAction:ok];
        }
        else
        {
            NSString * str;
            int num;
            if(flag == 1){
                JobStateObject * obj = array[i];
                str = obj.name;
                num = obj.job_status_id;
            }
            else if (flag == 2){
                OfficeObject * obj = array[i];
                str = obj.name;
                num = obj.named_id;
            }
            else{
                str = array[i][@"name"];
                num = [array[i][@"sex_id"] intValue];
            }
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:str
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     self.vc.button.userInteractionEnabled = YES;
                                     [self.viewkeyAndTextField.valueButton setTitle:str forState:UIControlStateNormal];
                                     self.viewkeyAndTextField.valueButton.value_id= num;
                                 }];
            [alert addAction:ok];
        }
    }
    self.vc.button.userInteractionEnabled = NO;
    [self.vc presentViewController:alert animated:YES completion:nil];
    [AppDelegate instance].MainBar.BarBtn.hidden = YES;
}

#pragma mark 上传标签
-(void)testPickerView
{
    PickerViewAlertViewController * sheet = [PickerViewAlertViewController shareManagerWithTarArr:_tagInfoArray withSelectArr:[self selectNum:self.model.tag_arr]];
    
        NSLog(@"选中的标签为：%@",sheet.selectNumArr);
    
    sheet.delegate = self;
    self.vc.button.userInteractionEnabled = NO;
    sheet.cancelBlock = ^
    {
        self.vc.button.userInteractionEnabled = YES;
    };
    [self.vc presentViewController:sheet animated:YES completion:nil];
    
    [AppDelegate instance].MainBar.BarBtn.hidden = YES;
    
}

//上传标签的代理函数
-(void)getAllSelectTagID:(NSMutableArray*)selectTagArray
{
    [UserInfoRequest editUserTagInfo:^(NSDictionary *userDic) {
        [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    } :selectTagArray];
    
    NSLog(@"这里的数组为：%@",selectTagArray);
    self.reLoadBlock((NSMutableArray *)self.tagInfoArray,selectTagArray);
    [self createTagsWithArray:selectTagArray];
    self.vc.button.userInteractionEnabled = YES;
}

-(NSMutableArray *)selectNum:(NSArray *)dataTagArr
{
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < dataTagArr.count; i ++) {
        TagObject * obj = dataTagArr[i];
        int num = obj.impress_tag_id;
        [marr addObject:[NSNumber numberWithInt:num]];
    }
    return marr;
}


#pragma mark 创建标签
-(void)createTagsWithArray:(NSMutableArray *)mutableArray
{
    
    for (id item in self.subviews){
        if ([item isKindOfClass:[UIButton class]] && [item tag] > 1000 ) {
            [item removeFromSuperview];
        }
        
    }
    
    NSArray*colorValueArray=[NSArray arrayWithObjects:@"#ca600f",@"#cac42a",@"#ca722a", nil];
    
    static int y = 120;
    
    for (int i = 0; i < mutableArray.count; i ++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.layer.cornerRadius = 7;
        btn.layer.masksToBounds = YES;
        
        btn.tag = 1001 + [mutableArray[i] intValue] - 1;
        
        btn.backgroundColor = [GeneralizedProcessor hexStringToColor:colorValueArray[i%3]];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        
        if(self.tagInfoArray.count != 0)
        {
            TagObject * tag = self.tagInfoArray[btn.tag - 1001];
            NSString * str = tag.name;
            [btn setTitle:str forState:UIControlStateNormal];
            
            
            btn.frame = CGRectMake(y, 10, 13 * str.length, 14);
            
            y += btn.frame.size.width + btn.frame.origin.y;
            
            [btn addTarget:self action:@selector(testPickerView) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:btn];
        }
            
        
       
       
        
    }
    
    y = 120;
    
}

-(NSArray*)readAllTagInfo:(NSArray*)readTagArray
{
    NSMutableArray *readIDArray=[NSMutableArray array];
    for (TagObject *dic in readTagArray) {
        [readIDArray addObject:[NSNumber numberWithInt:dic.impress_tag_id]];
    }
    return readIDArray;
}

-(NSString*)getTagInfoString:(int)tagID
{
    NSString*str=@"";
    for (TagObject *dic in _tagInfoArray) {
        
        if (dic.impress_tag_id == tagID) {
            str = dic.name;
            return  str;
        }
    }
    return str;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)addKeyAndTextFieldValue:(NSString*)key
{
    _viewkeyAndTextField=[[UIViewkeyAndTextField alloc]initWithFrame:self.bounds andTextFieldKey:key];
    [self addSubview:_viewkeyAndTextField];
}

-(void)addKeyAndTextFieldValue:(NSString*)key :(NSString*)textFieldValue indexPath:(int)index
{
    //0 1 3 5 6
    _viewkeyAndTextField=[[UIViewkeyAndTextField alloc]initWithFrame:self.bounds andTextFieldKey:key :textFieldValue indexPath:index];
    [self addSubview:_viewkeyAndTextField];
    if(index == 5)
    {
        _viewkeyAndTextField.valueTextField.enabled = NO;
    }
}


-(void)addKey:(NSString*)key andBtonValue:(NSString*)value
{
    //2 4 7 8 9
    _viewkeyAndTextField=[[UIViewkeyAndTextField alloc]initWithFrame:self.bounds andBtonKey:key :value];
    [self addSubview:_viewkeyAndTextField];
}

-(void)addKeyAndCenterTextFieldValue:(NSString*)key
{
    _viewkeyAndTextField=[[UIViewkeyAndTextField alloc]initWithFrame:self.bounds andCenterTextFieldKey:key];
    [self addSubview:_viewkeyAndTextField];
}

-(void)addCellTextview:(NSInteger)maxLength :(NSString*)placherText
{
    _textView=[[UIPlaceHolderTextViewForLength alloc]initWithFrame:self.bounds];
    _textView.returnKeyType=UIReturnKeyDone;
    [_textView setFont:[UIFont systemFontOfSize:14]];
    [_textView addShowTextLegnthView:maxLength :placherText];
    [self addSubview:_textView];
}

-(void)addPicture:(NSString*)addBtonText :(NSString*)placherText;
{
   _addPictureView=[[AddPictureView alloc]initWithFrame:self.bounds andBtonAddText:addBtonText :placherText];
    [self addSubview:_addPictureView];
}
-(void)addMedia:(NSString*)addBtonText
{
    _addMediaView=[[AddMediaView alloc]initWithFrame:self.bounds andBtonAddText:addBtonText];
    [self addSubview:_addMediaView];
}

-(void)addProjectLogoView:(NSString*)addLogoText
{
    _myProjectLogoView=[[MyProjectLogoView alloc]initWithFrame:self.bounds :addLogoText];
    [self addSubview:_myProjectLogoView];
}
-(void)addNews:(NSString*)newsText :(NSString*)dateStr
{
    
}
@end
