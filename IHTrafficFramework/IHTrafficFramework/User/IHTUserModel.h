//
//  IHTUserModel.h
//  IHTrafficFramework
//
//  Created by sun wayde on 5/22/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IHTUser.h"

typedef enum {
    EIHTLoginStatusSuccess = 1,
    EIHTLoginStatusFailure,
    EIHTLogoutStatusSuccess,
    EIHTLogoutStatusFailure,
    EIHTRegisterStatusSuccess,
    EIHTRegisterStatusFailure
}EIHTLogStatus;

@interface IHTUserModel : NSObject

typedef void(^LogBlockHandler)(EIHTLogStatus status, IHTUser *user);
typedef void(^RegisterBlockHandler)(EIHTLogStatus status, NSDictionary *response);

- (BOOL)doCallLoginService:(NSDictionary *)paras onCompletionHandler:(LogBlockHandler)completion;
- (BOOL)doCallLogoutService:(NSDictionary *)paras onCompletionHandler:(LogBlockHandler)completion;
- (BOOL)doCallRegisterService:(NSDictionary *)paras onCompletionHandler:(RegisterBlockHandler)completion;

@end
