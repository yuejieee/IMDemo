//
//  UserManagers.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "UserManagers.h"
#import <SVProgressHUD.h>

@implementation UserManagers
// 登录
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(BOOL))completion {
    [SVProgressHUD showWithStatus:@"登录中..."];
    [[EMClient sharedClient] loginWithUsername:username
                                      password:password
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            [[EMClient sharedClient].options setIsAutoLogin:YES];
                                            [SVProgressHUD showImage:nil status:@"登录成功"];
                                            completion(YES);
                                        } else {
                                            [SVProgressHUD showImage:nil status:aError.errorDescription];
                                            completion(NO);
                                        }
                                    }];
}

+ (void)registerWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(BOOL))completion {
    [SVProgressHUD showWithStatus:@"注册中..."];
    [[EMClient sharedClient] registerWithUsername:username
                                         password:password
                                       completion:^(NSString *aUsername, EMError *aError) {
                                           if (!aError) {
                                               [SVProgressHUD showImage:nil status:@"注册成功，请登录"];
                                               completion(YES);
                                           } else {
                                               [SVProgressHUD showImage:nil status:aError.errorDescription];
                                               completion(NO);
                                           }
    }];
}

+ (void)addFriendsWithUsername:(NSString *)username completion:(void (^)(BOOL))completion {
    NSArray *array = [UserManagers getAllFriends];
    BOOL isFriend = [array containsObject:username];
    if (!isFriend) {
        [[EMClient sharedClient].contactManager addContact:username
                                                   message:@"我想加您为好友"
                                                completion:^(NSString *aUsername, EMError *aError) {
                                                    if (!aError) {
                                                        [SVProgressHUD showImage:nil status:@"请求发送成功"];
                                                        completion(YES);
                                                    } else {
                                                        [SVProgressHUD showImage:nil status:aError.errorDescription];
                                                        completion(NO);
                                                    }
                                                }];
    } else {
        [SVProgressHUD showImage:nil status:@"已经是好友"];
    }
}

+ (void)acceptFriendsForUsername:(NSString *)username completion:(void (^)(BOOL))completion {
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:username];
    if (!error) {
        completion(YES);
    } else {
        completion(NO);
    }
}

+ (NSArray *)getAllFriends {
    NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:nil];
    return userlist;
}

+ (void)userLogout {
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        [SVProgressHUD showImage:nil status:@"注销成功"];
    }
}

@end
