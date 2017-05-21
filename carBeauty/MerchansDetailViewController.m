//
//  MerchansDetailViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/10.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "MerchansDetailViewController.h"
#import <Chameleon.h>
#import <SDCycleScrollView.h>
#import <UIView+SDAutoLayout.h>
#import "merchansDetailButtonView.h"
#import "LocationViewController.h"
#import "LookAppointmentViewController.h"
#import "showImmediatelyAppiontmentViewController.h"

@interface MerchansDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UILabel *merTel;

@property(nonatomic, strong) NSArray *serviceTitleArr;
@property(nonatomic, strong) NSDictionary *serviceDic;
@property(nonatomic, strong) merchansDetailButtonView *merchansDetailButtonView;

/*
 @propery修饰的属性可以被外部文件直接访问(是通过其自动生成的getter，setter方法访问的)，而大括号里面声明的属性是不能被外部文件访问的(不会自动生成getter，setter方法，所以不能被访问，但是如果手写getter，setter就可以被访问)。
 
 原理：@property修饰的属性其实是自动生成该属性以及该属性的getter，setter方法的声明以及实现。而大括号里面的属性仅仅生成该属性。
 */

@end

@implementation MerchansDetailViewController

- (merchansDetailButtonView *)merchansDetailButtonView {
    if (_merchansDetailButtonView == nil) {
        _merchansDetailButtonView = [[merchansDetailButtonView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        
        _merchansDetailButtonView.showLookAppointmentViewBotttomViewBlock = ^(){
            weakSelf.hidesBottomBarWhenPushed = YES;
            LookAppointmentViewController *lookVC = [[LookAppointmentViewController alloc] init];
            [weakSelf.navigationController pushViewController:lookVC animated:YES];
            weakSelf.hidesBottomBarWhenPushed = YES;
        };
        
        _merchansDetailButtonView.showImmediatelyAppiontmentViewBotttomViewBlock = ^(){
            weakSelf.hidesBottomBarWhenPushed = YES;
            showImmediatelyAppiontmentViewController *immediatelyVC = [[showImmediatelyAppiontmentViewController alloc] init];
            [weakSelf.navigationController pushViewController:immediatelyVC animated:YES];
            weakSelf.hidesBottomBarWhenPushed = YES;
        };
    }
    return _merchansDetailButtonView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"e9e9e9"];
    self.navigationItem.title = @"商家详情";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"0081f1"];
 
    self.serviceTitleArr = @[@"常规美容",@"特色美容",@"常规保养",@"特色高级保养",@"免拆维护"];
    
    self.serviceDic = @{@"常规美容":@[@"360°全能手工精洗",@"金牌全车精洗",@"铂朗漆面镀膜",@"真皮镀膜",@"内室深度清洁",@"内室桑拿消毒",@"轮胎轮毂专业清洁"],
                        @"特色美容":@[@"45分钟智能车漆快修",@"全车特效喷漆",@"隔热防爆太阳膜",@"美国",@"比利时进口专业车身贴膜"],
                        @"常规保养":@[@"换机油",@"防冻液",@"换三滤（机滤、汽滤、空滤）",@"雨刮",@"变速器止漏",@"清洗刹车片",@"空调检测及加氟",@"检查电瓶液配比",@"电瓶维护",@"火花塞保养",@"全车皮带维护"],
                        @"特色高级保养":@[@"电脑检测及解码",@"发电机维护",@"发动机维护",@"尾气达标",@"专业底盘检测"],
                        @"免拆维护":@[@"润滑系统免拆清洗",@"冷却系统免拆清洗",@"冷却系统除垢处理",@"发动机免拆清洗",@"变速箱免拆清洗",@"转向系统免拆清洗"]};
    
    [self setupHeaderView];
    
    [self layoutMerchansSubviews];
}

- (void)setupHeaderView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *header = [[UIView alloc]init];
    
    // 由于tableviewHeaderView的特殊性， 在使他高度自适应之前你最好先给它设置一个宽度
    header.width = [UIScreen mainScreen].bounds.size.width;
    
    NSArray *picImageNamesArray = @[ @"mer01",@"mer02", @"mer03",@"mer04"];
    
    SDCycleScrollView *scrollView = [[SDCycleScrollView alloc]init];
    scrollView.localizationImageNamesGroup = picImageNamesArray;
    scrollView.currentPageDotColor = [UIColor colorWithHexString:@"0081f1"];
    scrollView.pageDotColor = [UIColor colorWithHexString:@"fff"];
    
    [self.view sd_addSubviews:@[header]];
    [header addSubview:scrollView];
    
    header.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(200);
    
    scrollView.sd_layout
    .leftSpaceToView(header,0)
    .topSpaceToView(header,0)
    .rightSpaceToView(header,0)
    .heightIs(200);
    
}

- (void)layoutMerchansSubviews {
    
    UIView *fillView = [[UIView alloc] init];
    fillView.backgroundColor = [UIColor whiteColor];
    
    UILabel *merName = [[UILabel alloc] init];
    merName.text = @"重庆市美容服务有限公司";
    merName.textColor = [UIColor colorWithHexString:@"333"];
    merName.font = [UIFont systemFontOfSize:18];
    merName.textAlignment = NSTextAlignmentLeft;
    
    UIView *imgContent = [[UIView alloc] init];
    imgContent.backgroundColor = [UIColor whiteColor];
    
    UIView *telContent = [[UIView alloc] init];
    telContent.backgroundColor = [UIColor whiteColor];
    
    UIButton *addIMGBtn = [[UIButton alloc] init];
    [addIMGBtn setImage:[UIImage imageNamed:@"m01"] forState:UIControlStateNormal];
    [addIMGBtn addTarget:self action:@selector(mapNavigation) forControlEvents:UIControlEventTouchUpInside];
    
//    UIImageView *addIMG = [[UIImageView alloc] init];
//    addIMG.image = [UIImage imageNamed:@"m01"];
    
    
    UILabel *merAddr = [[UILabel alloc] init];
    merAddr.text = @"重庆市渝北区经济开发区经开国企大道99号";
    merAddr.textColor = [UIColor colorWithHexString:@"666"];
    merAddr.font = [UIFont systemFontOfSize:14];
    merAddr.textAlignment = NSTextAlignmentCenter;
    merAddr.layer.cornerRadius = 3.;
    merAddr.layer.borderColor = [UIColor colorWithHexString:@"0081f1"].CGColor;
    merAddr.layer.borderWidth = 1;
    
    UIButton *callBtn = [[UIButton alloc] init];
    callBtn.backgroundColor = [UIColor whiteColor];
    [callBtn setTitle:@"点击拨打" forState:UIControlStateNormal];
    [callBtn setTitleColor:[UIColor colorWithHexString:@"666"] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(callTelClick) forControlEvents:UIControlEventTouchUpInside];
    callBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *merTel = [[UILabel alloc] init];
    self.merTel = merTel;
    merTel.text = @"023-28888780";
    merTel.textColor = [UIColor colorWithHexString:@"f00"];
    merTel.font = [UIFont systemFontOfSize:18];
    merTel.textAlignment = NSTextAlignmentRight;
    
    UITableView *merServiceTable = [[UITableView alloc] init];
    merServiceTable.delegate = self;
    merServiceTable.dataSource = self;
    
//    merchansDetailButtonView *bottomView = [[merchansDetailButtonView alloc] init];
    
    [self.view sd_addSubviews:@[fillView,self.merchansDetailButtonView,merServiceTable]];
    [fillView sd_addSubviews:@[merName,imgContent,telContent]];
    [imgContent sd_addSubviews:@[addIMGBtn,merAddr]];
    [telContent sd_addSubviews:@[callBtn,merTel]];
    
    fillView.sd_layout
    .topSpaceToView(self.view,200)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(160);
    
    merName.sd_layout
    .topSpaceToView(fillView,20)
    .leftSpaceToView(fillView,10)
    .rightSpaceToView(fillView,10)
    .heightIs(40);
    
    imgContent.sd_layout
    .topSpaceToView(merName,0)
    .leftEqualToView(merName)
    .rightEqualToView(merName)
    .heightIs(60);
    
    addIMGBtn.sd_layout
    .topSpaceToView(imgContent,10)
    .leftSpaceToView(imgContent,10)
    .widthIs(40)
    .heightIs(40);
    
    merAddr.sd_layout
    .topSpaceToView(imgContent,0)
    .leftSpaceToView(addIMGBtn,10)
    .rightSpaceToView(imgContent,0)
    .heightIs(60);
    
    telContent.sd_layout
    .topSpaceToView(imgContent,0)
    .leftEqualToView(merName)
    .rightEqualToView(merName)
    .heightIs(40);
    
    callBtn.sd_layout
    .topSpaceToView(telContent,0)
    .leftSpaceToView(telContent,120)
    .widthIs(100)
    .heightIs(40);
    
    merTel.sd_layout
    .topSpaceToView(telContent,0)
    .leftSpaceToView(callBtn,0)
    .rightSpaceToView(telContent,0)
    .heightIs(40);
    
    merServiceTable.sd_layout
    .topSpaceToView(self.view, 360)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view, 10)
    .bottomSpaceToView(self.view,48);
    
    self.merchansDetailButtonView.sd_layout
    .bottomSpaceToView(self.view, 0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(48);
}

- (void)mapNavigation {
    NSLog(@"导入地图");
    self.hidesBottomBarWhenPushed = YES;
    LocationViewController *LocalVC = [[LocationViewController alloc] init];
    [self.navigationController pushViewController:LocalVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)callTelClick {
    //调取拨打电话的按钮  merTel
    
    //真机调试
    
//    NSString *stringTel = [NSString stringWithFormat:@"tel:023-28888780"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringTel] options:<#(nonnull NSDictionary<NSString *,id> *)#> completionHandler:<#^(BOOL success)completion#>]
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:023-28888780"]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    NSLog(@"拨打电话");
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.serviceTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *key = [self.serviceTitleArr objectAtIndex:section];
    ;
    return [[self.serviceDic objectForKey:key] count];
    

    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.serviceTitleArr objectAtIndex:section];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *key = [self.serviceTitleArr objectAtIndex:section];
    NSArray *serviceArr = [self.serviceDic objectForKey:key];
    
    static NSString *GroupedtableViewIdentifier = @"GroupedtableViewIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GroupedtableViewIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GroupedtableViewIdentifier];
    }
    cell.textLabel.text = [serviceArr objectAtIndex:row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"666"];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
