//
//  HEEProductShopCarBottomView.m
//  carBeauty
//
//  Created by apple7 on 17/4/16.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "HEEProductShopCarBottomView.h"
#import <Chameleon.h>
#import <UIView+SDAutoLayout.h>
#import "GoodAttrModel.h"
#import "GoodAttributesView.h"
#import "Chameleon.h"
#import <UIView+SDAutoLayout.h>

@interface HEEProductShopCarBottomView()

@property(nonatomic, strong) UIButton *chatMSG;
@property(nonatomic, strong) UIButton *starGood;
@property(nonatomic, strong) UIButton *addGoodToCar;
@property(nonatomic, strong) UIButton *buyGood;


@end

@implementation HEEProductShopCarBottomView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self layoutShopCarBottomSubview];
    }
    return self;
}


- (void)layoutShopCarBottomSubview {
    
    CGFloat subviewW = [UIScreen mainScreen].bounds.size.width / 3;
    
    UIButton *chatMSG = [[UIButton alloc] init];
    self.chatMSG = chatMSG;
    [chatMSG setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [chatMSG addTarget:self action:@selector(chatMSGBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *starGood = [[UIButton alloc] init];
    self.starGood = starGood;
    [starGood setImage:[UIImage imageNamed:@"goodStar"] forState:UIControlStateNormal];
    [starGood addTarget:self action:@selector(starGoodBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"fff"];
    
    UIButton *addGoodToCar = [[UIButton alloc] init];
    self.addGoodToCar = addGoodToCar;
    addGoodToCar.backgroundColor = [UIColor colorWithHexString:@"ff7c38"];
    [addGoodToCar setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [addGoodToCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addGoodToCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addGoodToCar addTarget:self action:@selector(addGoodToCarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buyGood = [[UIButton alloc] init];
    self.buyGood = buyGood;
    buyGood.backgroundColor = [UIColor redColor];
    [buyGood setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [buyGood setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyGood setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyGood addTarget:self action:@selector(buyGoodBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self sd_addSubviews:@[chatMSG, starGood, line, addGoodToCar, buyGood]];
    
    chatMSG.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(self, 0)
    .widthIs(subviewW/2-0.5)
    .heightIs(48);
    
    line.sd_layout
    .topSpaceToView(self, 0)
    .bottomSpaceToView(self, 0)
    .leftSpaceToView(chatMSG, 0)
    .widthIs(1);
    
    starGood.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(line, 0)
    .widthIs(subviewW/2-0.5)
    .heightIs(48);
    
    addGoodToCar.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(starGood, 0)
    .widthIs(subviewW)
    .heightIs(48);
    
    buyGood.sd_layout
    .topSpaceToView(self, 0)
    .leftSpaceToView(addGoodToCar, 0)
    .widthIs(subviewW)
    .heightIs(48);
}

- (void)chatMSGBtnClick {
    //客服聊天按钮
    if (self.ProductShopcartBotttomViewtalkBlock) {
        self.ProductShopcartBotttomViewtalkBlock();
    }
}

- (void)starGoodBtnClick {
    //收藏商品按钮
    if (self.ProductShopcartBotttomViewStarBlock) {
        self.ProductShopcartBotttomViewStarBlock();
    }
}

- (void)addGoodToCarBtnClick {
    //添加商品到购物车
    
    if (self.ProductShopcartBotttomViewAddBlock) {
        self.ProductShopcartBotttomViewAddBlock();
    }
    
}

- (void)buyGoodBtnClick {
    //直接购买商品
    if (self.ProductShopcartBotttomViewBuyBlock) {
        self.ProductShopcartBotttomViewBuyBlock();
    }
}

@end
