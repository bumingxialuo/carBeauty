//
//  HEEPositioningViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/10.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "HEEPositioningViewController.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"
#import <Chameleon.h>
#import <UIView+SDAutoLayout.h>

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface HEEPositioningViewController ()<JFLocationDelegate>

/** 选择的结果*/
@property (strong, nonatomic)  UILabel *resultLabel;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

@property(nonatomic, strong) UILabel *cityNameL;

@property(nonatomic, strong) UIButton *manuallyLocateBtn;

@end

@implementation HEEPositioningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutPositoinSubview];
    
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [KCURRENTCITYINFODEFAULTS setObject:self.resultLabel.text forKey:@"resultTEXT"];
}

- (void)layoutPositoinSubview {
    self.view.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"0081F1"];
    self.navigationItem.title = @"城市选择";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"0081f1"];
    
    UILabel *resultLabel = [[UILabel alloc] init];
    self.resultLabel = resultLabel;
    resultLabel.textColor = [UIColor colorWithHexString:@"434343"];
    resultLabel.textAlignment = NSTextAlignmentCenter;
    resultLabel.font = [UIFont systemFontOfSize:14];
    resultLabel.text = @"定位中...";

    UILabel *cityNameL = [[UILabel alloc] init];
    self.cityNameL = cityNameL;
    cityNameL.text = @"自动定位";
    cityNameL.textAlignment = NSTextAlignmentLeft;
    cityNameL.font = [UIFont systemFontOfSize:14];
    cityNameL.textColor = [UIColor colorWithHexString:@"636363"];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    UIButton *manuallyLocateBtn = [[UIButton alloc] init];
    self.manuallyLocateBtn = manuallyLocateBtn;
    [manuallyLocateBtn setTitle:@"手动定位" forState:UIControlStateNormal];
    [manuallyLocateBtn setTitle:@"手动定位" forState:UIControlStateSelected];
    [manuallyLocateBtn setTitleColor:[UIColor colorWithHexString:@"0081f1"] forState:UIControlStateNormal];
    manuallyLocateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    manuallyLocateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    manuallyLocateBtn.titleLabel.textColor = [UIColor colorWithHexString:@"0081f1"];
    [manuallyLocateBtn addTarget:self action:@selector(didClickedButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view sd_addSubviews:@[cityNameL, view1]];
    [view1 sd_addSubviews:@[resultLabel, manuallyLocateBtn]];
    
    cityNameL.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 8)
    .widthIs(80)
    .heightIs(44);
    
    view1.sd_layout
    .topSpaceToView(cityNameL,0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(44);
    
    resultLabel.sd_layout
    .leftSpaceToView(view1,0)
    .topSpaceToView(view1,0)
    .widthIs(150)
    .heightIs(44);
    
    manuallyLocateBtn.sd_layout
    .rightSpaceToView(view1, 8)
    .topSpaceToView(view1,0)
    .heightIs(44)
    .widthIs(100);
}

- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}

- (void)didClickedButtonEvent {
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    __weak typeof(self) weakSelf = self;
    [cityViewController choseCityBlock:^(NSString *cityName) {
        weakSelf.resultLabel.text = cityName;
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark --- JFLocationDelegate

//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    if (![_resultLabel.text isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _resultLabel.text = city;
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
            [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
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
