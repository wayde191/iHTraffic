//
//  IHTServices.h
//  IHTrafficFramework
//
//  Created by Wayde Sun on 5/1/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#ifndef IHTrafficFramework_IHTServices_h
#define IHTrafficFramework_IHTServices_h

#import "IHTCommonMacros.h"

#if IHT_API_PRODUCTION_ENVIRONMENT == 1
#define IHT_SERVICE_ROOT_URL    @"http://112.124.41.173/api/index.php/ihtracker/"
#else
#define IHT_SERVICE_ROOT_URL    @"http://192.168.0.103/api/index.php/ihtracker/"
#endif

/////////////////////////// Services ///////////////////////////////////////////
#define IHT_SERVICE_TRACKER                      @"uploadTrack"
#define IHT_SERVICE_LOGIN                        @"login"
#define IHT_SERVICE_LOGOUT                       @"logout"
#define IHT_SERVICE_REGISTER                     @"register"
#define IHT_SERVICE_FEEDBACK                     @"feedback"

#endif
