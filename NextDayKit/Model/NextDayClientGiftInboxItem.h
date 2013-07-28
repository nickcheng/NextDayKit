//
//  NextDayClientGiftInboxItem.h
//  NextDayKit
//
//  Created by nickcheng on 13-7-19.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClientObject.h"

@interface NextDayClientGiftInboxItem : NextDayClientObject

@property (nonatomic, assign) double senderID;
@property (nonatomic, assign) double giftID;
@property (nonatomic, strong) NSString *sourceID;
@property (nonatomic, strong) NSString *senderDeviceID;
@property (nonatomic, assign) BOOL read;
@property (nonatomic, strong) NSString *createDeviceID;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSString *accessDeviceID;
@property (nonatomic, strong) NSDate *accessTime;
@property (nonatomic, strong) NSDate *scheduledDate;
@property (nonatomic, assign) double ts;
@property (nonatomic, strong) NSString *giftBGColor;
@property (nonatomic, strong) NSString *giftImageURL;
@property (nonatomic, strong) NSString *giftPhrase1;
@property (nonatomic, strong) NSString *giftPhrase2;
@property (nonatomic, strong) NSString *giftEvent;
@property (nonatomic, assign) double sndrWeiboID;
@property (nonatomic, strong) NSString *sndrWeiboName;
@property (nonatomic, strong) NSString *sndrWeiboAvatar;
@property (nonatomic, assign) NSInteger sndrWeiboGender;

//- (NSDictionary *)dict;

@end
