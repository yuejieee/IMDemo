//
//  ChatListViewController.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "ChatListViewController.h"
#import "MainViewController.h"
#import "Marco.h"
#import "Header.h"
#import "Config.h"

@interface ChatListViewController ()
<UIAlertViewDelegate>

@end

@implementation ChatListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"IMDemo";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //首次进入加载数据
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)logout {
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否注销" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [UserManagers userLogout];
        MainViewController *mainVC = [[MainViewController alloc] init];
        mainVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:mainVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
