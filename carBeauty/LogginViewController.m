//
//  LogginViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/20.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "LogginViewController.h"
#import <Chameleon.h>
#import <UIView+SDAutoLayout.h>
#import "ForgotpwdContainerView.h"
#import "RegisterContainerView.h"
#import "ContainerView.h"
#import "heeTabBarControl.h"

@interface LogginViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, ForgotpwdContainerViewDelegate, RegisterContainerViewDelegate>

@property (nonatomic, strong) UIButton *avatar;
@property (nonatomic, strong) UITextField *userNameTextF;
@property (nonatomic, strong) UITextField *passwordTextF;
@property (nonatomic, strong) ContainerView *containerView;

@property(nonatomic, strong) RegisterContainerView *registerContainView;
@property(nonatomic, strong) ForgotpwdContainerView *forgotpwdContainView;

@end

@implementation LogginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:self.view.bounds andColors:@[[UIColor colorWithHexString:@"0081f1"], [UIColor colorWithHexString:@"efefef"]]];     //
    
    [self layoutSubView];
}

- (ForgotpwdContainerView *)forgotpwdContainView {
    if (!_forgotpwdContainView) {
        ForgotpwdContainerView *forgotpwdContainView = [[ForgotpwdContainerView alloc] init];
        self.forgotpwdContainView = forgotpwdContainView;
        forgotpwdContainView.delegate = self;
        [self.view addSubview:forgotpwdContainView];
        forgotpwdContainView.sd_layout
        .leftSpaceToView(self.view, - (self.view.width - 60))
        .rightSpaceToView(self.view, self.view.width)
        .heightIs(self.view.height / 2 + 40)
        .topSpaceToView(self.view, self.view.height / 4);
        
    }
    
    return  _forgotpwdContainView;
}

- (RegisterContainerView *)registerContainView {
    if (!_registerContainView) {
        RegisterContainerView *registerContainView = [[RegisterContainerView alloc] init];
        self.registerContainView = registerContainView;
        [self.view addSubview:registerContainView];
        registerContainView.delegate = self;
        registerContainView.sd_layout
        .leftSpaceToView(self.view, self.view.width)
        .rightSpaceToView(self.view, -(self.view.width - 60))
        .heightIs(self.view.height / 2 + 40)
        .topSpaceToView(self.view, self.view.height / 4);
    }
    return _registerContainView;
}

- (void)layoutSubView {
    
    [self.view addSubview:self.registerContainView];
    [self.view addSubview:self.forgotpwdContainView];
    
    ContainerView *containerView = [[ContainerView alloc] init];
    self.containerView = containerView;
    containerView.layer.cornerRadius = 15;
    containerView.layer.masksToBounds = YES;
    containerView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    containerView.layer.borderWidth = 0.5;
    containerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.35];
    
    [self.view sd_addSubviews:@[containerView]];
    containerView.sd_layout
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .heightRatioToView(self.view, 0.5)
    .topSpaceToView(self.view, self.view.height / 4);
    
    
    _avatar = [UIButton buttonWithType:UIButtonTypeSystem];
    _avatar.layer.cornerRadius = 75/2;
    _avatar.layer.masksToBounds = YES;
    [_avatar setImage:[[UIImage imageNamed:@"headIMG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    _avatar.tag = 1001;
    [_avatar addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchDown];
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"0081f1"];
    loginBtn.layer.cornerRadius = 7.5;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.75].CGColor;
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _userNameTextF = [[UITextField alloc] init];
    _userNameTextF.borderStyle = UITextBorderStyleNone;
    _userNameTextF.font = [UIFont systemFontOfSize:14];
    _userNameTextF.textColor = [UIColor colorWithHexString:@"303030"];
    _userNameTextF.placeholder = @"手机号";
    _userNameTextF.textAlignment = NSTextAlignmentCenter;
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHexString:@"eee"];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexString:@"eee"];
    
    _passwordTextF = [[UITextField alloc] init];
    _passwordTextF.borderStyle = UITextBorderStyleNone;
    _passwordTextF.textColor = [UIColor colorWithHexString:@"303030"];
    _passwordTextF.secureTextEntry = YES;
    _passwordTextF.placeholder = @"密码";
    _passwordTextF.font = [UIFont systemFontOfSize:14];
    _passwordTextF.textAlignment = NSTextAlignmentCenter;
    
    UIButton *forgetBtn = [[UIButton alloc] init];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"ff7c38"] forState:UIControlStateNormal];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerBtn = [[UIButton alloc] init];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"ff7c38"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [containerView sd_addSubviews:@[_avatar, loginBtn, _userNameTextF, _passwordTextF, line1, line2, forgetBtn, registerBtn]];
    
    _avatar.sd_layout
    .topSpaceToView(containerView, 25)
    .widthIs(75)
    .heightIs(75)
    .centerXEqualToView(containerView);
    
    loginBtn.sd_layout
    .bottomSpaceToView(containerView, 25)
    .centerXEqualToView(containerView)
    .widthRatioToView(containerView, 0.5)
    .heightIs(40);
    
    _userNameTextF.sd_layout
    .leftSpaceToView(containerView, 30)
    .rightSpaceToView(containerView, 30)
    .topSpaceToView(self.avatar, 15)
    .heightIs(40);
    
    
    line1.sd_layout
    .leftSpaceToView(containerView, 25)
    .rightSpaceToView(containerView, 25)
    .topSpaceToView(_userNameTextF, 3)
    .heightIs(.5);
    
    _passwordTextF.sd_layout
    .leftSpaceToView(containerView, 30)
    .rightSpaceToView(containerView, 30)
    .topSpaceToView(line1, 15)
    .heightIs(40);
    
    line2.sd_layout
    .leftSpaceToView(containerView, 25)
    .rightSpaceToView(containerView, 25)
    .topSpaceToView(_passwordTextF, 3)
    .heightIs(.5);
    
    forgetBtn.sd_layout
    .topSpaceToView(line2, 10)
    .leftEqualToView(line2)
    .heightIs(15)
    .widthIs(100);
    
    registerBtn.sd_layout
    .topSpaceToView(line2, 10)
    .rightEqualToView(line2)
    .heightIs(15)
    .widthIs(100);
}

- (void)chooseImage {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.allowsEditing = YES;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIButton *button = (UIButton *)[self.view viewWithTag:1001];
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [button setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    button.layer.cornerRadius = 75 / 2;
    button.layer.masksToBounds = YES;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)forgetBtnClick {
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.alpha = 0;
        self.forgotpwdContainView.sd_layout
        .leftSpaceToView(self.view, 30)
        .rightSpaceToView(self.view, 30);
        [self.forgotpwdContainView updateLayout];
        NSLog(@"show forgotpwdContainView");
    }];
}

- (void)registerBtnClick {
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.alpha = 0;
        self.registerContainView.sd_layout
        .leftSpaceToView(self.view, 30)
        .rightSpaceToView(self.view, 30);
        [self.registerContainView updateLayout];
        NSLog(@"show registerContainView");
    }];
    //    self.loginState = LoginStateRegister;
}

- (void)loginBtnClick {
    if ([_userNameTextF.text isEqualToString:@"" ]|| [_passwordTextF.text isEqualToString:@""]) {
        [self showAlertViewWithInfo:@"请输入用户名／密码"];
    }
    
    //处理发送验证码 
//    [AVUser logInWithUsernameInBackground:self.userNameTextF.text password:self.passwordTextF.text block:^(AVUser *user, NSError *error) {
//        if (user != nil) {
//            
//        } else {
//            [self showAlertViewWithInfo:@"用户名/密码错误"];
//        }
//    }];
    if ([_userNameTextF.text isEqualToString:@"18269772521" ] && [_passwordTextF.text isEqualToString:@"123123"]) {
        [self showAlertViewWithInfo:@"登录成功"];
    }
}

- (void)showAlertViewWithInfo: (NSString *) message {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定");
    }]];
    
    [self presentViewController:alertView animated:YES completion:nil];
}

//点击注册按钮
- (void)registerContainerViewDidClickSure: (ForgotpwdContainerView *)container {
    [UIView animateWithDuration:0.25 animations:^{
        self.registerContainView.sd_layout
        .rightSpaceToView(self.view, -(self.view.width - 60))
        .leftSpaceToView(self.view, self.view.width);
        [self.forgotpwdContainView updateLayout];
    }];
}

//点击了返回
- (void)registerContainerViewDidClickBack: (ForgotpwdContainerView *)container {
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.alpha = 1;
        
        self.registerContainView.sd_layout
        .rightSpaceToView(self.view, -(self.view.width - 60))
        .leftSpaceToView(self.view, self.view.width);
        [self.forgotpwdContainView updateLayout];
    }];
}

- (void)forgotpwdContainerViewDidClickBack:(ForgotpwdContainerView *)container {
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.alpha = 1;
        
        self.forgotpwdContainView.sd_layout
        .leftSpaceToView(self.view, -(self.view.width - 60))
        .rightSpaceToView(self.view, self.view.width);
        [self.forgotpwdContainView updateLayout];
    }];
}

- (void)forgotpwdContainerViewDidClickSure:(ForgotpwdContainerView *)container {
    [UIView animateWithDuration:0.25 animations:^{
        self.forgotpwdContainView.sd_layout
        .leftSpaceToView(self.view, -(self.view.width - 60))
        .rightSpaceToView(self.view, self.view.width);
        [self.forgotpwdContainView updateLayout];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
