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
#import "NextDayClientHelper.h"
#import "NCWeiboClient.h"
#import "NCWeiboAuthentication.h"
#import "NCWeiboUser.h"
#import "NCWeiboClient+HandlerBlocks.h"

@implementation NextDayClient (Bridge)

- (void)ensureEnvVarsReadyWithCompletion:(NextDayClientCompletionBlock)handler {
  if (self.envState == NextDayClientEnvStateReady) {
    if (handler != nil)
      handler(YES, nil, nil);
    return;
  }
  
  //
  self.envState = NextDayClientEnvStateDoing;
  [[NCWeiboClient sharedClient] doAuthBeforeCallAPI:^{
    NextDayClientEnvVars *ev = [[NextDayClientEnvVars alloc] init];
    ev.weiboID = [NCWeiboClient sharedClient].authentication.userID;
    ev.weiboToken = [NCWeiboClient sharedClient].authentication.accessToken;
    ev.weiboName = [NCWeiboClient sharedClient].authentication.user.screenName;
    ev.weiboAvatar = [NCWeiboClient sharedClient].authentication.user.profileLargeImageUrl;
    ev.weiboGender = [NCWeiboClient sharedClient].authentication.user.gender;
    ev.weiboTokenExpiresAt = [NCWeiboClient sharedClient].authentication.expirationDate.ISO8601String;
    ev.weiboLocation = [NCWeiboClient sharedClient].authentication.user.location;
    ev.deviceId = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    ev.apnToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"devicetoken"];
    ev.version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self setVars:ev completion:^(BOOL success, id result, NSError *error) {
      if (success) {
        if (handler != nil)
          handler(YES, result, nil);
      } else {
        if (handler != nil)
          handler(NO, result, error);
      }
    }];
  } andAuthErrorProcess:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
    self.envState = NextDayClientEnvStateNone;
    if (handler != nil)
      handler(NO, nil, error);
  }];  
}

@end
