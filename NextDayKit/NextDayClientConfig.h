//
//  NextDayClientConfig.h
//  NextDayKit
//
//  Created by nickcheng on 13-6-16.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#define NEXTDAY_SERVERURL @"wss://api.nextday.im/4.5/ws/"
//#define NEXTDAY_SERVERURL @"wss://test.nextday.im/4.5/ws/"
#define NEXTDAYCLIENT_ERRORDOMAIN @"im.nextday.nextdaykit"

// Logging
#ifdef DDLogInfo
  #define NDLI(frmt, ...) DDLogInfo(frmt, ##__VA_ARGS__)
#else
  #define NDLI(frmt, ...) NSLog(frmt, ##__VA_ARGS__)
#endif

#ifdef DDLogWarn
#define NDLW(frmt, ...) DDLogWarn(frmt, ##__VA_ARGS__)
#else
#define NDLW(frmt, ...) NSLog(frmt, ##__VA_ARGS__)
#endif

#ifdef DDLogError
#define NDLE(frmt, ...) DDLogError(frmt, ##__VA_ARGS__)
#else
#define NDLE(frmt, ...) NSLog(frmt, ##__VA_ARGS__)
#endif
