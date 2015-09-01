//
//  NetworkTests.m
//  IHTrafficFramework
//
//  Created by sun wayde on 5/19/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "IHTServices.h"
#import "IHTRequest.h"
#import "IHTRequestResponseSuccess.h"
#import "IHTRequestResponseFailure.h"

#import "IHTTracker.h"
#import "IHTUserModel.h"

@interface NetworkTests : XCTestCase

@end

@implementation NetworkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testGetRequest {
//    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
//    __block BOOL responseHasArrived = NO;
//    
//    IHTRequest *request = [IHTRequest
//                           requestWithName:@"GetFunds"
//                           forServiceUrl:SERVICE_GET_FUNDS
//                           withRequestBlock:^(IHTRequest *request, ERequestingStatus requestingStatus, IHTRequestResponseSuccess *responseSuccess, IHTRequestResponseFailure *responseFailed) {
//                                         
//                             responseHasArrived = YES;
//                             
//                             switch (requestingStatus) {
//                                 case ERequestingStarted:
//                                     //TODO
//                                     break;
//                                 case ERequestingFinished:
//                                 {
//                                     NSLog(@"%@", responseSuccess.userInfo);
//                                     XCTAssert(YES, @"Pass");
//                                 }
//                                     break;
//                                 case ERequestingFailed:
//                                     //TODO
//                                     break;
//                                 case ERequestingCanceled:
//                                     //TODO
//                                     break;
//                                     
//                                 default:
//                                     break;
//                             }
//                         }];
//    [request startWithParameters:@{@"user_id":@"1",
//                                   @"sCode":@"ihakula.ifinancial.scode"}
//                 byRequestMethod:ERequestMethodPost];
//    
//    while (responseHasArrived == NO && ([timeoutDate timeIntervalSinceNow] > 0)) {
//        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, YES);
//    }
//    
//    if (responseHasArrived == NO) {
//        XCTFail(@"Test timed out");
//    }
//    
//}

//- (void)testTrackerBeginLog {
//    BOOL responseHasArrived = NO;
//    
//    [IHTTracker startWithAppKey:@"7b6a31d795540ab9cfa26a3e8314012b"];
//    responseHasArrived = [IHTTracker beginLogViewController:NSStringFromClass([NetworkTests class])];
//    
//    if (responseHasArrived == NO) {
//        XCTFail(@"Test timed out");
//    } else {
//        XCTAssert(YES, @"Done");
//    }
//    
//}
//
//- (void)testTrackerEndLog {
//    BOOL responseHasArrived = NO;
//    
//    [IHTTracker startWithAppKey:@"7b6a31d795540ab9cfa26a3e8314012b"];
//    responseHasArrived = [IHTTracker endLogViewController:NSStringFromClass([NetworkTests class])];
//    
//    if (responseHasArrived == NO) {
//        XCTFail(@"Test timed out");
//    } else {
//        XCTAssert(YES, @"Done");
//    }
//    
//}
//
//- (void)testTrackerEventLog {
//    BOOL responseHasArrived = NO;
//    
//    [IHTTracker startWithAppKey:@"7b6a31d795540ab9cfa26a3e8314012b"];
//    responseHasArrived = [IHTTracker event:@"ButtonClicked" triggered:NSStringFromClass([NetworkTests class])];
//    
//    if (responseHasArrived == NO) {
//        XCTFail(@"Test timed out");
//    } else {
//        XCTAssert(YES, @"Done");
//    }
//    
//}


- (void)testUserLogin {
    BOOL responseHasArrived = NO;

    [IHTTracker startWithAppKey:@"7b6a31d795540ab9cfa26a3e8314012b"];
    IHTUserModel *model = [IHTUserModel new];
    responseHasArrived = [model doCallLoginService:@{@"ihakulaID":@"wsun191@gmail.com",
                                                     @"password":@"wayde191"}
                               onCompletionHandler:^(EIHTLogStatus status, IHTUser *user) {
                                   NSLog(@"%d", status);
                                   NSLog(@"%@", user.username);
    }];

    if (responseHasArrived == NO) {
        XCTFail(@"Test timed out");
    } else {
        XCTAssert(YES, @"Done");
    }

}

- (void)testUserLogout {
    BOOL responseHasArrived = NO;
    
    [IHTTracker startWithAppKey:@"7b6a31d795540ab9cfa26a3e8314012b"];
    IHTUserModel *model = [IHTUserModel new];
    responseHasArrived = [model doCallLogoutService:@{@"ihakulaID":@"wsun191@gmail.com"}
                               onCompletionHandler:^(EIHTLogStatus status, IHTUser *user) {
                                   NSLog(@"%d", status);
                                   NSLog(@"%@", user.username);
                               }];
    
    if (responseHasArrived == NO) {
        XCTFail(@"Test timed out");
    } else {
        XCTAssert(YES, @"Done");
    }
    
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
