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
        
        self.userID = userDataDic[@"id"];
        self.email = userDataDic[@"email"];
        self.avatar = userDataDic[@"avatar"];
        self.username = userDataDic[@"name"];
        self.platform = (EIHTUserPlatform)userDataDic[@"platform"];
        self.phoneNumber = userDataDic[@"phone"];
        self.role = (EIHTUserRole)userDataDic[@"role"];
        self.sex = userDataDic[@"sex"];
    }
    return self;
}

@end
