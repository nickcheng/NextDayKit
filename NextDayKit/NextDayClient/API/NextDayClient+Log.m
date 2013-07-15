//
//  NextDayClient+Log.m
//  NextDayKit
//
//  Created by nickcheng on 13-6-23.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClient+Log.h"
#import "NextDayClientRequest.h"
#import "NextDayClientConfig.h"
#import "NextDayClient+Bridge.h"

@implementation NextDayClient (Log)

- (void)subscribeLogFromTS:(NSTimeInterval)ts maxReturnCount:(NSInteger)count completion:(NextDayClientCompletionBlock)completionHandler {
  [self ensureEnvVarsReadyWithCompletion:^(BOOL success, id result, NSError *error) {
    if (!success) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }
    
    // Structure params
    NSDictionary *params = @{
                             @"action": @"log.subscribe",
                             @"ts": [NSString stringWithFormat:@"%.0f", ts],
                             @"maxCount": [NSNumber numberWithInteger:count]
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
      
      NSString *status = responseDict[@"status"];
      if ([status isEqualToString:@"FAIL"]) {
        // Handle error
        NSError *error = [NSError errorWithDomain:NEXTDAYCLIENT_ERRORDOMAIN
                                             code:400
                                         userInfo:[NSDictionary dictionaryWithObject:responseDict[@"error"] forKey:NSLocalizedDescriptionKey]];
        if (completionHandler != nil)
          completionHandler(NO, nil, error);
      } else if ([status isEqualToString:@"OK"]) {
        // Parse responseString and callback
        NSDictionary *result = responseDict[@"result"];
        if (completionHandler != nil)
          completionHandler(YES, result, error);
      }
    }];
  }];
}

- (void)getLogDetailsFrom:(NSArray *)logArray completion:(NextDayClientCompletionBlock)completionHandler {
  [self ensureEnvVarsReadyWithCompletion:^(BOOL success, id result, NSError *error) {
    if (!success) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }
    
    // Structure params
    NSDictionary *params = @{
                             @"action": @"log.getDetails",
                             @"data": logArray
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
      
      NSString *status = responseDict[@"status"];
      if ([status isEqualToString:@"FAIL"]) {
        // Handle error
        NSError *error = [NSError errorWithDomain:NEXTDAYCLIENT_ERRORDOMAIN
                                             code:400
                                         userInfo:[NSDictionary dictionaryWithObject:responseDict[@"error"] forKey:NSLocalizedDescriptionKey]];
        if (completionHandler != nil)
          completionHandler(NO, nil, error);
      } else if ([status isEqualToString:@"OK"]) {
        // Parse responseString and callback
        NSDictionary *result = responseDict[@"result"];
        if (completionHandler != nil)
          completionHandler(YES, result, error);
      }
    }];
  }];
}

@end
