//
//  IHTRequestResponseSuccess.m
//  IHTrafficFramework
//
//  Created by Wayde Sun on 4/30/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import "IHTRequestResponseSuccess.h"

@implementation IHTRequestResponseSuccess

- (id)initWithResponse:(NSDictionary *)responseDic {
    NSAssert(responseDic != nil, @"IHTRequestResponseSuccess' init data Dictionary is empty");
    self = [super init];
    if (self) {
        self.serviceName = responseDic[@"serviceName"];
        self.status = responseDic[@"status"];
        self.userInfo = responseDic[@"userInfoDic"];
    }
    return self;
}

@end
