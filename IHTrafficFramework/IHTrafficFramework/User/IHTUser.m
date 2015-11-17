//
//  IHTUser.m
//  IHTrafficFramework
//
//  Created by Wayde Sun on 4/30/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import "IHTUser.h"

@implementation IHTUser

//{
//    avatar = "";
//    email = "wsun191@gmail.com";
//    id = 1;
//    latestLoggedinTime = "2015-05-22 10:47:04";
//    name = ihakula;
//    phone = 18610340534;
//    platform = ihakula;
//    registeredTime = "2013-04-28 16:32:48";
//    role = 4;
//    sex = 0;
//};

- (id)initWithUserDic:(NSDictionary *)userDataDic {
    self = [self init];
    if (self) {
        self.userDic = userDataDic;
        self.userID = @"-1";
        self.loginState = (EIHTLoginErrorState)[userDataDic[@"errorCode"] intValue];
        if (!_loginState) {
            NSDictionary *user = userDataDic[@"user"];
            
            self.userID = user[@"id"] ? user[@"id"] : @"-1";
            self.email = user[@"email"];
            self.avatar = user[@"avatar"];
            self.username = user[@"name"];
            self.platform = (EIHTUserPlatform)[user[@"platform"] intValue];
            self.phoneNumber = user[@"phone"];
            self.role = (EIHTUserRole)[user[@"role"] intValue];
            self.sex = user[@"sex"];
        }
    }
    return self;
}

@end
