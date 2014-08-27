//
//  NextDayClientGiftInboxItem.m
//  NextDayKit
//
//  Created by nickcheng on 13-7-19.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClientGiftInboxItem.h"

@implementation NextDayClientGiftInboxItem {
  double _senderID;
  double _giftID;
  NSString *_sourceID;
  NSString *_senderDeviceID;
  BOOL _read;
  NSString *_createDeviceID;
  NSDate *_createTime;
  NSString *_accessDeviceID;
  NSDate *_accessTime;
  NSDate *_scheduledDate;
  double _ts;
  NSString *_giftBGColor;
  NSString *_giftImageURL;
  NSString *_giftPhrase1;
  NSString *_giftPhrase2;
  NSString *_giftShortPhrase;
  NSString *_giftEvent;
  double _giftLatitude;
  double _giftLongitude;
  NSString *_giftReverse;
  NSString *_giftVersion;
  double _sndrWeiboID;
  NSString *_sndrWeiboName;
  NSString *_sndrWeiboAvatar;
  NSInteger _sndrWeiboGender;
  NSString *_sndrWeiboLocation;
}

@synthesize senderID = _senderID;
@synthesize giftID = _giftID;
@synthesize sourceID = _sourceID;
@synthesize senderDeviceID = _senderDeviceID;
@synthesize read = _read;
@synthesize createDeviceID = _createDeviceID;
@synthesize createTime = _createTime;
@synthesize accessDeviceID = _accessDeviceID;
@synthesize accessTime = _accessTime;
@synthesize scheduledDate = _scheduledDate;
@synthesize ts = _ts;
@synthesize giftBGColor = _giftBGColor;
@synthesize giftImageURL = _giftImageURL;
@synthesize giftPhrase1 = _giftPhrase1;
@synthesize giftPhrase2 = _giftPhrase2;
@synthesize giftShortPhrase = _giftShortPhrase;
@synthesize giftEvent = _giftEvent;
@synthesize giftLatitude = _giftLatitude;
@synthesize giftLongitude = _giftLongitude;
@synthesize giftReverse = _giftReverse;
@synthesize giftVersion = _giftVersion;
@synthesize sndrWeiboID = _sndrWeiboID;
@synthesize sndrWeiboName = _sndrWeiboName;
@synthesize sndrWeiboAvatar = _sndrWeiboAvatar;
@synthesize sndrWeiboGender = _sndrWeiboGender;
@synthesize sndrWeiboLocation = _sndrWeiboLocation;

@end
