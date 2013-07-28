//
//  NextDayClientGiftOutboxItem.m
//  NextDayKit
//
//  Created by nickcheng on 13-7-21.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClientGiftOutboxItem.h"

@implementation NextDayClientGiftOutboxItem {
  double _giftID;
  NSString *_senderDeviceID;
  double _ts;
  BOOL _delivered;
  BOOL _read;
  NSString *_createDeviceID;
  NSDate *_createTime;
  NSString *_accessDeviceID;
  NSDate *_accessTime;
  NSString *_giftBGColor;
  NSString *_giftImageURL;
  NSString *_giftPhrase1;
  NSString *_giftPhrase2;
  NSString *_giftEvent;

  double _rcvrWeiboID;
  NSString *_rcvrWeiboName;
  NSString *_rcvrWeiboRemark;
  NSString *_rcvrWeiboAvatar;
  NSInteger _rcvrWeiboGender;
  NSString *_rcvrTimezone;
  NSDate *_rcvrScheduledDate;
}

@synthesize giftID = _giftID;
@synthesize senderDeviceID = _senderDeviceID;
@synthesize ts = _ts;
@synthesize delivered = _delivered;
@synthesize read = _read;
@synthesize createDeviceID = _createDeviceID;
@synthesize createTime = _createTime;
@synthesize accessDeviceID = _accessDeviceID;
@synthesize accessTime = _accessTime;
@synthesize giftBGColor = _giftBGColor;
@synthesize giftImageURL = _giftImageURL;
@synthesize giftPhrase1 = _giftPhrase1;
@synthesize giftPhrase2 = _giftPhrase2;
@synthesize giftEvent = _giftEvent;
@synthesize rcvrWeiboID = _rcvrWeiboID;
@synthesize rcvrWeiboName = _rcvrWeiboName;
@synthesize rcvrWeiboRemark = _rcvrWeiboRemark;
@synthesize rcvrWeiboAvatar = _rcvrWeiboAvatar;
@synthesize rcvrWeiboGender = _rcvrWeiboGender;
@synthesize rcvrTimezone = _rcvrTimezone;
@synthesize rcvrScheduledDate = _rcvrScheduledDate;

@end
