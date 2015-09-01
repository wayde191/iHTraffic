//
//  IHTRequest.m
//  IHTrafficFramework
//
//  Created by Wayde Sun on 4/30/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import "IHTRequest.h"
#import "IHTRequestResponseSuccess.h"
#import "IHTRequestResponseFailure.h"
#import "IHTLog.h"

static const float kTimeout = 30.0;

@interface IHTRequest () {
    BOOL _canceled;
}

@end

@implementation IHTRequest

- (id)init {
    self = [super init];
    if (self) {
        _canceled = NO;
        self.requestMethod = ERequestMethodGet;
        self.responseParseFormat = EResponseParseFormatJSON;
        self.requestURL = nil;
    }
    return self;
}

+ (id)requestWithName:(NSString *)name forServiceUrl:(NSString *)serviceURL {
    NSAssert((![serviceURL isEqualToString:@""] || !serviceURL), @"ServiceURL is empty!!");
    IHTRequest *request = [[IHTRequest alloc] init];
    request.requestURL = serviceURL;
    request.requestName = name;
    return request;
}

+ (id)requestWithName:(NSString *)name forServiceUrl:(NSString *)serviceURL withRequestBlock:(IHTRequestBlockHandler)customerBlock {
    IHTRequest *request = [IHTRequest requestWithName:name forServiceUrl:serviceURL];
    request.requestHandler = customerBlock;
    return request;
}

#pragma mark - Public Methods
- (void)startWithParameters:(NSDictionary *)paras {
    self.requestParameters = paras;
    [self start];
}

- (void)startWithParameters:(NSDictionary *)paras byRequestMethod:(ERequestMethod)method {
    self.requestParameters = paras;
    self.requestMethod = method;
    [self start];
}

- (void)start {
    NSAssert(![IHT_SERVICE_ROOT_URL isEqualToString:@""], @"Service root url is empty!!");
    switch (_requestMethod) {
        case ERequestMethodPost:
            [self startRequest];
            break;
        case ERequestMethodGet:
            [self startRequest];
            break;
        case ERequestMethodMultipartPost:
        case ERequestMethodPut:
            //TODO;
            break;
            
        default:
            break;
    }
}

- (void)cancel {
    // If we want to cancel it really, we cannot use sendSynchronousRequest
    // We need to use normal way like [NSURLConnction start], and cancel it by the way.
    
    [self requestDidCanceled];
}

#pragma mark - Private Methods
-(void)startRequest {
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IHT_SERVICE_ROOT_URL, _requestURL]];
        if (self.customerRootUrl) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.customerRootUrl, _requestURL]];
        }
        IHTLOGINFO(@"-- %@", url);
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setTimeoutInterval:kTimeout];
        switch (self.requestMethod) {
            case ERequestMethodGet:
                [urlRequest setHTTPMethod:@"GET"];
                break;
            case ERequestMethodPost:
                [urlRequest setHTTPMethod:@"POST"];
                IHTLOGINFO(@"POST");
                break;
                
            default:
                break;
        }
        
        NSString *parametersStr = [self getParameterString];
        IHTLOGINFO(@"%@", parametersStr);
        [urlRequest setHTTPBody:[parametersStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        [self requestDidStarted];
        NSHTTPURLResponse *response = nil;
        NSError *error = nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
        if (_canceled) {
            return ;
        }
        
        if (ERequestErrorCodeSuccess == response.statusCode) {
            [self receivedData:data];
        } else {
            [self requestFailed:response];
        }
    });
}

- (void)receivedData:(NSData *)data {
    id object = [self getParsedDic:data];
    IHTLOGINFO(@"--- %@", object);
    NSDictionary *userInfo = @{@"data":object};
    NSDictionary *responseDic = @{@"serviceName":self.requestName,
                                  @"status":@"200",
                                  @"userInfoDic":userInfo};
    [self requestDidFinished:[[IHTRequestResponseSuccess alloc] initWithResponse:responseDic]];
}

- (void)requestFailed:(NSHTTPURLResponse *)response {
    NSDictionary *responseDic = @{@"serviceName":self.requestName,
                                  @"status":[NSString stringWithFormat:@"%ld", (long)response.statusCode],
                                  @"userInfoDic":@{}};
    [self requestDidFailed:[[IHTRequestResponseFailure alloc] initWithResponse:responseDic]];
}

- (void)requestDidStarted {
    IHTLOGINFO(@"%@: requestDidStarted: %@%@", self.requestName, IHT_SERVICE_ROOT_URL, self.requestURL);
}

- (void)requestDidCanceled {
    _canceled = YES;
    
    if (self.requestHandler) {
        _requestHandler(self, ERequestingCanceled, nil, nil);
    }
}

- (void)requestDidFinished:(IHTRequestResponseSuccess *)response {
    
    if (self.requestHandler) {
        self.requestHandler(self, ERequestingFinished, response, nil);
    }
    
    IHTLOGINFO(@"%@: requestDidFinished , %@", self.requestName, response.userInfo);
}

- (void)requestDidFailed:(IHTRequestResponseFailure *)response {
    if (self.requestHandler) {
        self.requestHandler(self, ERequestingFailed, nil, response);
    }
}

- (id)getParsedDic:(NSData *)data {
    id obj = nil;
    switch (self.responseParseFormat) {
        case EResponseParseFormatJSON:
            obj = [self getJsonObject:data];
            break;
        case EResponseParseFormatXML:
            //TODO
            break;
            
        default:
            break;
    }
    return obj;
}

- (id)getJsonObject:(NSData *)data {
    //TODO: error Handler
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
}

- (NSString *)getParameterString {
    NSMutableString *parasStr = [@"" mutableCopy];
    BOOL firstPara = YES;
    for (NSString *key in self.requestParameters) {
        [parasStr appendString:(firstPara ?
                              [NSString stringWithFormat:@"%@=%@", key, [self encodeURL:[_requestParameters objectForKey:key]]] :
                              [NSString stringWithFormat:@"&%@=%@", key, [self encodeURL:[_requestParameters objectForKey:key]]])];
        firstPara = NO;
    }
    IHTLOGINFO(@"--%@:%@--", self.requestName, parasStr);
    return parasStr;
}

- (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return @"";
}
@end
