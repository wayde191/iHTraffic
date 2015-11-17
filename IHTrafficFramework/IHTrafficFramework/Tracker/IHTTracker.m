//
//  IHTTracker.m
//  IHTrafficFramework
//
//  Created by sun wayde on 5/20/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import "IHTTracker.h"
#import "IHTUser.h"
#import "IHTRequest.h"
#import "IHTServices.h"
#import "IHTLog.h"
#import "IHTCommonMacros.h"
#import "IHTRequestResponseSuccess.h"
#import "IHTRequestResponseFailure.h"

#import <UIKit/UIKit.h>

#define IHT_TRACKER_UUID            @"IHTrafficFrameworkTrackerUUID"
#define IHT_TRACKER_SERVICE         @"IHTTracker"

static IHTTracker *singletonInstance = nil;

typedef enum {
    ETrackTypeViewControllerBegin = 1,
    ETrackTypeViewControllerEnd,
    ETrackTypeEvent,
    ETrackTypeLogin,
    ETrackTypeLogout,
}ETrackType;

@interface IHTTracker (){
}

@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) IHTUser *user;

@end

@implementation IHTTracker

#pragma mark - Class Methods
#pragma mark - AppKey
+ (void)startWithAppKey:(NSString *)appKey {
    [IHTTracker sharedInstance].appKey = appKey;
}

+ (void)trackUser:(IHTUser *)user {
    [IHTTracker sharedInstance].user = user;
}

#pragma mark - ViewController
+ (void)beginLogViewController:(NSString *)vcName {
    [[IHTTracker sharedInstance] track:vcName withType:ETrackTypeViewControllerBegin];
}

+ (void)endLogViewController:(NSString *)vcName {
    [[IHTTracker sharedInstance] track:vcName withType:ETrackTypeViewControllerEnd];
}

#pragma mark - Event
+ (void)event:(NSString *)eventName triggered:(NSString *)vcName {
    [[IHTTracker sharedInstance] track:[NSString stringWithFormat:@"%@_%@", vcName, eventName] withType:ETrackTypeEvent];
}

#pragma mark - User
+ (void)userLogin:(NSString *)userId {
    [[IHTTracker sharedInstance] track:userId withType:ETrackTypeLogin];
}

+ (void)userLogout:(NSString *)userId {
    [[IHTTracker sharedInstance] track:userId withType:ETrackTypeLogout];
}

#pragma mark - Private Methods
- (BOOL)track:(NSString *)eventName withType:(ETrackType)type {
    NSString *uuid = [IHT_USER_DEFAULT objectForKey:IHT_TRACKER_UUID];
    if (!uuid) {
        uuid = [self getUUID];
        [IHT_USER_DEFAULT setObject:uuid forKey:IHT_TRACKER_UUID];
        [IHT_USER_DEFAULT synchronize];
    }
    NSString *uid = _user ? _user.userID : @"-1"; //TODO ERROR
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    appVersion = appVersion ? appVersion : @"1.0";
    
    __block BOOL responseHasArrived = NO;
    IHTRequest *request = [IHTRequest
                           requestWithName:IHT_TRACKER_SERVICE
                           forServiceUrl:IHT_SERVICE_TRACKER
                           withRequestBlock:^(IHTRequest *request, ERequestingStatus requestingStatus, IHTRequestResponseSuccess *responseSuccess, IHTRequestResponseFailure *responseFailed) {
                               
                               responseHasArrived = YES;
                               
                               switch (requestingStatus) {
                                   case ERequestingStarted:
                                       //TODO
                                       break;
                                   case ERequestingFinished:
                                   {
                                       IHTLOGINFO(@"%@", responseSuccess.userInfo);
                                   }
                                       break;
                                   case ERequestingFailed:
                                       //TODO
                                       break;
                                   case ERequestingCanceled:
                                       //TODO
                                       break;
                                       
                                   default:
                                       break;
                               }
                           }];
    [request startWithParameters:@{@"user_id":uid,
                                   @"uuid":uuid,
                                   @"appKey":_appKey,
                                   @"version":appVersion,
                                   @"eventName":eventName,
                                   @"eventLevel":[NSString stringWithFormat:@"%d", type],
                                   @"language":[[NSLocale preferredLanguages] objectAtIndex:0],
                                   @"platform":[UIDevice currentDevice].systemName,
                                   @"os":[UIDevice currentDevice].systemVersion,
                                   @"device":[UIDevice currentDevice].localizedModel,
                                   @"sCode":IHT_TRACKER_SCODE}
                 byRequestMethod:ERequestMethodPost];
    
#if IHT_APP_PRODUCTION_ENVIRONMENT == 0
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    while (responseHasArrived == NO && ([timeoutDate timeIntervalSinceNow] > 0)) {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, YES);
    }
#endif
    
    return responseHasArrived;
}

+ (IHTTracker *)sharedInstance {
    @synchronized(self){
        if (!singletonInstance) {
            singletonInstance = [[IHTTracker alloc] init];
        }
        
        return singletonInstance;
    }
    
    return nil;
}

- (NSString *)getUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}



@end
