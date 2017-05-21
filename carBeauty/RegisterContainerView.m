//
//  RegisterContainerView.m
//  carBeauty
//
//  Created by apple7 on 17/4/20.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "RegisterContainerView.h"
#import <Chameleon.h>
#import <UIView+SDAutoLayout.h>
#import "NSString+RegexCategory.h"

@interface RegisterContainerView()
@property (nonatomic, strong) UITextField *userNameTextF;
@property (nonatomic, strong) UITextField *phoneTextF;
@property (nonatomic, strong) UITextField *passwordTextF;
@property (nonatomic, strong) UITextField *verifyCodeTextF;
@property (nonatomic, assign) NSInteger timeseconds;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *sendVerifyCodeBtn;
@property (nonatomic, copy) NSString *verifyCode;

@end

@implementation RegisterContainerView
- (instancetype)init {
    if (self = [super init]) {
        self.timeseconds = 60;
        [self setSubView];
    }
    return self;
}

- (void)setSubView {
    //    [super setSubView];
    
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds =YES;
    self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.35];
    self.layer.borderWidth = 0.5;
    
    UIButton *back = [[UIButton alloc] init];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchDown];
    
    UIButton *avatar = [UIButton buttonWithType:UIButtonTypeSystem];
    [avatar setImage:[[UIImage imageNamed:@"headImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    avatar.tag = 1001;
    [avatar addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchDown];
    
    UIButton *registerBtn = [[UIButton alloc] init];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor colorWithHexString:@"0081f1"];
    registerBtn.layer.cornerRadius = 7.5;
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.75].CGColor;
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _userNameTextF = [[UITextField alloc] init];
    _userNameTextF.keyboardType = UIKeyboardTypePhonePad;
    _userNameTextF.borderStyle = UITextBorderStyleNone;
    _userNameTextF.font = [UIFont systemFontOfSize:14];
    _userNameTextF.textColor = [UIColor colorWithHexString:@"303030"];
    _userNameTextF.placeholder = @"昵称";
    _userNameTextF.textAlignment = NSTextAlignmentCenter;
    
    _phoneTextF = [[UITextField alloc] init];
    _phoneTextF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextF.borderStyle = UITextBorderStyleNone;
    _phoneTextF.font = [UIFont systemFontOfSize:14];
    _phoneTextF.textColor = [UIColor colorWithHexString:@"303030"];
    _phoneTextF.placeholder = @"手机号";
    _phoneTextF.textAlignment = NSTextAlignmentCenter;
    
    _passwordTextF = [[UITextField alloc] init];
    _passwordTextF.keyboardType = UIKeyboardTypePhonePad;
    _passwordTextF.borderStyle = UITextBorderStyleNone;
    _passwordTextF.font = [UIFont systemFontOfSize:14];
    _passwordTextF.textColor = [UIColor colorWithHexString:@"303030"];
    _passwordTextF.secureTextEntry = YES;
    _passwordTextF.placeholder = @"密码";
    _passwordTextF.textAlignment = NSTextAlignmentCenter;
    
    _verifyCodeTextF = [[UITextField alloc] init];
    _verifyCodeTextF.borderStyle = UITextBorderStyleNone;
    _verifyCodeTextF.font = [UIFont systemFontOfSize:14];
    _verifyCodeTextF.textColor = [UIColor colorWithHexString:@"303030"];
    //    verifyCodeTextF.secureTextEntry = YES;
    _verifyCodeTextF.placeholder = @"验证码";
    _verifyCodeTextF.textAlignment = NSTextAlignmentCenter;
    
    _sendVerifyCodeBtn = [[UIButton alloc] init];
    _sendVerifyCodeBtn.layer.cornerRadius = 3;
    _sendVerifyCodeBtn.layer.masksToBounds = YES;
    [_sendVerifyCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    _sendVerifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    _sendVerifyCodeBtn.backgroundColor = [UIColor colorWithHexString:@"ff7c38"];
    [_sendVerifyCodeBtn addTarget:self action:@selector(sendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHexString:@"eee"];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexString:@"eee"];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithHexString:@"eee"];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor colorWithHexString:@"eee"];
    
    [self sd_addSubviews:@[back, avatar, _userNameTextF, _passwordTextF, _phoneTextF, _verifyCodeTextF, _sendVerifyCodeBtn, registerBtn, line1, line2, line3, line4]];
    
    back.sd_layout
    .topSpaceToView(self,15)
    .leftSpaceToView(self,15)
    .heightIs(15)
    .widthIs(15);
    
    avatar.sd_layout
    .topSpaceToView(self,24)
    .widthIs(75)
    .heightIs(75).
    centerXEqualToView(self);
    
    registerBtn.sd_layout
    .bottomSpaceToView(self,24)
    .centerXEqualToView(self)
    .heightIs(40)
    .widthRatioToView(self,0.5);
    
    _userNameTextF.sd_layout
    .leftSpaceToView(self,30)
    .rightSpaceToView(self,30)
    .topSpaceToView(avatar,15)
    .heightIs(30);
    
    line1.sd_layout
    .leftSpaceToView(self,25)
    .rightSpaceToView(self,25)
    .topSpaceToView(_userNameTextF,3)
    .heightIs(.5);
    
    _phoneTextF.sd_layout
    .leftSpaceToView(self,30)
    .rightSpaceToView(self,30)
    .topSpaceToView(line1,8)
    .heightIs(30);
    
    line2.sd_layout
    .leftSpaceToView(self,25)
    .rightSpaceToView(self,25)
    .topSpaceToView(_phoneTextF,3)
    .heightIs(.5);
    
    _passwordTextF.sd_layout
    .leftSpaceToView(self,30)
    .rightSpaceToView(self,30)
    .topSpaceToView(line2,8)
    .heightIs(30);
    
    line3.sd_layout
    .leftSpaceToView(self,25)
    .rightSpaceToView(self,25)
    .topSpaceToView(_passwordTextF,3)
    .heightIs(.5);
    
    
    _verifyCodeTextF.sd_layout
    .leftSpaceToView(self,30)
    .rightSpaceToView(self,30)
    .topSpaceToView(line3,8)
    .heightIs(30);
    
    _sendVerifyCodeBtn.sd_layout
    .rightSpaceToView(self, 35)
    .heightIs(22)
    .centerYEqualToView(_verifyCodeTextF)
    .widthIs(70);
    
    line4.sd_layout
    .leftSpaceToView(self,25)
    .rightSpaceToView(self,25)
    .topSpaceToView(_verifyCodeTextF,8)
    .heightIs(.5);
}

-(void)backBtnClick {
    if ([self.delegate respondsToSelector:@selector(registerContainerViewDidClickBack:)]) {
        [self.delegate registerContainerViewDidClickBack:self];
    }
}
- (void)chooseImage {
    
    //选择图片 （无controller）
    
    //    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    //    pickerController.allowsEditing = YES;
    //    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    pickerController.delegate = self;
    //    [self.navigationController presentViewController:pickerController animated:YES completion:^{
    //
    //    }];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    UIButton *button = (UIButton *)[self.view viewWithTag:1001];
//    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    [button setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    button.layer.cornerRadius = 75 / 2;
//    button.layer.masksToBounds = YES;
//
//}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//}


- (void)registerBtnClick {
    //    if ([self.verifyCode isBlankString]) {
    //
    //    }
    
    
    if ([self.verifyCodeTextF.text isBlankString]) {
        [self showAlertViewWithMessage:@"请输入验证码"];
        return;
    }
    
    if ([self.userNameTextF.text isBlankString]) {
        [self showAlertViewWithMessage:@"请输入用户名"];
        return;
    }
    
    if ([self.passwordTextF.text isBlankString]) {
        [self showAlertViewWithMessage:@"请输入密码"];
        return;
    }
    
    if ([self.userNameTextF.text  isEqual: @"xia"]&&[self.passwordTextF.text  isEqual: @"123123"]) {
        [self showAlertViewWithMessage:@"注册成功返回登录"];
    }
}

- (void)sendVerifyCode {
    if ([self.phoneTextF.text isBlankString]) {
        [self showAlertViewWithMessage:@"请输入手机号"];
        return;
    }
    if (![self.phoneTextF.text isMobileNumber]) {
        [self showAlertViewWithMessage:@"请输入正确的手机号"];
        return;
    }
    self.sendVerifyCodeBtn.enabled = NO;
    
    
    //处理发送验证码的逻辑
//    __weak typeof(self) hself = self;
//    [AVOSCloud requestSmsCodeWithPhoneNumber:self.phoneTextF.text callback:^(BOOL succeeded, NSError *error) {
//        if (error) {
//            [self showAlertViewWithMessage:(NSString *)error];
//        } else {
//            hself.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timescecondsDown) userInfo:nil repeats:YES];
//        }
//    }];
    [self showAlertViewWithMessage:@"发送成功"];
}

- (void)timescecondsDown {
    if (self.timeseconds > 1) {
        self.timeseconds --;
        [self.sendVerifyCodeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.timeseconds] forState:UIControlStateNormal];
    } else {
        [self.timer invalidate];
        [self.sendVerifyCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.sendVerifyCodeBtn.enabled = YES;
    }
}

- (void)showAlertViewWithMessage: (NSString *)message {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    
}

@end
