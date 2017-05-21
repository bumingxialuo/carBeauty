//
//  HEEProductTableViewCell.h
//  carBeauty
//
//  Created by apple7 on 17/4/9.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HEEProductTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *proIMG;               //产品图片
@property(nonatomic, strong) UILabel *proName;                  //产品名字
@property(nonatomic, strong) UILabel *proNum;                   //产品数量
@property(nonatomic, strong) UILabel *proRMB;                   //产品价格

@end
