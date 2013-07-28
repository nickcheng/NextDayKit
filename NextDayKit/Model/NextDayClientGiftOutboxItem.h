//
//  NextDayClientGiftOutboxItem.h
//  NextDayKit
//
//  Created by nickcheng on 13-7-21.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClientObject.h"

@interface NextDayClientGiftOutboxItem : NextDayClientObject

@property (nonatomic, assign) double giftID;
@property (nonatomic, strong) NSString *senderDeviceID;
@property (nonatomic, assign) double ts;
@property (nonatomic, assign) BOOL delivered;
@property (nonatomic, assign) BOOL read;
@property (nonatomic, strong) NSString *createDeviceID;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSString *accessDeviceID;
@property (nonatomic, strong) NSDate *accessTime;
@property (nonatomic, strong) NSString *giftBGColor;
@property (nonatomic, strong) NSString *giftImageURL;
@property (nonatomic, strong) NSString *giftPhrase1;
@property (nonatomic, strong) NSString *giftPhrase2;
@property (nonatomic, strong) NSString *giftEvent;
@property (nonatomic, assign) double rcvrWeiboID;
@property (nonatomic, strong) NSString *rcvrWeiboName;
@property (nonatomic, strong) NSString *rcvrWeiboRemark;
@property (nonatomic, strong) NSString *rcvrWeiboAvatar;
@property (nonatomic, assign) NSInteger rcvrWeiboGender;
@property (nonatomic, strong) NSString *rcvrTimezone;
@property (nonatomic, strong) NSDate *rcvrScheduledDate;

@end
