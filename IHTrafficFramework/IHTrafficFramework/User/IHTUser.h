//
//  IHTUser.h
//  IHTrafficFramework
//
//  Created by Wayde Sun on 4/30/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    EIHTUserRoleAnonymous = 1,
    EIHTUserRoleOrdinaryMember = 2,
    EIHTUserRoleVip = 3,
    EIHTUserRoleAdministrator = 4,
    
} EIHTUserRole;

typedef enum {
    EIHTUserPlatformIHakula = 0,
    EIHTUserPlatformQQ = 1,
    EIHTUserPlatformWeChat = 2,
    EIHTUserPlatformSina = 3,
    EIHTUserPlatform163 = 4,
    
} EIHTUserPlatform;

typedef enum {
    EIHTLoginStatePasswordNotCorrect = 909,
    EIHTLoginStateEmailNotExist = 910,
} EIHTLoginErrorState;

@interface IHTUser : NSObject

@property (nonatomic, assign) EIHTLoginErrorState loginState;
@property (nonatomic, assign) EIHTUserRole role;
@property (nonatomic, assign) EIHTUserPlatform platform;

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *registeredTime;
@property (nonatomic, strong) NSString *latestLoggedinTime;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, strong) NSDictionary *userDic;
- (id)initWithUserDic:(NSDictionary *)userDataDic;

@end
