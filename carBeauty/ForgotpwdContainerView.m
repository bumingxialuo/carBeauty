//
//  ForgotpwdContainerView.m
//  microblog
//
//  Created by apple7 on 17/3/6.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "ForgotpwdContainerView.h"

@interface ForgotpwdContainerView()
@property (nonatomic, strong) UITextField *phoneTextF;
@property (nonatomic, strong) UITextField *resetPasswordTextF;
@property (nonatomic, strong) UITextField *verifyCodeTextF;
@property (nonatomic, assign) NSInteger timeseconds;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *sendVerifyCodeBtn;
@property (nonatomic, copy) NSString *verifyCode;
@end

@implementation ForgotpwdContainerView

- (instancetype)init {
    if (self = [super init]) {
        self.timeseconds = 60;
        [self setSubView];
    }
    return self;
}

- (void)setSubView {
    [super setSubView];
    
    UIButton *backToLogginContain = [[UIButton alloc] init];
    [backToLogginContain setImage:[UIImage imageNamed:@"rightback"] forState:UIControlStateNormal];
    [backToLogginContain addTarget:self action:@selector(backToLoginContainClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *resetPasswordBtn = [[UIButton alloc] init];
    [resetPasswordBtn setTitle:@"确定" forState:UIControlStateNormal];
    resetPasswordBtn.backgroundColor = [UIColor colorWithHexString:@"0081f1"];
    resetPasswordBtn.layer.cornerRadius = 7.5;
    resetPasswordBtn.layer.masksToBounds = YES;
    resetPasswordBtn.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.75].CGColor;
    [resetPasswordBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _phoneTextF = [[UITextField alloc] init];
    _phoneTextF.font = [UIFont systemFontOfSize:14];
    _phoneTextF.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextF.textColor = [UIColor colorWithHexString:@"303030"];
    _phoneTextF.borderStyle = UITextBorderStyleNone;
    _phoneTextF.textAlignment = NSTextAlignmentCenter;
    _phoneTextF.placeholder = @"手机号";
    
    _resetPasswordTextF = [[UITextField alloc] init];
    _resetPasswordTextF.font = [UIFont systemFontOfSize:14];
    _resetPasswordTextF.keyboardType = UIKeyboardTypePhonePad;
    _resetPasswordTextF.textColor = [UIColor colorWithHexString:@"303030"];
    _resetPasswordTextF.borderStyle = UITextBorderStyleNone;
    _resetPasswordTextF.textAlignment = NSTextAlignmentCenter;
    _resetPasswordTextF.placeholder = @"新密码";
    
    _verifyCodeTextF = [[UITextField alloc] init];
    _verifyCodeTextF.font = [UIFont systemFontOfSize:14];
    _verifyCodeTextF.keyboardType = UIKeyboardTypePhonePad;
    _verifyCodeTextF.textColor = [UIColor colorWithHexString:@"303030"];
    _verifyCodeTextF.borderStyle = UITextBorderStyleNone;
    _verifyCodeTextF.textAlignment = NSTextAlignmentCenter;
    _verifyCodeTextF.placeholder = @"验证码";
    
    _sendVerifyCodeBtn = [[UIButton alloc] init];
    _sendVerifyCodeBtn.layer.cornerRadius = 3;
    _sendVerifyCodeBtn.layer.masksToBounds = YES;
    _sendVerifyCodeBtn.backgroundColor = [UIColor colorWithHexString:@"ff7c38"];
    [_sendVerifyCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    _sendVerifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [_sendVerifyCodeBtn addTarget:self action:@selector(sendResetVetifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHexString:@"eee"];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexString:@"eee"];
    
    UIView *line3 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexString:@"eee"];
    
    [self sd_addSubviews:@[_phoneTextF, _resetPasswordTextF, _verifyCodeTextF, _sendVerifyCodeBtn, line1, line2, line3, backToLogginContain, resetPasswordBtn]];
    
    backToLogginContain.sd_layout
    .topSpaceToView(self, 15)
    .rightSpaceToView(self, 15)
    .widthIs(15)
    .heightIs(15);
    
    resetPasswordBtn.sd_layout
    .bottomSpaceToView(self, 25)
    .centerXEqualToView(self)
    .widthRatioToView(self, 0.5)
    .heightIs(40);
    
    _phoneTextF.sd_layout
    .topSpaceToView(self, 80)
    .rightSpaceToView(self, 30)
    .leftSpaceToView(self, 30)
    .heightIs(40);
    
    line1.sd_layout
    .topSpaceToView(self.phoneTextF, 8)
    .rightSpaceToView(self, 25)
    .leftSpaceToView(self, 25)
    .heightIs(0.5);
    
    _resetPasswordTextF.sd_layout
    .topSpaceToView(line1, 8)
    .rightSpaceToView(self, 30)
    .leftSpaceToView(self, 30)
    .heightIs(40);
    
    line2.sd_layout
    .rightSpaceToView(self, 25)
    .leftSpaceToView(self, 25)
    .topSpaceToView(_resetPasswordTextF, 8)
    .heightIs(0.5);
    
    _verifyCodeTextF.sd_layout
    .topSpaceToView(line2, 8)
    .leftSpaceToView(self, 25)
    .rightSpaceToView(self, 25)
    .heightIs(40);
    
    _sendVerifyCodeBtn.sd_layout
    .rightSpaceToView(self, 30)
    .centerYEqualToView(_verifyCodeTextF)
    .heightIs(25)
    .widthIs(70);
    
    line3.sd_layout
    .topSpaceToView(_verifyCodeTextF, 8)
    .leftSpaceToView(self, 25)
    .rightSpaceToView(self, 25)
    .heightIs(0.5);
}

- (void)sendResetVetifyCode {
    if ([self.phoneTextF.text isBlankString]) {
        [self showAlertViewWithImage:@"手机号不能为空"];
        return;
    }
    
    if (![self.phoneTextF.text isMobileNumber]) {
        [self showAlertViewWithImage:@"请输入正确手机号"];
        return;
    }
    
    
    self.sendVerifyCodeBtn.enabled = NO;
    __weak typeof(self) ws = self;
    
//    [AVUser requestPasswordResetWithPhoneNumber:self.phoneTextF.text block:^(BOOL succeeded, NSError *error) {
//        // 发送失败可以查看 error 里面提供的信息
//        if (error) {
//            [self showAlertViewWithImage:(NSString *)error];
//        } else {
//            ws.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeSecondDown) userInfo:nil repeats:YES];
//        }
    
//    }];
}

- (void)loginBtnClick {
    if ([_resetPasswordTextF.text isBlankString]) {
        [self showAlertViewWithImage:@"请输入密码"];
        return;
    }
    
    if ([_verifyCodeTextF.text isBlankString]) {
        [self showAlertViewWithImage:@"请输入验证码"];
        return;
    }
    
    self.sendVerifyCodeBtn.enabled = NO;
    
//    [AVOSCloud requestSmsCodeWithPhoneNumber:self.phoneTextF.text callback:^(BOOL succeeded, NSError *error) {
//        if (error) {
//            [self showAlertViewWithImage:(NSString *)error];
//        } else {
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeSecondDown) userInfo:nil repeats:YES];
//        }
//    }];
}

- (void)backToLoginContainClick {
    if ([self.delegate respondsToSelector:@selector(forgotpwdContainerViewDidClickBack:)]) {
        [self.delegate forgotpwdContainerViewDidClickBack:self];
    }
    
    
}

- (void)timeSecondDown {
    if (self.timeseconds > 1) {
        self.timeseconds --;
        [_sendVerifyCodeBtn setTitle:[NSString stringWithFormat:@"%ld", self.timeseconds] forState:UIControlStateNormal];
    } else {
        [self.timer invalidate];
        [self.sendVerifyCodeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.timeseconds] forState:UIControlStateNormal];
    }
}

- (void)showAlertViewWithImage: (NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

@end
