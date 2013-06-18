//
//  NextDayClient.h
//  NextDayKit
//
//  Created by nickcheng on 13-6-16.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  NextDayClientReadyStateConnecting   = 0,
  NextDayClientReadyStateOpen,
  NextDayClientReadyStateClosing,
  NextDayClientReadyStateClosed,
} NextDayClientReadyState;

@class NextDayClientRequest;

typedef void (^NextDayClientResponseBlock)(NSDictionary *responseDict, NSError *error);

@interface NextDayClient : NSObject

@property (nonatomic, assign, readonly) NextDayClientReadyState readyState;
@property (nonatomic, assign) NSInteger messageCount;

+ (instancetype)sharedClient;

- (void)initClientWithCertificate:(NSString *)certURL andCipher:(NSString *)cipher;
- (void)connect;
- (void)send:(NextDayClientRequest *)request completion:(NextDayClientResponseBlock)handler;

@end
