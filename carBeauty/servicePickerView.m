//
//  servicePickerView.m
//  carBeauty
//
//  Created by apple7 on 17/4/20.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "servicePickerView.h"
#import <Chameleon.h>
#import <UIView+SDAutoLayout.h>
#import <Foundation/Foundation.h>

@interface servicePickerView() <UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) UILabel *serviceL;
@property(nonatomic, strong) UIPickerView *serPicker;
@property(nonatomic, strong) UIButton *finishAppion;

@property(nonatomic, strong) NSArray *serviceTitle;
@property(nonatomic, strong) NSDictionary *serviceDic;

@property(nonatomic, assign) NSInteger proIndex;
@end

@implementation servicePickerView

- (instancetype)init {
    
    if (self = [super init]) {
        [self createDate];
        [self layoutServicePickerSubviews];
    }
    return self;
}

- (void)createDate {
    
    self.serviceTitle = @[@"常规美容",@"特色美容",@"常规保养",@"特色高级保养",@"免拆维护"];
    
    self.serviceDic = @{@"常规美容":@[@"360°全能手工精洗",@"金牌全车精洗",@"铂朗漆面镀膜",@"真皮镀膜",@"内室深度清洁",@"内室桑拿消毒",@"轮胎轮毂专业清洁"],
                        @"特色美容":@[@"45分钟智能车漆快修",@"全车特效喷漆",@"隔热防爆太阳膜",@"美国",@"比利时进口专业车身贴膜"],
                        @"常规保养":@[@"换机油",@"防冻液",@"换三滤（机滤、汽滤、空滤）",@"雨刮",@"变速器止漏",@"清洗刹车片",@"空调检测及加氟",@"检查电瓶液配比",@"电瓶维护",@"火花塞保养",@"全车皮带维护"],
                        @"特色高级保养":@[@"电脑检测及解码",@"发电机维护",@"发动机维护",@"尾气达标",@"专业底盘检测"],
                        @"免拆维护":@[@"润滑系统免拆清洗",@"冷却系统免拆清洗",@"冷却系统除垢处理",@"发动机免拆清洗",@"变速箱免拆清洗",@"转向系统免拆清洗"]};
    
//    self.serviceTitle = @[@"00",@"11",@"22",@"33",@"44"];
//    
//    self.serviceDic = @{@"00":@[@"000",@"001",@"002",@"003",@"004",@"005",@"006"],
//                        @"11":@[@"110",@"111",@"112",@"113",@"114"],
//                        @"22":@[@"220",@"221",@"222",@"223",@"224",@"225",@"226",@"227",@"228",@"229"],
//                        @"33":@[@"330",@"331",@"332",@"333",@"334"],
//                        @"44":@[@"440",@"441",@"442",@"443",@"444",@"445"]};
}

- (void)layoutServicePickerSubviews {
    UILabel *serviceL = [[UILabel alloc] init];
    self.serviceL = serviceL;
    serviceL.textAlignment = NSTextAlignmentCenter;
    serviceL.textColor = [UIColor colorWithHexString:@"666"];
    serviceL.font = [UIFont systemFontOfSize:16];
    
    UIPickerView *serPicker = [[UIPickerView alloc] init];
    self.serPicker = serPicker;
    serPicker.delegate = self;
    serPicker.dataSource = self;
    
    UIButton *finishAppion = [[UIButton alloc] init];
    self.finishAppion = finishAppion;
    [finishAppion setTitle:@"预约" forState:UIControlStateNormal];
    [finishAppion setTitleColor:[UIColor colorWithHexString:@"fff"] forState:UIControlStateNormal];
    [finishAppion setTintColor:[UIColor colorWithHexString:@"0081f1"]];
    finishAppion.backgroundColor = [UIColor colorWithHexString:@"0081f1"];
    [finishAppion addTarget:self action:@selector(finishAppionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self sd_addSubviews:@[serviceL, serPicker, finishAppion]];
//    [self addSubview:serviceL];
//    [self addSubview:serPicker];
//    [self addSubview:finishAppion];
    
    serviceL.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .heightIs(44);
    
    serPicker.sd_layout
    .topSpaceToView(serviceL,10)
    .leftEqualToView(serviceL)
    .rightEqualToView(serviceL)
    .heightIs(90);
    
    finishAppion.sd_layout
    .bottomSpaceToView(self, 0)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .heightIs(44);
}

- (void)finishAppionBtnClick {
    //点击预约完成
    if (self.servicePickerFinishBtnEventBlock) {
        self.servicePickerFinishBtnEventBlock();
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSString *key = self.serviceTitle[_proIndex];
    NSArray *oneArr = [self.serviceDic objectForKey:key];
    switch (component) {
        case 0:
            return self.serviceTitle.count;
            break;
        case 1:
            return oneArr.count;
            //jiaru
            break;
        default:
            return 0;
            break;
    }
    
//    NSString *key = self.serviceTitle[component];
//    NSArray *oneArr = [self.serviceDic objectForKey:key];
//    return oneArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    static NSInteger col1Row = 0;
    static NSInteger col2Row = 0;
    
    if (component == 0) {
        col1Row = row;
        return self.serviceTitle[row];
    } else if (component == 1){
        col2Row = row;
        NSString *key = self.serviceTitle[col1Row];
        NSArray *oneArr = [self.serviceDic objectForKey:key];
        return oneArr[col2Row];
    } else {
        return @"";
    }
    
    
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    static NSInteger col1Row = 0;
    static NSInteger col2Row = 1;
    
    if (component == 0) {
        col1Row = row;
    } else {
        col2Row = row;
    }
    
    NSString *key = self.serviceTitle[col1Row];
    NSArray *oneArr = [self.serviceDic objectForKey:key];
    self.serviceL.text = oneArr[col2Row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view  {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:12]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

@end
