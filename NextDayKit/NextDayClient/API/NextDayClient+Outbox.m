//
//  NextDayClient+Outbox.m
//  NextDayKit
//
//  Created by nickcheng on 13-7-3.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClient+Outbox.h"
#import "NextDayClientGiftData.h"
#import "NextDayClientGiftReceiver.h"
#import "NextDayClientRequest.h"
#import "NextDayClientConfig.h"
#import "NextDayClient+Bridge.h"

@implementation NextDayClient (Outbox)

- (void)sendGift:(NextDayClientGiftData *)gift
      toReceiver:(NextDayClientGiftReceiver *)receiver
      completion:(NextDayClientCompletionBlock)completionHandler {
  [self ensureEnvVarsReadyWithCompletion:^(BOOL success, id result, NSError *error) {
    if (!success) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }
    
    // Structure params
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *params = @{
                             @"action": @"outbox.add",
                             @"receivers": @[receiver.dict],
                             @"data": gift.dict,
                             @"giftVersion": version
                             };
    
    // Structure request
    NextDayClientRequest *request = [[NextDayClientRequest alloc] initAsAction];
    request.data[@"params"] = params;
    
    // Send request
    [self send:request completion:^(NSDictionary *responseDict, NSError *error) {
      if (error != nil) {
        if (completionHandler != nil)
          completionHandler(NO, nil, error);
        return;
      }
      
      if (responseDict[@"status"]) {
        NSString *status = responseDict[@"status"];
        if ([status isEqualToString:@"OK"]) { // Parse responseString and callback
          NSArray *result = responseDict[@"result"];
          if (completionHandler != nil)
            completionHandler(YES, result, error);
        }
      } else if (responseDict[@"error"]) {
        NSError *error = [NSError errorWithDomain:NEXTDAYCLIENT_ERRORDOMAIN
                                             code:400
                                         userInfo:@{NSLocalizedDescriptionKey: responseDict[@"error"]}];
        if (completionHandler != nil)
          completionHandler(NO, responseDict, error);
      }
    }];
  }];
}

- (void)deleteOutboxItemByID:(double)giftID inTS:(double)ts completion:(NextDayClientCompletionBlock)completionHandler {
  [self ensureEnvVarsReadyWithCompletion:^(BOOL success, id result, NSError *error) {
    if (!success) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }
    
    // Structure params
    NSDictionary *params = @{
                             @"action": @"outbox.del",
                             @"giftId": [NSNumber numberWithDouble:giftID],
                             @"ts": [NSNumber numberWithDouble:ts]
                             };
    
    // Structure request
    NextDayClientRequest *request = [[NextDayClientRequest alloc] initAsAction];
    request.data[@"params"] = params;
    
    // Send request
    [self send:request completion:^(NSDictionary *responseDict, NSError *error) {
      if (error != nil) {
        if (completionHandler != nil)
          completionHandler(NO, nil, error);
        return;
      }
      
      if (responseDict[@"status"]) {
        NSString *status = responseDict[@"status"];
        if ([status isEqualToString:@"OK"] || [status isEqualToString:@"CHANGED"]) {
          NSMutableDictionary *result = responseDict[@"result"];
          result[@"status"] = status;
          if (completionHandler != nil)
            completionHandler(YES, result, nil);
        }
      } else if (responseDict[@"error"]) {
        NSError *error = [NSError errorWithDomain:NEXTDAYCLIENT_ERRORDOMAIN
                                             code:400
                                         userInfo:@{NSLocalizedDescriptionKey: responseDict[@"error"]}];
        if (completionHandler != nil)
          completionHandler(NO, responseDict, error);
      }
    }];
  }];
}

@end
