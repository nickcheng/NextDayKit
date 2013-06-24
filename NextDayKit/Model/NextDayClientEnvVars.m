//
//  NextDayClientEnvVars.m
//  NextDayKit
//
//  Created by nickcheng on 13-6-23.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClientEnvVars.h"

@implementation NextDayClientEnvVars {
  NSString *_weiboID;
  NSString *_weiboName;
  NSString *_weiboAvatar;
  NSString *_weiboToken;
  NSString *_weiboTokenExpiresAt;
  NSString *_apnToken;
  NSString *_deviceId;
}

@synthesize weiboID = _weiboID;
@synthesize weiboName = _weiboName;
@synthesize weiboAvatar = _weiboAvatar;
@synthesize weiboToken = _weiboToken;
@synthesize weiboTokenExpiresAt = _weiboTokenExpiresAt;
@synthesize apnToken = _apnToken;
@synthesize deviceId = _deviceId;

#pragma mark -
#pragma mark Init

- (id)init {
  //
	if((self = [super init]) == nil) return nil;
  
  // Custom initialization
  _weiboID = nil;
  _weiboName = nil;
  _weiboAvatar = nil;
  _weiboToken = nil;
  _weiboTokenExpiresAt = nil;
  _apnToken = nil;
  _deviceId = nil;
  
  return self;
}


@end
