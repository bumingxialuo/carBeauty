//
//  ProductDetailViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/10.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "ProductDetailViewController.h"
#import <Chameleon.h>
#import <UIView+SDAutoLayout.h>
#import "HEEProductShopCarBottomView.h"
#import "GoodAttrModel.h"
#import "GoodAttributesView.h"
#import "ChatToMerchantsViewController.h"
#import <SDCycleScrollView.h>

@interface ProductDetailViewController ()<UIScrollViewDelegate, UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) HEEProductShopCarBottomView *shopCarBottomView;

@property(nonatomic, strong) NSArray *goodAttrsArr;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBar.translucent = NO;
    
    self.tabBarController.tabBar.hidden=YES;
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"fff"];
    self.navigationItem.title = @"产品详情";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"0081f1"];
    
    [self layoutPDView];
    [self createData];
}

- (void)layoutPDView {
    
    [self.view layoutIfNeeded];
    
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor redColor];
    
    // 由于tableviewHeaderView的特殊性， 在使他高度自适应之前你最好先给它设置一个宽度
    header.width = [UIScreen mainScreen].bounds.size.width;
    
    NSArray *picImageNamesArray = @[@"1001",@"1002", @"1003"];
    
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, header.width, 200) imageNamesGroup:picImageNamesArray];
    scrollView.localizationImageNamesGroup = picImageNamesArray;
    scrollView.currentPageDotColor = [UIColor colorWithHexString:@"0081f1"];
    scrollView.pageDotColor = [UIColor colorWithHexString:@"ff7c38"];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showPageControl = YES;
    
    CGFloat subWIDTH = ([UIScreen mainScreen].bounds.size.width -20) / 3;

    
    UIView *fillView = [[UIView alloc] init];
    fillView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    UILabel *product = [[UILabel alloc] init];
    product.text = @"汽车防冻玻璃水";
    product.textAlignment = NSTextAlignmentLeft;
    product.textColor = [UIColor colorWithHexString:@"333"];
    product.font = [UIFont systemFontOfSize:16];
    
    UILabel *price = [[UILabel alloc] init];
    price.text = @"¥ 15.8-28.8";
    price.textColor = [UIColor redColor];
    price.textAlignment = NSTextAlignmentLeft;
    price.font = [UIFont systemFontOfSize:20];
    
    UILabel *courier = [[UILabel alloc] init];
    courier.text = @"快递：免运费";
    courier.textAlignment = NSTextAlignmentLeft;
    courier.textColor = [UIColor colorWithHexString:@"666"];
    courier.font = [UIFont systemFontOfSize:12];
    
    UILabel *sales = [[UILabel alloc] init];
    sales.text = @"月销51692笔";
    sales.textAlignment = NSTextAlignmentCenter ;
    sales.textColor = [UIColor colorWithHexString:@"666"];
    sales.font = [UIFont systemFontOfSize:12];
    
    UILabel *addr = [[UILabel alloc] init];
    addr.text = @"江苏南京";
    addr.textColor = [UIColor colorWithHexString:@"666"];
    addr.textAlignment = NSTextAlignmentRight;
    addr.font = [UIFont systemFontOfSize:12];
    
    UITableView *proTable = [[UITableView alloc] init];
    proTable.delegate = self;
    proTable.dataSource = self;

    [self.view sd_addSubviews:@[header,fillView, self.shopCarBottomView,proTable]];
    [header addSubview:scrollView];
    
    [fillView sd_addSubviews:@[product,price,courier,sales,addr]];
    
    header.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(200);
    
    self.shopCarBottomView.sd_layout
    .bottomSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view,0)
    .heightIs(48);
    
    fillView.sd_layout
    .topSpaceToView(header, 0)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .heightIs(100);
    
    product.sd_layout
    .topSpaceToView(fillView, 0)
    .leftSpaceToView(fillView, 0)
    .rightSpaceToView(fillView, 0)
    .heightIs(40);
    
    price.sd_layout
    .topSpaceToView(product, 0)
    .leftSpaceToView(fillView, 0)
    .rightSpaceToView(fillView, 0)
    .heightIs(40);
    
    courier.sd_layout
    .topSpaceToView(price, 0)
    .leftSpaceToView(fillView, 0)
    .widthIs(subWIDTH)
    .heightIs(20);
    
    sales.sd_layout
    .topSpaceToView(price, 0)
    .leftSpaceToView(courier, 0)
    .widthIs(subWIDTH)
    .heightIs(20);
    
    addr.sd_layout
    .topSpaceToView(price, 0)
    .leftSpaceToView(sales, 0)
    .widthIs(subWIDTH)
    .heightIs(20);
    
    proTable.sd_layout
    .topSpaceToView(fillView,10)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,48);
}

- (HEEProductShopCarBottomView *)shopCarBottomView {
    if (_shopCarBottomView == nil) {
        _shopCarBottomView = [[HEEProductShopCarBottomView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        
        _shopCarBottomView.ProductShopcartBotttomViewtalkBlock = ^(){
            ChatToMerchantsViewController *talkVC = [[ChatToMerchantsViewController alloc] init];
            [weakSelf.navigationController pushViewController:talkVC animated:YES];
        };
        _shopCarBottomView.ProductShopcartBotttomViewStarBlock = ^(){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        };
        _shopCarBottomView.ProductShopcartBotttomViewAddBlock = ^() {
            [weakSelf createAttributesView];
            NSLog(@"执行代理");
        };
        
        _shopCarBottomView.ProductShopcartBotttomViewBuyBlock = ^() {
            [weakSelf createAttributesView];
        };
    }
    return _shopCarBottomView;
}

- (void)createData {
    GoodAttrModel *model0 = [GoodAttrModel new];
    model0.attr_id = @"10";
    model0.attr_name = @"尺寸";
    GoodAttrValueModel *value1 = [GoodAttrValueModel new];
    value1.attr_value = @"2L";
    model0.attr_value = [NSArray arrayWithObjects:value1,nil];
    
    GoodAttrModel *model1 = [GoodAttrModel new];
    model1.attr_id = @"11";
    model1.attr_name = @"分类";
    GoodAttrValueModel *value10 = [GoodAttrValueModel new];
    value10.attr_value = @"2大桶[0度]";
    GoodAttrValueModel *value20 = [GoodAttrValueModel new];
    value20.attr_value = @"2大桶共4L[0度]";
    GoodAttrValueModel *value30 = [GoodAttrValueModel new];
    value30.attr_value = @"2大桶共4L[－10度]";
    GoodAttrValueModel *value40 = [GoodAttrValueModel new];
    value40.attr_value = @"2大桶共4L[-25度]";
    GoodAttrValueModel *value50 = [GoodAttrValueModel new];
    value50.attr_value = @"2大桶[0度]＋洗衣液[洗20次]";
    GoodAttrValueModel *value60 = [GoodAttrValueModel new];
    value60.attr_value = @"2大桶[0度]＋防雾剂＋驱水剂";
    GoodAttrValueModel *value70 = [GoodAttrValueModel new];
    value70.attr_value = @"1大桶共2L[0度]";
    GoodAttrValueModel *value80 = [GoodAttrValueModel new];
    value80.attr_value = @"浓缩雨刷精[6瓶装]";
    model1.attr_value = [NSArray arrayWithObjects:value10, value20, value30, value40, value50, value60,value70,value80, nil];
    
    self.goodAttrsArr = [NSArray arrayWithObjects:model0, model1, nil];
}
- (void)createAttributesView {
    GoodAttributesView *attributesView = [[GoodAttributesView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    attributesView.goodAttrsArr = self.goodAttrsArr;
    attributesView.sureBtnsClick = ^(NSString *num, NSString *attrs, NSString *goods_attr_value_1, NSString *goods_attr_value_2) {
        NSLog(@"\n购物数量：%@ \n 第一个属性：%@ \n 第二个属性：%@", num, goods_attr_value_1, goods_attr_value_2);
    };
    [attributesView showInView:self.navigationController.view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"procell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"procell"];
    }
    cell.textLabel.text = @"玻璃水很好用";
    cell.textLabel.textColor = [UIColor colorWithHexString:@"666"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    UILabel *title = [[UILabel alloc] init];
//    title.textColor = [UIColor colorWithHexString:@"333"];
//    title.textAlignment = NSTextAlignmentLeft;
//    title.font = [UIFont systemFontOfSize:16];
//    title.text = @"评论列表";
    return @"评论列表";
}

///**
// *  获取 商品属性 数据
// */
//- (void)getGoodAttrData {
//
//    // 后台服务器返回的数据格式，在最下面，仅供参考
//
//    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
//    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
//    paramas[@"method"] = @"goods_attr";
//    paramas[@"goods_id"] = @"11";
//    [LXHttpTool post:URL params:paramas success:^(id json) {
//        NSLog(@"%@", json);
//        NSInteger status = [json[@"status"] integerValue];
//        if (status == 1) {
//            NSArray *goodAttrsArr = [GoodAttrModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
//            self.goodAttrsArr = goodAttrsArr;
//
//        } else {
//            [SVProgressHUD showErrorWithStatus:@"暂无商品属性" maskType:SVProgressHUDMaskTypeGradient];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"请重新加载" maskType:SVProgressHUDMaskTypeGradient];
//        NSLog(@"%@", error);
//    }];
//}

// 服务器返回的数据格式,仅供参考
//{
//    data =     (
//                {
//                    "attr_id" = 10;
//                    "attr_name" = "\U5c3a\U7801";
//                    "attr_value" =             (
//                                                {
//                                                    "attr_value" = 165;
//                                                },
//                                                {
//                                                    "attr_value" = 160;
//                                                }
//                                                );
//                },
//                {
//                    "attr_id" = 11;
//                    "attr_name" = "\U989c\U8272";
//                    "attr_value" =             (
//                                                {
//                                                    "attr_value" = "\U7ea2\U8272";
//                                                },
//                                                {
//                                                    "attr_value" = "\U9ed1\U8272";
//                                                }
//                                                );
//                }
//                );
//    status = 1;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
