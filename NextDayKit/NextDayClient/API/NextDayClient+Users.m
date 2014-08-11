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

static NSInteger kBatchSize = 50;

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

- (void)checkNextDayUserInBatchesFromArray:(NSArray *)idArray completion:(NextDayClientCompletionBlock)completionHandler {
  NSMutableDictionary *finalResult = [[NSMutableDictionary alloc] init];
  
  NSRange range = NSMakeRange(0, kBatchSize > idArray.count ? idArray.count : kBatchSize);
  NSArray *arr = [idArray subarrayWithRange:range];
  
  __block NSInteger ss = 0;
  __block __weak NextDayClientCompletionBlock weakBlock;
  NextDayClientCompletionBlock block;
  weakBlock = block = ^(BOOL success, id result, NSError *error) {
    if (success) {
      NSDictionary *dict = result;
      [finalResult addEntriesFromDictionary:dict];
      
      // Check ending
      if (finalResult.count == idArray.count) {
        NDLI(@"Check NextDay user status in batches done!");
        if (completionHandler)
          completionHandler(YES, finalResult, nil);
        return;
      }
      
      // Do next
      ss += 1;
      NSRange range = NSMakeRange(ss * kBatchSize, ss * kBatchSize + kBatchSize > idArray.count ? idArray.count - ss * kBatchSize : kBatchSize);
      NSArray *array = [idArray subarrayWithRange:range];
      [self checkNextDayUserFromArray:array completion:weakBlock];

    } else {
      NDLE(@"Check NextDay user status error:%@", error);
      if (completionHandler)
        completionHandler(NO, result, error);
    }
  };
  
  [self checkNextDayUserFromArray:arr completion:block];
}

@end
