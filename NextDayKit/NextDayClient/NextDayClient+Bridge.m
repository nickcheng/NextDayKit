//
//  NextDayClient+Bridge.m
//  NextDayKit
//
//  Created by nickcheng on 13-7-12.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClient+Bridge.h"
#import "NextDayClient+EnvVars.h"
#import "NextDayClientEnvVars.h"
#import "NCWeiboClient.h"
#import "NCWeiboAuthentication.h"
#import "NCWeiboUser.h"
#import "NCWeiboClient+HandlerBlocks.h"
#import "nHelper.h"
#import "NSDate+SSToolkitAdditions.h"

@implementation NextDayClient (Bridge)

- (void)ensureEnvVarsReadyWithCompletion:(NextDayClientCompletionBlock)handler {
  if (self.isEnvReady) {
    if (handler != nil)
      handler(YES, nil, nil);
    return;
  }
  
  //
  [[NCWeiboClient sharedClient] doAuthBeforeCallAPI:^{
    NextDayClientEnvVars *ev = [[NextDayClientEnvVars alloc] init];
    ev.weiboID = [NCWeiboClient sharedClient].authentication.userID;
    ev.weiboToken = [NCWeiboClient sharedClient].authentication.accessToken;
    ev.weiboName = [NCWeiboClient sharedClient].authentication.user.screenName;
    ev.weiboAvatar = [NCWeiboClient sharedClient].authentication.user.profileLargeImageUrl;
    ev.weiboGender = [NCWeiboClient sharedClient].authentication.user.gender;
    ev.weiboTokenExpiresAt = [NCWeiboClient sharedClient].authentication.expirationDate.ISO8601String;
    ev.weiboLocation = [NCWeiboClient sharedClient].authentication.user.location;
    ev.deviceId = [nHelper UDID];
    // todo: add apntoken
    [self setVars:ev completion:^(BOOL success, id result, NSError *error) {
      if (success) {
        if (handler != nil)
          handler(YES, result, nil);
      } else {
        if (handler != nil)
          handler(NO, result, error);
      }
    }];
  } andAuthErrorProcess:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
    if (handler != nil)
      handler(NO, nil, error);
  }];  
}

@end
