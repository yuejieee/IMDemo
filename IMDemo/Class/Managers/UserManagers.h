//
//  UserManagers.h
//  IMDemo
//
//  Created by 岳杰 on 2017/2/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Hyphenate_CN/EMSDK.h>

@interface UserManagers : NSObject

+ (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void(^)(BOOL success))completion;

+ (void)registerWithUsername:(NSString *)username password:(NSString *)password completion:(void(^)(BOOL success))completion;

+ (void)addFriendsWithUsername:(NSString *)username completion:(void(^)(BOOL success))completion;

+ (void)acceptFriendsForUsername:(NSString *)username completion:(void(^)(BOOL success))completion;

+ (NSArray *)getAllFriends;

+ (void)userLogout;
@end
