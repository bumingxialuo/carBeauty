//
//  LookAppointmentViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/19.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "LookAppointmentViewController.h"

@interface LookAppointmentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong) NSArray *dateArr;
@property(nonatomic,strong) NSDictionary *appoDic;

@end

@implementation LookAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dateArr = @[@"6-1",@"6-2",@"6-3",@"6-4",@"6-6",@"6-8",@"6-10",@"6-12",@"6-13",@"6-18"];
    self.appoDic = @{@"6-1":@[@"车主预约常规美容服务",@"车主预约常规美容服务"],
                     @"6-2":@[@"车主预约常规美容服务",@"车主预约常规美容服务",@"车主预约常规美容服务",@"车主预约常规美容服务",@"车主预约常规美容服务",@"车主预约常规美容服务"],
                     @"6-3":@[@"车主预约常规美容服务",@"车主预约全车皮带维护",@"车主预约免拆维护",@"车主预约常规美容服务"],
                     @"6-4":@[@"车主预约特色美容服务",@"车主预约换机油服务"],
                     @"6-6":@[@"车主预约特色美容服务",@"车主预约换机油服务"],
                     @"6-8":@[@"车主预约特色美容服务",@"车主预约换机油服务"],
                     @"6-10":@[@"车主预约特色美容服务",@"车主预约换机油服务"],
                     @"6-12":@[@"车主预约常规美容服务",@"车主预约常规美容服务",@"车主预约常规美容服务",@"车主预约常规美容服务"],
                     @"6-13":@[@"车主预约常规美容服务",@"车主预约常规美容服务",@"特色高级保养",@"车主预约常规美容服务"],
                     @"6-18":@[@"车主预约常规美容服务"]};
    self.title = @"商家预约详情";
    [self layoutLookSubviews];
}

- (void)layoutLookSubviews {
    UITableView *lookTableview = [[UITableView alloc] init];
    lookTableview.delegate = self;
    lookTableview.dataSource = self;
    
    [self.view addSubview:lookTableview];
    
    lookTableview.frame = self.view.bounds;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dateArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [self.dateArr objectAtIndex:section];
    return [[self.appoDic objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *key = [self.dateArr objectAtIndex:section];
    NSArray *appoint = [self.appoDic objectForKey:key];
    static NSString *appiontCell = @"appiontCell";
    UITableViewCell *appCell = [tableView dequeueReusableCellWithIdentifier:appiontCell];
    if (appCell == nil) {
        appCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appiontCell];
    }
    appCell.textLabel.text = [appoint objectAtIndex:row];
    appCell.textLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    appCell.textLabel.font = [UIFont systemFontOfSize:16];
    return  appCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dateArr objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.dateArr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
