//
//  NextDayClientGiftReceiver.h
//  NextDayKit
//
//  Created by nickcheng on 13-7-3.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClientObject.h"

@interface NextDayClientGiftReceiver : NextDayClientObject

@property (nonatomic, strong) NSString *weiboID;
@property (nonatomic, strong) NSString *weiboName;
@property (nonatomic, strong) NSString *weiboRemark;
@property (nonatomic, strong) NSString *weiboAvatar;
@property (nonatomic, strong) NSString *timezoneID;
@property (nonatomic, strong) NSString *scheduledDate;

- (NSDictionary *)dict;

@end
