//
//  NextDayClient+Inbox.m
//  NextDayKit
//
//  Created by nickcheng on 13-7-28.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClient+Inbox.h"
#import "NextDayClient+Bridge.h"
#import "NextDayClientRequest.h"
#import "NextDayClientConfig.h"

@implementation NextDayClient (Inbox)

- (void)markInboxItemsReadByIds:(NSArray *)ids completion:(NextDayClientCompletionBlock)completionHandler {
  [self ensureEnvVarsReadyWithCompletion:^(BOOL success, id result, NSError *error) {
    if (!success) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }

    // Structure params
    NSDictionary *params = @{
                             @"action": @"inbox.read",
                             @"giftIds": ids
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

- (void)deleteInboxItemsByIds:(NSArray *)ids completion:(NextDayClientCompletionBlock)completionHandler {
  [self ensureEnvVarsReadyWithCompletion:^(BOOL success, id result, NSError *error) {
    if (!success) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }
    
    // Structure params
    NSDictionary *params = @{
                             @"action": @"inbox.del",
                             @"giftIds": ids
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

@end
