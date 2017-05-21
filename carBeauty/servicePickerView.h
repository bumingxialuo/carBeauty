//
//  servicePickerView.h
//  carBeauty
//
//  Created by apple7 on 17/4/20.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^servicePickShowLableContentBlock)(void);
typedef void (^servicePickerFinishBtnEventBlock)(void);

@interface servicePickerView : UIView

//@property(nonatomic, copy) servicePickShowLableContentBlock servicePickShowLableContentBlock;
@property(nonatomic, copy) servicePickerFinishBtnEventBlock servicePickerFinishBtnEventBlock;

@end
