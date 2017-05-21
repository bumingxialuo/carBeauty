//
//  MerchantsViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/7.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "MerchantsViewController.h"
#import "HEEProductTableViewCell.h"
#import <UIView+SDAutoLayout.h>
#import <Chameleon.h>
#import "merchansSeachBtnViewController.h"
#import "MerchansDetailViewController.h"
#import "HEEPositioningViewController.h"

static CGFloat const OffsetY = 190;
static NSString *const oneCell = @"HEEOneCell";

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface MerchantsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *merchantsTableV;
@end

@implementation MerchantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    // Do any additional setup after loading the view.
//    [self setupConfigures];
    UITableView *merchantsTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    merchantsTableV.delegate = self;
    merchantsTableV.dataSource = self;
    self.merchantsTableV = merchantsTableV;
    [self.view addSubview:self.merchantsTableV];
    merchantsTableV.sd_layout.topSpaceToView(self.view, -20);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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

- (IBAction)merchantsSeachBtnClick:(id)sender {
    NSLog(@"点击了商家列表的 搜索 页面");
    self.hidesBottomBarWhenPushed = YES;
    merchansSeachBtnViewController *merchansSeachVC = [[merchansSeachBtnViewController alloc] init];
    [self.navigationController pushViewController:merchansSeachVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)setupConfigures{
    // 修改tableView的样式
    UITableView *merchantsTableV = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:oneCell];
    self.merchantsTableV = merchantsTableV;
    self.merchantsTableV.contentInset = UIEdgeInsetsMake(OffsetY - 25, 0, -35, 0);
    self.merchantsTableV.scrollIndicatorInsets = self.merchantsTableV.contentInset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HEEProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
    
    if (!cell) {
        cell = [[HEEProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
    }
    
    cell.proIMG.image = [UIImage imageNamed:@"timL"];
    cell.proName.text = @"重庆汽车美容服务有限公司";
    cell.proNum.text = @"重庆市渝北区经济开发区经开国企大道99号";
    cell.proRMB.text = @"023-28888708";
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"附近商家";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = ([UIScreen mainScreen].bounds.size.width - 0) / 3 + 8;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    MerchansDetailViewController *merchansDetailVC = [[MerchansDetailViewController alloc] init];
    [self.navigationController pushViewController:merchansDetailVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
