//
//  IHTUserModel.m
//  IHTrafficFramework
//
//  Created by sun wayde on 5/22/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import "IHTUserModel.h"
#import "IHTTracker.h"
#import "IHTRequest.h"
#import "IHTRequestResponseSuccess.h"
#import "IHTRequestResponseFailure.h"
#import "IHTServices.h"
#import "IHTCommonMacros.h"
#import "IHTLog.h"

#define IHT_USER_LOGIN_SERVICE          @"IHTUserLoginService"
#define IHT_USER_LOGOUT_SERVICE         @"IHTUserLogoutService"
#define IHT_USER_REGISTER_SERVICE       @"IHTUserRegisterService"

@implementation IHTUserModel

- (BOOL)doCallRegisterService:(NSDictionary *)paras onCompletionHandler:(RegisterBlockHandler)completion {
    
    __block BOOL responseHasArrived = NO;
    IHTRequest *request = [IHTRequest
                           requestWithName:IHT_USER_REGISTER_SERVICE
                           forServiceUrl:IHT_SERVICE_REGISTER
                           withRequestBlock:^(IHTRequest *request, ERequestingStatus requestingStatus, IHTRequestResponseSuccess *responseSuccess, IHTRequestResponseFailure *responseFailed) {
                               
                               responseHasArrived = YES;
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   switch (requestingStatus) {
                                       case ERequestingStarted:
                                           //TODO
                                           break;
                                       case ERequestingFinished:
                                       {
                                           completion(EIHTRegisterStatusSuccess, responseSuccess.userInfo[@"data"]);
                                       }
                                           break;
                                       case ERequestingFailed:
                                           completion(EIHTRegisterStatusFailure, responseSuccess.userInfo[@"data"]);
                                           break;
                                       case ERequestingCanceled:
                                           //TODO
                                           break;
                                           
                                       default:
                                           break;
                                   }
                               });
                           }];
    
    [request startWithParameters:@{@"ihakulaID":paras[@"ihakulaID"],
                                   @"password":paras[@"password"],
                                   @"confirmPwd":paras[@"confirmPwd"],
                                   @"nickname":paras[@"nickname"],
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

- (BOOL)doCallLoginService:(NSDictionary *)paras onCompletionHandler:(LogBlockHandler)completion {
    [IHTTracker userLogin:paras[@"ihakulaID"]];
    
    __block BOOL responseHasArrived = NO;
    IHTRequest *request = [IHTRequest
                           requestWithName:IHT_USER_LOGIN_SERVICE
                           forServiceUrl:IHT_SERVICE_LOGIN
                           withRequestBlock:^(IHTRequest *request, ERequestingStatus requestingStatus, IHTRequestResponseSuccess *responseSuccess, IHTRequestResponseFailure *responseFailed) {
                               
                               responseHasArrived = YES;
                               dispatch_async(dispatch_get_main_queue(), ^{
                               switch (requestingStatus) {
                                   case ERequestingStarted:
                                       //TODO
                                       break;
                                   case ERequestingFinished:
                                   {
                                       IHTUser *user = [[IHTUser alloc] initWithUserDic:responseSuccess.userInfo[@"data"][@"user"]];
                                       [IHTTracker trackUser:user];
                                       completion(EIHTLoginStatusSuccess, user);
                                   }
                                       break;
                                   case ERequestingFailed:
                                       completion(EIHTLoginStatusFailure, nil);
                                       break;
                                   case ERequestingCanceled:
                                       //TODO
                                       break;
                                       
                                   default:
                                       break;
                               }
                               });
                           }];
    [request startWithParameters:@{@"ihakulaID":paras[@"ihakulaID"],
                                   @"password":paras[@"password"],
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

- (BOOL)doCallLogoutService:(NSDictionary *)paras onCompletionHandler:(LogBlockHandler)completion {
    [IHTTracker userLogout:paras[@"ihakulaID"]];
    
    __block BOOL responseHasArrived = NO;
    IHTRequest *request = [IHTRequest
                           requestWithName:IHT_USER_LOGOUT_SERVICE
                           forServiceUrl:IHT_SERVICE_LOGOUT
                           withRequestBlock:^(IHTRequest *request, ERequestingStatus requestingStatus, IHTRequestResponseSuccess *responseSuccess, IHTRequestResponseFailure *responseFailed) {
                               
                               responseHasArrived = YES;
                               dispatch_async(dispatch_get_main_queue(), ^{
                               switch (requestingStatus) {
                                   case ERequestingStarted:
                                       //TODO
                                       break;
                                   case ERequestingFinished:
                                   {
                                        completion(EIHTLoginStatusSuccess, nil);
                                   }
                                       break;
                                   case ERequestingFailed:
                                       completion(EIHTLoginStatusFailure, nil);
                                       break;
                                   case ERequestingCanceled:
                                       //TODO
                                       break;
                                       
                                   default:
                                       break;
                               }
                               });
                           }];
    [request startWithParameters:@{@"sCode":IHT_TRACKER_SCODE}
                 byRequestMethod:ERequestMethodPost];
    
#if IHT_APP_PRODUCTION_ENVIRONMENT == 0
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    while (responseHasArrived == NO && ([timeoutDate timeIntervalSinceNow] > 0)) {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, YES);
    }
#endif
    
    return responseHasArrived;
}

@end
