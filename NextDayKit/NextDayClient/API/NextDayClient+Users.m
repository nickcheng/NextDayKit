//
//  NextDayClient+Users.m
//  NextDayKit
//
//  Created by nickcheng on 13-8-9.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClient+Users.h"
#import "NextDayClientRequest.h"
#import "NextDayClientConfig.h"

@implementation NextDayClient (Users)

- (void)checkNextDayUserFromArray:(NSArray *)idArray completion:(NextDayClientCompletionBlock)completionHandler {
  // Structure params
  NSDictionary *params = @{
                           @"action": @"users.identify",
                           @"userIds": idArray,
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

}

@end
