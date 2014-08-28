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
  NSInteger _weiboGender;
  NSString *_weiboToken;
  NSString *_weiboTokenExpiresAt;
  NSString *_weiboLocation;
  NSString *_apnToken;
  NSString *_deviceId;
  NSString *_version;
  NSArray *_supportedGiftVersions;
}

@synthesize weiboID = _weiboID;
@synthesize weiboName = _weiboName;
@synthesize weiboAvatar = _weiboAvatar;
@synthesize weiboGender = _weiboGender;
@synthesize weiboToken = _weiboToken;
@synthesize weiboTokenExpiresAt = _weiboTokenExpiresAt;
@synthesize weiboLocation = _weiboLocation;
@synthesize apnToken = _apnToken;
@synthesize deviceId = _deviceId;
@synthesize version = _version;
@synthesize supportedGiftVersions = _supportedGiftVersions;

#pragma mark -
#pragma mark Init

- (id)init {
  //
	if((self = [super init]) == nil) return nil;
  
  // Custom initialization
  _weiboID = nil;
  _weiboName = nil;
  _weiboAvatar = nil;
  _weiboGender = 0;
  _weiboToken = nil;
  _weiboTokenExpiresAt = nil;
  _weiboLocation = nil;
  _apnToken = nil;
  _deviceId = nil;
  _version = nil;
  _supportedGiftVersions = nil;
  
  return self;
}


@end
