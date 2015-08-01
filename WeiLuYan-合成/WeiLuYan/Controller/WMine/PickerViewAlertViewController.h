//
//  PickerViewAlertViewController.h
//  WeiLuYan
//
//  Created by 张亮 on 14/11/8.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BtonDelgate <NSObject>

-(void)setSelectValue:(UIButton*)sender;
-(void)getAllSelectTagID:(NSMutableArray*)selectTagArray;
@end

@interface PickerViewAlertViewController : UIAlertController


@property (nonatomic, strong) UIPickerView *myPickerView;
@property (nonatomic, strong) NSArray *pickerViewArray;
@property( nonatomic, weak)id<BtonDelgate>delegate;
@property (nonatomic,strong) void(^cancelBlock)();


//接收已选标签

@property (nonatomic,strong)NSMutableArray * selectNumArr;



+(id)shareManagerWithTarArr:(NSArray * )getPickerViewArr withSelectArr:(NSMutableArray *)selectTagArr;
-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title withTagArr:(NSArray*)getPickerViewArary withSelectArr:(NSMutableArray *)selectTagArr;
@end
