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

@implementation NextDayClient (Outbox)

- (void)sendGift:(NextDayClientGiftData *)gift
      toReceiver:(NextDayClientGiftReceiver *)receiver
      completion:(NextDayClientCompletionBlock)completionHandler {
  // Structure params
  NSDictionary *params = @{
                           @"action": @"outbox.add",
                           @"receivers": @[receiver.dict],
                           @"data": gift.dict
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
      NSArray *result = responseDict[@"result"];
      if (completionHandler != nil)
        completionHandler(YES, result, error);
    }
  }];
}

@end
