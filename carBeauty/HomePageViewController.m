//
//  HomePageViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/7.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "HomePageViewController.h"
#import "HEEPositioningViewController.h"
#import "HomeSearchBtnViewController.h"
#import "HEEPositioningViewController.h"
#import <Chameleon.h>

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface HomePageViewController ()
@property(nonatomic, strong) UIView *headView;
@property(nonatomic, strong) UITableView *msgView;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *cityString = [KCURRENTCITYINFODEFAULTS objectForKey:@"resultTEXT"];
    NSLog(@"导航栏 %@",cityString);
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [leftButton addTarget:self action:@selector(pushToPositionViewC) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:cityString forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithHexString:@"0081f1"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)pushToPositionViewC {
    HEEPositioningViewController *positionVC = [[HEEPositioningViewController alloc] init];
    [self.navigationController pushViewController:positionVC animated:YES];
}

- (IBAction)positioningBarBtnClick:(id)sender {
    NSLog(@"点击了 首页 定位按钮");
    HEEPositioningViewController *positioningView = [[HEEPositioningViewController alloc] init];
    [self.navigationController pushViewController:positioningView animated:YES];
    
}
- (IBAction)searchBtnClick:(id)sender {
    NSLog(@"点击了 首页 搜索按钮");
    HomeSearchBtnViewController *homeSearchVC = [[HomeSearchBtnViewController alloc] init];
    [self.navigationController pushViewController:homeSearchVC animated:YES];
}

- (void)layoutHomeSubview {
    
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
