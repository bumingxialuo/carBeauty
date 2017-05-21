//
//  HEEProductShopCarBottomView.h
//  carBeauty
//
//  Created by apple7 on 17/4/16.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ProductShopcartBotttomViewStarBlock)(void);
typedef void(^ProductShopcartBotttomViewAddBlock)(void);
typedef void(^ProductShopcartBotttomViewBuyBlock)(void);
typedef void(^ProductShopcartBotttomViewTalkBlock)(void);

@interface HEEProductShopCarBottomView : UIView

@property (nonatomic, copy) ProductShopcartBotttomViewTalkBlock ProductShopcartBotttomViewtalkBlock;
@property (nonatomic, copy) ProductShopcartBotttomViewStarBlock ProductShopcartBotttomViewStarBlock;
@property (nonatomic, copy) ProductShopcartBotttomViewAddBlock ProductShopcartBotttomViewAddBlock;
@property (nonatomic, copy) ProductShopcartBotttomViewBuyBlock ProductShopcartBotttomViewBuyBlock;

@end
