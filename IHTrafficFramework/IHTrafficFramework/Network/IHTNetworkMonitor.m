//
//  IHTNetworkMonitor.m
//  IHTrafficFramework
//
//  Created by Wayde Sun on 4/30/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import "IHTNetworkMonitor.h"
#import "IHTReachability.h"
#import "IHTLog.h"

//Singleton model
static IHTNetworkMonitor *singletonInstance = nil;

@interface IHTNetworkMonitor () {
    IHTReachability *_reachAbility;
    BOOL _networkReachable;
    NSString *_networkType;
}

@end

@implementation IHTNetworkMonitor

- (id)init {
    self = [super init];
    if (self) {
        _networkReachable = YES;
        _networkType = nil;
    }
    return self;
}

#pragma mark - Public Methods
- (void)dealloc {
    [self removeObserver];
}

- (void)startNotifer {
    [self addObserver];
    _reachAbility = [IHTReachability reachabilityForInternetConnection];
    [self updateNetwordStatus:_reachAbility.currentReachabilityStatus];
    [_reachAbility startNotifier];
}

- (void)stopNotifier {
    [self removeObserver];
    if (_reachAbility) {
        [_reachAbility stopNotifier];
    }
}

- (BOOL)isReachable {
    return _networkReachable;
}

- (NSString *)getReadableTrafficInfo {
    return _networkType;
}

#pragma mark - Private Methods
- (void)networkStateDidChanged:(NSNotification*)n
{
    IHTReachability* curReach = [n object];
    NSParameterAssert([curReach isKindOfClass: [IHTReachability class]]);
    [self updateNetwordStatus:curReach.currentReachabilityStatus];
}

- (void)updateNetwordStatus:(NetworkStatus)status
{
    _networkReachable = YES;
    switch (status) {
        case ReachableViaWiFi:
        {
            _networkType = @"wifi";
        }
            break;
        case ReachableViaWWAN:
        {
            _networkType = @"wwan";
        }
            break;
        case NotReachable:
        {
            _networkType = @"unavailable";
            _networkReachable = NO;
        }
            break;
        default:
        {
            _networkReachable = NO;
            _networkType = @"unknown";
        }
            break;
    }
    
    IHTLOGINFO(@"%@", _networkType);
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateDidChanged:) name:kReachabilityChangedNotification object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

#pragma mark - Class Methods
+ (IHTNetworkMonitor *)sharedInstance {
    @synchronized(self){
        if (!singletonInstance) {
            singletonInstance = [[IHTNetworkMonitor alloc] init];
        }
        return singletonInstance;
    }
    
    return nil;
}

@end
