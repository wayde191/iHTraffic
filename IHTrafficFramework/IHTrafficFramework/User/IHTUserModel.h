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
}EIHTLogStatus;

@interface IHTUserModel : NSObject

typedef void(^LogBlockHandler)(EIHTLogStatus status, IHTUser *user);

- (BOOL)doCallLoginService:(NSDictionary *)paras onCompletionHandler:(LogBlockHandler)completion;
- (BOOL)doCallLogoutService:(NSDictionary *)paras onCompletionHandler:(LogBlockHandler)completion;

@end
