//
//  IHTTracker.h
//  IHTrafficFramework
//
//  Created by sun wayde on 5/20/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IHTUser;
@interface IHTTracker : NSObject

#pragma mark - AppKey
+ (void)startWithAppKey:(NSString *)appKey;
+ (void)trackUser:(IHTUser *)user;

#pragma mark - ViewController
+ (void)beginLogViewController:(NSString *)vcName;
+ (void)endLogViewController:(NSString *)vcName;

#pragma mark - Event
+ (void)event:(NSString *)eventName triggered:(NSString *)vcName;

#pragma mark - User
+ (void)userLogin:(NSString *)userId;
+ (void)userLogout:(NSString *)userId;

@end
