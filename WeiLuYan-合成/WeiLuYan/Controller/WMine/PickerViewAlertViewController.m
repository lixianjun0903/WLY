//
//  PickerViewAlertViewController.m
//  WeiLuYan
//
//  Created by 张亮 on 14/11/8.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "PickerViewAlertViewController.h"
#import "UIButtonIndexPath.h"
#import "TagObject.h"
#import "AppDelegate.h"
@interface PickerViewAlertViewController ()
{
    int selectedNum;

}
@property( nonatomic, strong)NSMutableArray*selectTagArray;

@property (nonatomic, strong) NSMutableArray * tempSelectTagArray;
@property (nonatomic , strong) NSArray * dataArray;
@property (nonatomic,assign) BOOL flag;
@end

@implementation PickerViewAlertViewController

static PickerViewAlertViewController * manager = nil;

+(id)shareManagerWithTarArr:(NSArray * )getPickerViewArr withSelectArr:(NSMutableArray *)selectTagArr
{
    NSNumber * flag = [[NSUserDefaults standardUserDefaults] objectForKey:@"FLAG"];
    if (flag == nil || manager == nil) {
        manager = [[PickerViewAlertViewController alloc]initWithHeight:350 WithSheetTitle:@"期限" withTagArr:getPickerViewArr withSelectArr:selectTagArr];
        flag = [NSNumber numberWithInt:1];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setValue:flag forKey:@"FLAG"];
        [user synchronize];
        return manager;
    }
    
    return manager;
    
}

- (void)createBtnTest
{
    for (int i=0; i<[_pickerViewArray count]; i++) {
        
        TagObject * obj = _pickerViewArray[i];
        
        UIButtonIndexPath *btntest=[UIButtonIndexPath buttonWithType:UIButtonTypeRoundedRect];
        
        [btntest setFrame:CGRectMake(0, 40+44*i, 272, 44)];
        btntest.center = CGPointMake(self.view.frame.size.width/2 - 10, 50+44*i );
        
        [btntest setTitle:obj.name forState:UIControlStateNormal];
        [btntest setValue_id:obj.impress_tag_id];
        [btntest setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [btntest addTarget:self action:@selector(selecTag:) forControlEvents:UIControlEventTouchUpInside];
        [btntest setTag:9000+i];
        
        for (NSString *num in self.selectNumArr) {
            NSLog(@"num = %d",[num intValue]);
            
            if (i == [num intValue] - 1) {
                btntest.isSelected = YES;
            }
        }
        [self.view addSubview:btntest];
        
    }
}

-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title withTagArr:(NSArray*)getPickerViewArary withSelectArr:(NSMutableArray *)selectTagArr;
{
    self = [super init];
    self.dataArray = selectTagArr;
    selectedNum = (int)selectTagArr.count;

    
    if (self)
    {

        self.selectNumArr = [NSMutableArray arrayWithArray:selectTagArr];
        self.tempSelectTagArray =[NSMutableArray arrayWithArray:selectTagArr];
        
        _selectTagArray=[NSMutableArray array];
        
        int theight = height - 40;
        int btnnum = theight/50;
        for(int i=0; i<btnnum; i++)
        {
           UIAlertAction *action = [UIAlertAction actionWithTitle:@"" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [self addAction:action];
        }
        
        UIView  *view= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-16, height)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:view];
        
        //实例化
        _pickerViewArray=[NSMutableArray arrayWithArray:getPickerViewArary];

        
        [self createBtnTest];

        
        UIButton *btnCancel=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnCancel setFrame:CGRectMake(10, 4, 76, 35)];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [btnCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

        [btnCancel setBackgroundImage:[UIImage imageNamed:@"c_select_time_btn.png"] forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(OnCancel) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnCancel];
        
        UIButton *btnOK=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnOK setFrame:CGRectMake(220, 4, 76, 35)];
        [btnOK setTitle:@"确定" forState:UIControlStateNormal];
        [btnOK setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnOK setBackgroundImage:[UIImage imageNamed:@"c_select_time_btn.png"] forState:UIControlStateNormal];
        [btnOK addTarget:self action:@selector(OnOK) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnOK];
        
    }
    return self;
}
-(void)selecTag:(UIButtonIndexPath*)selectBton
{

    if (selectBton.selected) {
        selectBton.selected = NO;
        selectedNum--;
    }
    else
    {
        if (selectedNum == 3) {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"最多只能选择三个标签" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            
            [alert show];
            
            return;
        }
        selectBton.selected = YES;
        selectedNum++;
    }
    
    
    selectBton.isSelected=!selectBton.isSelected;
}

-(void) OnOK
{
  
    self.selectNumArr = nil;
    self.selectNumArr = [NSMutableArray arrayWithCapacity:0];
    self.selectTagArray = nil;
    self.selectTagArray = [NSMutableArray arrayWithCapacity:0];
    
    for (int i=0; i<[_pickerViewArray count]; i++)
    {
        UIButtonIndexPath*selectBton=(UIButtonIndexPath*)[self.view viewWithTag:9000+i];
        if (selectBton.isSelected==YES) {
            
            [_selectNumArr addObject:[NSString stringWithFormat:@"%d",i+1]];
            
            [_selectTagArray addObject:[NSNumber numberWithInt:selectBton.value_id]];
        }
    }
    
    [_delegate getAllSelectTagID:_selectTagArray];
    self.cancelBlock();
    self.flag = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(void) OnCancel
{
    for (UIView * view in self.view.subviews) {
        if ([view isKindOfClass:[UIButtonIndexPath class]]) {
            [view removeFromSuperview];
        }
    }
    if(self.flag){
        selectedNum = (int)self.selectTagArray.count;
    }
    else{
        selectedNum = (int)self.dataArray.count;
    }
    self.cancelBlock();
    [self createBtnTest];
    [self dismissViewControllerAnimated:YES completion:nil];
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
