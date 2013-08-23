//
//  NextDayClient+Consts.m
//  NextDayKit
//
//  Created by nickcheng on 13-8-20.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClient+Consts.h"
#import "NextDayClientRequest.h"
#import "NextDayClientConfig.h"

@implementation NextDayClient (Consts)

- (void)getAllTableNameAndVersionWithCompletion:(NextDayClientCompletionBlock)completionHandler {
  // Structure params
  NSDictionary *params = @{
                           @"action": @"consts.tableNames.get",
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
        NSDictionary *result = responseDict[@"result"];
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
}

- (void)getTableByNameAndVersion:(NSArray *)nvArray completion:(NextDayClientCompletionBlock)completionHandler {
  // Structure params
  NSDictionary *params = @{
                           @"action": @"consts.delta.get",
                           @"tables": nvArray
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
        NSDictionary *result = responseDict[@"result"];
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
}

@end
