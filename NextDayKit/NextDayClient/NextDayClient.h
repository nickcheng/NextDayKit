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

typedef enum {
  NextDayClientEnvStateNone,
  NextDayClientEnvStateDoing,
  NextDayClientEnvStateReady,
} NextDayClientEnvState;

@class NextDayClientRequest;

typedef void (^NextDayClientResponseBlock)(NSDictionary *responseDict, NSError *error);
typedef void (^NextDayClientEmptyBlock)();

@interface NextDayClient : NSObject

@property (nonatomic, assign, readonly) NextDayClientReadyState readyState;
@property (nonatomic, assign) NSInteger messageCount;
@property (nonatomic, assign) NextDayClientEnvState envState;
@property (nonatomic, copy) NextDayClientEmptyBlock connectedHandler;

+ (instancetype)sharedClient;

- (void)initClientWithCertificate:(NSString *)certURL andCipher:(NSString *)cipher;
- (void)connect;
- (void)reconnectWithCompletion:(NextDayClientEmptyBlock)handler;
- (void)send:(NextDayClientRequest *)request completion:(NextDayClientResponseBlock)handler;

@end
