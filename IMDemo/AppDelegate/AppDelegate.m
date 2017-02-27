//
//  AppDelegate.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "MainViewController.h"
#import "Header.h"
#import "Config.h"
#import "Marco.h"
#import "DataBaseHandler.h"

@interface AppDelegate ()
<UIAlertViewDelegate,
EMClientDelegate,
EMContactManagerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"notFirstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notFirstLaunch"];
        [[DataBaseHandler shareDataBase] createTable];
    }
    [self setupEMSDK:application options:launchOptions];
    [self autoLogin];
    [self setSVProgressHUD];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
}

#pragma mark - private method
- (void)autoLogin {
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        self.window.rootViewController = [[MainViewController alloc] init];
    } else {
        self.window.rootViewController = [[BaseTabBarController alloc] init];
    }
}

- (void)setSVProgressHUD {
    [SVProgressHUD setSuccessImage:IMAGE(@"ic_check")];
    [SVProgressHUD setErrorImage:IMAGE(@"ic_error")];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.9]];
    [SVProgressHUD setCornerRadius:5];
    [SVProgressHUD setMaximumDismissTimeInterval:1];
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 30)];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
}

- (void)setupEMSDK:(UIApplication *)application options:(NSDictionary *)options {
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:options
                                               appkey:EMSDK_APPKEY
                                         apnsCertName:@""
                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}

/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)userAccountDidLoginFromOtherDevice {
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"该账号已在其他设备上登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.window.rootViewController = [[MainViewController alloc] init];
    [UserManagers userLogout];
}

#pragma mark - EMClientDelegate
- (void)autoLoginDidCompleteWithError:(EMError *)aError {
    if (!aError) {
        [[EMClient sharedClient].options setIsAutoLogin:YES];
    } else {
        [[EMClient sharedClient].options setIsAutoLogin:NO];
    }
}

#pragma mark - ContactManagerDelegate
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage {
    Contact *contact = [[Contact alloc] init];
    contact.username = aUsername;
    contact.message = aMessage;
    [[DataBaseHandler shareDataBase] insertData:contact];
}





@end
