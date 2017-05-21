//
//  MyInfoViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/7.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MoreBtnViewController.h"
#import "HEEPositioningViewController.h"
#import <Chameleon.h>
#import <UIView+SDAutoLayout.h>
#import "KYWaterWaveView.h"
#import "JVShopcartViewController.h"
#import "addressManagerViewController.h"
#import "starProductViewController.h"
#import "myOrderViewController.h"
#import "myInformationViewController.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]
#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@interface MyInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) CAShapeLayer *layer;
@property(nonatomic, strong) CALayer *carLayer;
@property(nonatomic, strong) UITableView *myTableV;

@property(nonatomic, strong) UIView *headView;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutMyInfoView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configeHeadIMGAnimation];
}

- (IBAction)myMoreBtnClick:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    NSLog(@"点击了 我的 页面的 更多 按钮");
    MoreBtnViewController *moreVC = [[MoreBtnViewController alloc] init];
    [self.navigationController pushViewController:moreVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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

- (void)layoutMyInfoView {
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    UIView *headView = [[UIView alloc] init];
    self.headView = headView;
    headView.backgroundColor = [UIColor colorWithWhite:1. alpha:1];
    
    UIImageView *headIMG = [[UIImageView alloc] init];
    headIMG.image = [UIImage imageNamed:@"headIMG"];
    headIMG.layer.cornerRadius = 44;
    headIMG.layer.masksToBounds = YES;
    headIMG.layer.borderWidth = 1;
    headIMG.layer.borderColor = [UIColor colorWithHexString:@"0081f1"].CGColor;
    KYWaterWaveView *waterV = [[KYWaterWaveView alloc] initWithFrame:CGRectMake(0, 150, self.view.width, 40)];
    waterV.waveSpeed = 6.0f;
    waterV.waveAmplitude = 6.0f;
    [waterV wave];
    
    UITableView *myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.width, self.view.height-200) style:UITableViewStylePlain];
    myTableV.delegate = self;
    myTableV.dataSource = self;
    self.myTableV = myTableV;
    // 小技巧，用了之后不会出现多余的Cell
    UIView *view = [[UIView alloc] init];
    myTableV.tableFooterView = view;
    
    [self.view sd_addSubviews:@[headView, waterV, myTableV]];
    [headView sd_addSubviews:@[headIMG]];
    
    headView.sd_layout
    .topSpaceToView(self.view,-30)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view, 0)
    .heightIs(200);
    
    headIMG.sd_layout
    .centerXEqualToView(headView)
    .centerYEqualToView(headView)
    .widthIs(88)
    .heightIs(88);
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIImageView *imageview;
    UILabel *nameLabel;
    UILabel *countLabel;
    
    NSArray *imgArr = @[@"m01",@"m02",@"m03",@"m04",@"m05",@"m06",@"m07"];
    NSArray *tittleArr = @[@"地址管理",@"我的购物车",@"收藏商品",@"我的订单",@"个人信息",@"清理内存",@"注销"];
    NSArray *numArr = @[@"",@"8",@"12",@"2",@"",@"",@""];
    
    static NSString *cellIndetifier = @"myInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 8, 28, 28)];
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(64, 8, 200, 32)];
        nameLabel.font = [UIFont systemFontOfSize:18];
        nameLabel.textColor = [UIColor colorWithHexString:@"333"];
        countLabel = [[UILabel alloc]init];
        countLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        countLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
        countLabel.backgroundColor = [UIColor redColor];
        countLabel.layer.cornerRadius = 12;
        countLabel.layer.masksToBounds = YES;
        countLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:imageview];
        [cell addSubview:nameLabel];
        [cell sd_addSubviews:@[countLabel]];
        
        countLabel.sd_layout
        .rightSpaceToView(cell, 12)
        .topSpaceToView(cell, 12)
        .heightIs(24)
        .widthIs(24);
        
        cell.tag = indexPath.row;
    }
    
    imageview.image = [UIImage imageNamed: imgArr[indexPath.row]];
    countLabel.text = numArr[indexPath.row];
    nameLabel.text = tittleArr[indexPath.row];
    
    if ([countLabel.text isEqualToString:@""]) {
        countLabel.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger index = indexPath.row;
    
    if (index == 0) {
        self.hidesBottomBarWhenPushed=YES;
        addressManagerViewController *addressVC = [[addressManagerViewController alloc] init];
        [self.navigationController pushViewController:addressVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    
    if (index == 1) {
        self.hidesBottomBarWhenPushed=YES;
        JVShopcartViewController *shopCart = [[JVShopcartViewController alloc] init];
        [self.navigationController pushViewController:shopCart animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    
    if (index == 2) {
        self.hidesBottomBarWhenPushed=YES;
        starProductViewController *addressVC = [[starProductViewController alloc] init];
        [self.navigationController pushViewController:addressVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    
    if (index == 3) {
        self.hidesBottomBarWhenPushed=YES;
        myOrderViewController *addressVC = [[myOrderViewController alloc] init];
        [self.navigationController pushViewController:addressVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    
    if (index == 4) {
        self.hidesBottomBarWhenPushed=YES;
        myInformationViewController *addressVC = [[myInformationViewController alloc] init];
        [self.navigationController pushViewController:addressVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    
    if (index == 5) {
        //清理内存
    }
    
    if (index == 6) {
        //注销
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (void)configeHeadIMGAnimation {
    
    CGFloat StartX = (self.view.width - 118)/2;
    self.layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(StartX, 14, 118, 118)];
    path.lineWidth = 15;
    self.layer.path = path.CGPath;
    self.layer.strokeColor = [UIColor colorWithHexString:@"0080f1"].CGColor;
    self.layer.fillColor = [UIColor clearColor].CGColor;
    
    [self.view.layer addSublayer:self.layer];
    
    CABasicAnimation *strokeAnim=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnim.fromValue=@0;
    strokeAnim.toValue=@1.0;
    strokeAnim.duration=2.0;
    strokeAnim.repeatCount=HUGE_VALF;
    [self.layer addAnimation:strokeAnim forKey:@"strokeEnd"];
    
    self.carLayer=[CALayer layer];
    UIImage *carImg=[UIImage imageNamed:@"car"];
    self.carLayer.contents=(id)carImg.CGImage;
    
    self.carLayer.bounds=CGRectMake(StartX, 44, 32, 32);
    [self.view.layer addSublayer:self.carLayer];
    
    //
    CAKeyframeAnimation *positionAnim=[CAKeyframeAnimation animationWithKeyPath:@"position"]; //注意是 `CAKeyframeAnimation`
    positionAnim.path=self.layer.path; //让飞机的Path 为圆形path
    positionAnim.duration=2.0;
    positionAnim.calculationMode=kCAAnimationPaced; //计算模式
    positionAnim.rotationMode=kCAAnimationRotateAuto; //让飞机头的朝向和他的path方向相同
    positionAnim.repeatCount = HUGE_VALF;
    
    [self.carLayer addAnimation:positionAnim forKey:@"position"];
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
