//
//  IHTRequest.h
//  IHTrafficFramework
//
//  Created by Wayde Sun on 4/30/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IHTServices.h"

#ifndef IHT_SERVICE_ROOT_URL
#define IHT_SERVICE_ROOT_URL    @""
#endif

typedef enum {
    ERequestStatusFail = 0,
    ERequestStatusSucc = 1,
} ERequestResponseStatus;

typedef enum {
    ERequestErrorCodeSuccess = 200,
    ERequestErrorCodeTimeout = 256,
    ERequestErrorCodeNotFound = 404,
    ERequestErrorCodeServerError = 500,
} ERequestErrorCode;

typedef enum{
    ERequestMethodGet = 1,
    ERequestMethodPost = 2,
    ERequestMethodMultipartPost = 3,
    ERequestMethodPut = 4
} ERequestMethod;

typedef enum{
    EResponseParseFormatJSON = 0,
    EResponseParseFormatXML = 1,
} EResponseParseFormat;

typedef enum {
    ERequestingStarted = 0,
    ERequestingCanceled,
    ERequestingFinished,
    ERequestingFailed,
}ERequestingStatus;

@class IHTRequestResponseSuccess, IHTRequestResponseFailure;
@interface IHTRequest : NSObject

typedef void(^IHTRequestBlockHandler)(IHTRequest *request, ERequestingStatus requestingStatus, IHTRequestResponseSuccess *responseSuccess, IHTRequestResponseFailure *responseFailed);

@property (nonatomic, strong) IHTRequestBlockHandler requestHandler;
@property (nonatomic, strong) NSString *requestName;
@property (nonatomic, strong) NSString *requestURL;
@property (nonatomic, strong) NSString *customerRootUrl;
@property (nonatomic, assign) EResponseParseFormat responseParseFormat;
@property (nonatomic, assign) ERequestMethod requestMethod;
@property (nonatomic, strong) NSDictionary *requestParameters;

- (void)start;
- (void)startWithParameters:(NSDictionary *)paras;
- (void)startWithParameters:(NSDictionary *)paras byRequestMethod:(ERequestMethod)method;
- (void)cancel;

+ (id)requestWithName:(NSString *)name forServiceUrl:(NSString *)serviceURL;
+ (id)requestWithName:(NSString *)name forServiceUrl:(NSString *)serviceURL withRequestBlock:(IHTRequestBlockHandler)customerBlock;

@end
