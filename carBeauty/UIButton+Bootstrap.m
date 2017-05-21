//
//  UIButton+Bootstrap.m
//  carBeauty
//
//  Created by apple7 on 17/4/16.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "UIButton+Bootstrap.h"

@implementation UIButton (Bootstrap)

-(void)bootstrapStyle:(CGFloat)cornerRadius{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
}

- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


-(void)defaultStyleWithNormalTitleColor:(UIColor *)titleColor andHighTitleColor:(UIColor *)highTitleColor andBorderColor:(UIColor *)borderColor andBackgroundColor:(UIColor *)bgColor andHighBgColor:(UIColor *)highBgColor andSelectedBgColor:(UIColor *)selectedBgColor withcornerRadius:(CGFloat)cornerRadius{
    [self bootstrapStyle:cornerRadius];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:highTitleColor forState:UIControlStateHighlighted];
    [self setTitleColor:highTitleColor forState:UIControlStateSelected];
    self.layer.borderColor = [borderColor CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:bgColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:highBgColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self buttonImageFromColor:selectedBgColor] forState:UIControlStateSelected];
}
-(void)defaultStyleWithNormalTitleColor:(UIColor *)titleColor andHighTitleColor:(UIColor *)highTitleColor andBorderColor:(UIColor *)borderColor andBackgroundColor:(UIColor *)bgColor andHighBgColor:(UIColor *)highBgColor withcornerRadius:(CGFloat)cornerRadius{
    [self bootstrapStyle:cornerRadius];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:highTitleColor forState:UIControlStateHighlighted];
    [self setBackgroundImage:[self buttonImageFromColor:bgColor] forState:UIControlStateNormal];
    self.layer.borderColor = [borderColor CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:highBgColor] forState:UIControlStateHighlighted];
}


@end
