//
//  HEEProductTableViewCell.m
//  carBeauty
//
//  Created by apple7 on 17/4/9.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "HEEProductTableViewCell.h"
#import <UIView+SDAutoLayout.h>
#import <Chameleon.h>

@interface HEEProductTableViewCell()

@end

@implementation HEEProductTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
        [self layoutCellSubView];
    }
    return self;
}

- (void)layoutCellSubView {
    
    UIView *cellL = [[UIView alloc] init];
    cellL.backgroundColor = [UIColor whiteColor];
    cellL.layer.cornerRadius = 8;
    
    UIImageView *proIMG = [[UIImageView alloc] init];
    self.proIMG = proIMG;
    //proIMG.image = [UIImage imageNamed:@""];
    proIMG.layer.masksToBounds = YES;
    proIMG.layer.cornerRadius = 3;
    
    UIView *cellR = [[UIView alloc] init];
    cellR.backgroundColor = [UIColor whiteColor];
    cellR.layer.cornerRadius = 8;
    
    UILabel *proName = [[UILabel alloc] init];
    self.proName = proName;
    proName.font = [UIFont systemFontOfSize:18];
    proName.textAlignment = NSTextAlignmentLeft;
    proName.textColor = [UIColor colorWithHexString:@"333333"];
    proName.numberOfLines = 1;
    
    UILabel *proNum = [[UILabel alloc] init];
    self.proNum = proNum;
    proNum.font = [UIFont systemFontOfSize:14];
    proNum.textColor = [UIColor colorWithHexString:@"636363"];
    proNum.textAlignment = NSTextAlignmentLeft;
    proNum.numberOfLines = 2;
    
    UILabel *proRMB = [[UILabel alloc] init];
    self.proRMB = proRMB;
    proRMB.font = [UIFont systemFontOfSize:14];
    proRMB.textAlignment = NSTextAlignmentLeft;
    proRMB.textColor = [UIColor colorWithHexString:@"ff0000"];
    proRMB.numberOfLines = 1;
    
    [self.contentView sd_addSubviews:@[cellL , cellR]];
    [cellL sd_addSubviews:@[proIMG]];
    [cellR sd_addSubviews:@[proName, proNum, proRMB]];
    
    CGFloat IMGWidth = ([UIScreen mainScreen].bounds.size.width - 24) / 3;
    
    cellL.sd_layout
    .topSpaceToView(self.contentView, 8)
    .leftSpaceToView(self.contentView, 8)
    .widthIs(IMGWidth)
    .heightIs(IMGWidth);
    
    proIMG.sd_layout
    .topSpaceToView(cellL,3)
    .rightSpaceToView(cellL,3)
    .rightSpaceToView(cellL,3)
    .bottomSpaceToView(cellL,3);
    
    cellR.sd_layout
    .topEqualToView(cellL)
    .rightSpaceToView(self.contentView, 8)
    .widthIs(IMGWidth*2)
    .heightIs(IMGWidth);
    
    proName.sd_layout
    .topSpaceToView(cellR, 3)
    .leftSpaceToView(cellR, 3)
    .widthIs(IMGWidth*2-6)
    .heightIs(21);
    
    proNum.sd_layout
    .leftEqualToView(proName)
    .topSpaceToView(proName, 15)
    .widthIs(IMGWidth*2-6)
    .heightIs(50);
    
    proRMB.sd_layout
    .leftEqualToView(proNum)
    .bottomSpaceToView(cellR,8)
    .widthIs(IMGWidth*2-6)
    .heightIs(15);
}
@end
