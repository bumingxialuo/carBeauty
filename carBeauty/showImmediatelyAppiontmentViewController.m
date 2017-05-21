//
//  showImmediatelyAppiontmentViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/19.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "showImmediatelyAppiontmentViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WQCalendarLogic.h"
#import "WQDraggableCalendarView.h"
#import "WQScrollCalendarWrapperView.h"
#import <UIView+SDAutoLayout.h>
#import "servicePickerView.h"

@interface showImmediatelyAppiontmentViewController ()<UIPickerViewDelegate, UIPickerViewDataSource, WQScrollCalendarWrapperViewDelegate>

@property (nonatomic, strong) UILabel *monthLabel;

@property (nonatomic, strong) WQDraggableCalendarView *calendarView;
@property (nonatomic, strong) WQCalendarLogic *calendarLogic;

@property (nonatomic, strong) WQScrollCalendarWrapperView *scrollCalendarView;

@property (nonatomic, strong) servicePickerView *servicePickerView;

@end

@implementation showImmediatelyAppiontmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"立即预约";
    
    self.calendarLogic = [[WQCalendarLogic alloc] init];
    
    [self showCalendar];
    
    [self layoutImmedSubviews];

}

- (servicePickerView *)servicePickerView {
    if (_servicePickerView == nil) {
        _servicePickerView = [[servicePickerView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        
        _servicePickerView.servicePickerFinishBtnEventBlock = ^(){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"预约成功" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        };
    }
    return _servicePickerView;
}

- (void)layoutImmedSubviews {
    UIButton *preBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    preBtn.frame = (CGRect){25, 15, 60, 44};
    [preBtn addTarget:self action:@selector(goToPreviousMonth:) forControlEvents:UIControlEventTouchUpInside];
    [preBtn setTitle:@"上一月" forState:UIControlStateNormal];
    [self.view addSubview:preBtn];
    preBtn.sd_layout
    .leftSpaceToView(self.view,20);
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextBtn.frame = (CGRect){235, 15, 60, 44};
    [nextBtn addTarget:self action:@selector(goToNextMonth:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitle:@"下一月" forState:UIControlStateNormal];
    nextBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:nextBtn];
    nextBtn.sd_layout
    .rightSpaceToView(self.view,20)
    .widthIs(60);
    
    CGRect labelRect = (CGRect){110, 15, 100, 44};
    self.monthLabel = [[UILabel alloc] initWithFrame:labelRect];
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    self.monthLabel.text = [NSString stringWithFormat:@"%lu年%lu月", (unsigned long)self.calendarLogic.selectedCalendarDay.year, (unsigned long)self.calendarLogic.selectedCalendarDay.month];
    self.monthLabel.textColor = [UIColor blackColor];
    [self.view addSubview:self.monthLabel];
    self.monthLabel.sd_layout
    .centerXEqualToView(self.view);
    
    [self.view addSubview:self.servicePickerView];
    
    self.servicePickerView.backgroundColor = [UIColor whiteColor];
    self.servicePickerView.sd_layout
    .topSpaceToView(self.view,352)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
}

- (void)showCalendar
{
    CGRect calendarRect = self.view.bounds;
    calendarRect.origin.y += 52, calendarRect.size.height -= 52;
    self.calendarView = [[WQDraggableCalendarView alloc] initWithFrame:calendarRect];
    self.calendarView.draggble = NO;
    [self.view addSubview:self.calendarView];
    self.calendarView.backgroundColor = [UIColor whiteColor];
    [self.calendarLogic reloadCalendarView:self.calendarView];
    
    self.calendarView.sd_layout
    .heightIs(300);
    
//    CGRect scrollRect = self.view.bounds;
//    scrollRect.origin.y = 400;
//    scrollRect.size.height = 40;
//    self.scrollCalendarView = [[WQScrollCalendarWrapperView alloc] initWithFrame:scrollRect];
//    self.scrollCalendarView.backgroundColor = [UIColor greenColor];
//    self.scrollCalendarView.delegate = self;
//    [self.view addSubview:self.scrollCalendarView];
//    [self.scrollCalendarView reloadData];
}

#pragma mark -

- (void)goToNextMonth:(id)sender
{
    [self.calendarLogic goToNextMonthInCalendarView:self.calendarView];
    self.monthLabel.text = [NSString stringWithFormat:@"%lu年%lu月", (unsigned long)self.calendarLogic.selectedCalendarDay.year, (unsigned long)self.calendarLogic.selectedCalendarDay.month];
    
    if (sender != nil) {
        [self.scrollCalendarView moveToDate:[self.calendarLogic.selectedCalendarDay date]];
    }
}

- (void)goToPreviousMonth:(id)sender
{
    [self.calendarLogic goToPreviousMonthInCalendarView:self.calendarView];
    self.monthLabel.text = [NSString stringWithFormat:@"%lu年%lu月", (unsigned long)self.calendarLogic.selectedCalendarDay.year, (unsigned long)self.calendarLogic.selectedCalendarDay.month];
    
    if (sender != nil) {
        [self.scrollCalendarView moveToDate:[self.calendarLogic.selectedCalendarDay date]];
    }
}

#pragma mark - WQScrollCalendarWrapperViewDelegate

- (void)monthDidChangeFrom:(NSInteger)fromMonth to:(NSInteger)toMonth
{
    if (fromMonth == 12 && toMonth == 1) {
        [self goToNextMonth:nil];
    } else if (toMonth < fromMonth || (fromMonth == 1 && toMonth == 12)) {
        [self goToPreviousMonth:nil];
    } else {
        [self goToNextMonth:nil];
    }
}

- (void)calendarViewDidScroll
{
    ;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = nil;
    
    switch (component) {
        case 0:
            title = [NSString stringWithFormat:@"%ld 时", (long)row];
            break;
            
        case 1:
            title = [NSString stringWithFormat:@"%ld 分", (long)row];
            break;
            
        default:
            break;
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    ;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // http://stackoverflow.com/questions/214441/how-do-you-make-an-uipickerview-component-wrap-around
    
    NSInteger rows = 0;
    
    switch (component) {
        case 0:
            rows = 24;
            break;
            
        case 1:
            rows = 60;
            break;
            
        default:
            break;
    }
    
    return rows;
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
