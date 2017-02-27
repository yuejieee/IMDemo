//
//  FriendsListViewController.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "FriendsListViewController.h"
#import "NewFriendsViewController.h"
#import "Header.h"
#import "Marco.h"
#import "Config.h"

@interface FriendsListViewController ()
<UIAlertViewDelegate>

@property (nonatomic, strong) UIView *headerView;

@end
@implementation FriendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"IMDemo";
    self.showRefreshHeader = YES;
    [self setupPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setupPageSubviews {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"add") style:UIBarButtonItemStyleDone target:self action:@selector(addFriends)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"comment") style:UIBarButtonItemStyleDone target:self action:@selector(newFriends)];
}

#pragma mark - event response
- (void)addFriends {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入要添加用户账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView show];
}

- (void)newFriends {
    [self.navigationController pushViewController:[[NewFriendsViewController alloc] init] animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UITextField *tfUsername = [alertView textFieldAtIndex:0];
    if (buttonIndex == 1) {
        [UserManagers addFriendsWithUsername:tfUsername.text completion:^(BOOL success) {
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
