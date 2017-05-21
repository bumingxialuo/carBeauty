//
//  merchansDetailButtonView.h
//  carBeauty
//
//  Created by apple7 on 17/4/18.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^showLookAppointmentViewBotttomViewBlock)(void);
typedef void(^showImmediatelyAppiontmentViewBotttomViewBlock)(void);

@interface merchansDetailButtonView : UIView

@property (nonatomic, copy) showLookAppointmentViewBotttomViewBlock showLookAppointmentViewBotttomViewBlock;
@property (nonatomic, copy) showImmediatelyAppiontmentViewBotttomViewBlock showImmediatelyAppiontmentViewBotttomViewBlock;

@end
