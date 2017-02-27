//
//  BaseNavigationController.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Config.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:SELECTED_COLOR, NSFontAttributeName:[UIFont fontWithName:@"Lobster1.4" size:19]}];
    [[UINavigationBar appearance] setTintColor:SELECTED_COLOR];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
