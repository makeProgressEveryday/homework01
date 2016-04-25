//
//  ViewController.m
//  homework01
//
//  Created by 刘春牢 on 16/4/25.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

// 显示数据的label
@property (nonatomic, weak) IBOutlet UILabel *label;


// 日期选择控件
@property (nonatomic, strong) UIPickerView *pickerView;

// 工具条
@property (nonatomic, strong) UIToolbar *toolbar;

@property (nonatomic, strong) UITextField *txtField;

@property (nonatomic, strong) NSArray *foodsArr;

@end

@implementation ViewController

/**
 
 1>  在界面上有一个"Label"；
 点击Label时，弹出一个"键盘"；
 键盘内显示的数据是水果、主食、酒水，"键盘顶部"有"取消"和"确定"按钮；
 当用户点击"取消"时，键盘隐藏，点击"确定"时，将用户选择的食物显示到Label上，如"榴莲-水煮肉片-果蔬汁"。
 
 */

- (void)viewDidLoad {

    [super viewDidLoad];

}


- (IBAction)btnClick:(id)sender {

    // 通过文本框调出键盘
    [self.label addSubview:self.txtField];
    [self.txtField becomeFirstResponder];
    
}

#pragma mark - 取消，确认按钮的点击事件
- (void)cancelItemClick {
    
    [self.view endEditing:YES];
}

- (void)confirmItemClick {
    
   
    
}


#pragma mark - 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return self.foodsArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return [self.foodsArr[component] count];
}

#pragma mark - 代理方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.foodsArr[component][row];

}


#pragma mark - 懒加载

- (NSArray *)foodsArr {

    if (_foodsArr == nil) {
        _foodsArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01foods.plist" ofType:nil]];
    }
    return _foodsArr;
}

- (UITextField *)txtField {

    if (_txtField == nil) {
        
        _txtField = [[UITextField alloc] init];
        
        _txtField.inputView = self.pickerView;
        _txtField.inputAccessoryView = self.toolbar;
    }
    return _txtField;

}

- (UIPickerView *)pickerView {

    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        
        // MARK: - 设置数据源代理对象
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
    
}


- (UIToolbar *)toolbar {
    if (!_toolbar) {
        
        // 创建工具条
        _toolbar = [[UIToolbar alloc] init];
        // 设置高度就可以了，剩下的系统会自动处理
        _toolbar.frame = CGRectMake(0, 0, 0, 44);
        
        // 添加工具条里面的按钮
        // 取消
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemClick)];
        
        // 弹簧
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        // 确认
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(confirmItemClick)];
        
        // 将这三个按钮添加到工具条内
        _toolbar.items = @[cancelItem, flexSpace, confirmItem];
        
        
    }
    return _toolbar;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
