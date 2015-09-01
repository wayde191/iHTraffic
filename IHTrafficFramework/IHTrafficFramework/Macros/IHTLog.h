//
//  IHTLog.h
//  IHTrafficFramework
//
//  Created by Wayde Sun on 5/1/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#ifndef IHTrafficFramework_IHTLog_h
#define IHTrafficFramework_IHTLog_h

#define IHTLOGPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#if IHT_APP_PRODUCTION_ENVIRONMENT == 1
#define IHTLOGINFO(xx, ...)  IHTLOGPRINT(xx, ##__VA_ARGS__)
#else
#define IHTLOGINFO(xx, ...)  ((void)0)
#endif

#endif
