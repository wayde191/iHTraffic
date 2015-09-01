//
//  IHTNetworkMonitor.h
//  IHTrafficFramework
//
//  Created by Wayde Sun on 4/30/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IHTNetworkMonitor : NSObject

- (void)startNotifer;
- (void)stopNotifier;
- (BOOL)isReachable;
- (NSString *)getReadableTrafficInfo;

// Class Methods
+ (IHTNetworkMonitor *)sharedInstance;

@end
