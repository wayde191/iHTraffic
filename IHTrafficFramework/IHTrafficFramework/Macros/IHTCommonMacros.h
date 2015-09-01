//
//  IHTCommonMacros.h
//  IHTrafficFramework
//
//  Created by Wayde Sun on 4/30/15.
//  Copyright (c) 2015 iHakula. All rights reserved.
//

#ifndef IHTrafficFramework_IHTCommonMacros_h
#define IHTrafficFramework_IHTCommonMacros_h

#define IHT_APP_PRODUCTION_ENVIRONMENT      1
#define IHT_API_PRODUCTION_ENVIRONMENT      1
#define IHT_TRACKER_SCODE                   @"ihakula.tracker.scode"

//////////////////////////////////System//////////////////////////////////////////
#define IHT_USER_DEFAULT                [NSUserDefaults standardUserDefaults]
#define IHT_SCREEN_BOUND_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define IHT_SCREEN_BOUND_WIDTH          [UIScreen mainScreen].bounds.size.width

#ifdef __IPHONE_8_0
#define RemoteNotificationTypeAlert UIUserNotificationTypeAlert
#define RemoteNotificationTypeBadge UIUserNotificationTypeBadge
#define RemoteNotificationTypeSound UIUserNotificationTypeSound
#define RemoteNotificationTypeNone  UIUserNotificationTypeNone
#else
#define RemoteNotificationTypeAlert UIRemoteNotificationTypeAlert
#define RemoteNotificationTypeBadge UIRemoteNotificationTypeBadge
#define RemoteNotificationTypeSound UIRemoteNotificationTypeSound
#define RemoteNotificationTypeNone  UIRemoteNotificationTypeNone
#endif

#endif
