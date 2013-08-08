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

static const NSInteger kPageCount = 20;

@implementation NextDayClient (Log)

#pragma mark -
#pragma mark Public Methods

- (void)subscribeLogFromTS:(NSTimeInterval)ts maxReturnCount:(NSInteger)count completion:(NextDayClientCompletionBlock)completionHandler {
  [self subscribeLogFullFromTS:ts maxReturnCount:count completion:^(BOOL success, id result, NSError *error) {
    if (!success) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }

    //
    NSDictionary *dict = result;
    if (completionHandler != nil)
      completionHandler(YES, dict, error);

  }];
}

- (void)subscribeLogFromTS:(NSTimeInterval)ts partCompletion:(NextDayClientCompletionBlock)partCompletionHandler {
  __block NextDayClientCompletionBlock block = [^(BOOL success, id result, NSError *error) {
    if (!success || result == [NSNull null]) {
      if (partCompletionHandler != nil)
        partCompletionHandler(NO, nil, error);
      return;
    }

    // Do handler
    NSDictionary *dict = result;
    if (partCompletionHandler != nil)
      partCompletionHandler(YES, dict[@"result"], error);

    // Check if need to get more
    if ([dict[@"hasMore"] boolValue]) {
      NSDictionary *lastLog = [dict[@"result"] lastObject];
      NSTimeInterval lastts = [lastLog[@"ts"] doubleValue];
      [self subscribeLogFromTS:lastts maxReturnCount:kPageCount completion:block];
    } else
      return;
  } copy];
  [self subscribeLogFromTS:ts maxReturnCount:kPageCount completion:block];
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

#pragma mark -
#pragma mark Private Methods

- (void)subscribeLogFullFromTS:(NSTimeInterval)ts maxReturnCount:(NSInteger)count completion:(NextDayClientCompletionBlock)completionHandler {
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
      
      if (responseDict[@"status"]) {
        NSString *status = responseDict[@"status"];
        if ([status isEqualToString:@"OK"]) { // Parse responseString and callback
          if (completionHandler != nil)
            completionHandler(YES, responseDict, error);
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
