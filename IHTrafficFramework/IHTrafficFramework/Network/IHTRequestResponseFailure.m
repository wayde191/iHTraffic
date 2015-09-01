//
//  IHTRequestResponseFailure.m
//  IHTrafficFramework
//
//  Created by Wayde Sun on 4/30/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import "IHTRequestResponseFailure.h"

@implementation IHTRequestResponseFailure

- (id)initWithResponse:(NSDictionary *)responseDic {
    NSAssert(responseDic != nil, @"IHTRequestResponseFailure' init data Dictionary is empty");
    self = [super init];
    if (self) {
        self.serviceName = responseDic[@"serviceName"];
        self.status = responseDic[@"status"];
        self.userInfoDic = responseDic[@"userInfoDic"];
        self.errorInfo = responseDic[@"errorInfo"];
    }
    return self;
}

@end
