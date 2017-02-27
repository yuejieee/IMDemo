//
//  BaseTabBarController.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "BaseTabBarController.h"
#import "ChatListViewController.h"
#import "FriendsListViewController.h"
#import "BaseNavigationController.h"
#import "Config.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    ChatListViewController *chatListVC = [[ChatListViewController alloc] init];
    [self addChildController:chatListVC image:@"modify" selectedImage:@"" title:@"IM"];
    
    FriendsListViewController *friendsVC = [[FriendsListViewController alloc] init];
    [self addChildController:friendsVC image:@"address_book" selectedImage:@"" title:@"好友"];
}

- (void)addChildController:(UIViewController *)viewController image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    BaseNavigationController *naVC = [[BaseNavigationController alloc] initWithRootViewController:viewController];
    naVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    naVC.tabBarItem.image = [UIImage imageNamed:image];
    
    self.tabBar.tintColor = SELECTED_COLOR;
    // 未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:DESELECTED_COLOR, NSForegroundColorAttributeName, nil] forState: UIControlStateNormal];
    // 选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:SELECTED_COLOR,NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    naVC.title = title;
    [self addChildViewController:naVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
