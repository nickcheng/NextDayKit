//
//  NextDayClient+SharingStatus.m
//  NextDay
//
//  Created by nickcheng on 14-8-9.
//  Copyright (c) 2014年 nxmix.com. All rights reserved.
//

#import "NextDayClient+SharingStatus.h"
#import "NextDayClientGiftInboxItem.h"
#import "NextDayClientGiftOutboxItem.h"
#import "NextDayClient+Bridge.h"
#import "NextDayClientRequest.h"
#import "NextDayClientHelper.h"
#import "NextDayClientConfig.h"

@implementation NextDayClient (SharingStatus)

- (void)shareGift:(id)gift
        inChannel:(NextDaySharingChannel)channel
       completion:(NextDayClientCompletionBlock)completionHandler {
  //
  NSString *sharingID;
  if ([gift isKindOfClass:[NextDayClientGiftInboxItem class]]) {
    NextDayClientGiftInboxItem *item = (NextDayClientGiftInboxItem *)gift;
    sharingID = [NSString stringWithFormat:@"in+%@", item.sourceID];
  } else if ([gift isKindOfClass:[NextDayClientGiftOutboxItem class]]) {
    NextDayClientGiftOutboxItem *item = (NextDayClientGiftOutboxItem *)gift;
    sharingID = [NSString stringWithFormat:@"out+%f", item.giftID];
  } else
    NSAssert(NO, @"Wrong gift type.");
  
  //
  [self shareGiftByID:sharingID
            inChannel:channel
           completion:completionHandler];
  
}

- (void)shareGiftByID:(NSString *)sharingID
            inChannel:(NextDaySharingChannel)channel
           completion:(NextDayClientCompletionBlock)completionHandler {
  [self ensureEnvVarsReadyWithCompletion:^(BOOL success, id result, NSError *error) {
    if (!success) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }
    
    // Structure params
    NSDictionary *params = @{
                             @"action": @"ss.add",
                             @"sharingId": sharingID,
                             @"channel": [self channelStringFromSharingChannel:channel],
                             @"createTime": [NSDate date].ISO8601String
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

- (NSString *)channelStringFromSharingChannel:(NextDaySharingChannel)channel {
  NSString *result;
  
  switch (channel) {
    case NextDaySharingChannelWeChatMoments:
      result = @"wechat.moments";
      break;
    case NextDaySharingChannelWeibo:
      result = @"weibo";
      break;
    case NextDaySharingChannelInstagram:
      result = @"instagram";
      break;
    case NextDaySharingChannelTwitter:
      result = @"twitter";
      break;
    case NextDaySharingChannelFacebook:
      result = @"facebook";
      break;
    default:
      NSAssert(NO, @"Sharing channel of gift out of range.");
      break;
  }
  
  return result;
}

@end
