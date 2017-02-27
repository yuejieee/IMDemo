//
//  LoginViewController.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "BaseTabBarController.h"
#import "LRTextField.h"
#import <JVFloatLabeledTextField.h>
#import "Config.h"
#import "Header.h"
#import "Marco.h"

@interface LoginViewController ()

@property (nonatomic, strong) JVFloatLabeledTextField *tfAccount;

@property (nonatomic, strong) JVFloatLabeledTextField *tfPassword;

@property (nonatomic, strong) BaseButton *sureBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupPageSubviews];
    [self setupPageSubviewsProperty];
}

- (void)setupPageSubviews {
    self.tfAccount = [[JVFloatLabeledTextField alloc] init];
    [self.view addSubview:self.tfAccount];
    [self.tfAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(40 * kScale);
        make.left.mas_equalTo(self.view).offset(60 * kScale);
        make.right.mas_equalTo(self.view).offset(-60 * kScale);
        make.height.mas_equalTo(40 * kScale);
    }];
    
    self.tfPassword = [[JVFloatLabeledTextField alloc] init];
    [self.view addSubview:self.tfPassword];
    [self.tfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tfAccount.mas_bottom).offset(30 * kScale);
        make.left.mas_equalTo(self.view).offset(60 * kScale);
        make.right.mas_equalTo(self.view).offset(-60 * kScale);
        make.height.mas_equalTo(40 * kScale);
    }];
    
    self.sureBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tfPassword.mas_bottom).offset(40 * kScale);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(230 * kScale);
        make.height.mas_equalTo(40 * kScale);
    }];
}

- (void)setupPageSubviewsProperty {
    self.tfAccount.placeholder = @"请输入账号";
    self.tfAccount.font = FontWithSize(17);
    self.tfAccount.floatingLabelActiveTextColor = SELECTED_COLOR;
    
    self.tfPassword.placeholder = @"请输入密码";
    self.tfPassword.secureTextEntry = YES;
    self.tfPassword.font = FontWithSize(17);
    self.tfPassword.floatingLabelActiveTextColor = SELECTED_COLOR;
    
    self.sureBtn.titleLabel.font = FontWithSize(16);
    [self.sureBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundColor:SELECTED_COLOR forState:UIControlStateHighlighted];
    [self.sureBtn setBackgroundColor:DESELECTED_COLOR forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5 * kScale;
    [self.sureBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - private method
- (void)delayPresent {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:[[BaseTabBarController alloc] init] animated:YES completion:nil];
    });
}

#pragma mark - event response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tfAccount resignFirstResponder];
    [self.tfPassword resignFirstResponder];
}

- (void)loginAction {
    [UserManagers loginWithUsername:self.tfAccount.text
                           password:self.tfPassword.text
                         completion:^(BOOL success) {
                             if (success) {
                                 [self delayPresent];
                             }
                         }];
    [self.tfAccount resignFirstResponder];
    [self.tfPassword resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
