//
//  NextDayClientEnvVars.h
//  NextDayKit
//
//  Created by nickcheng on 13-6-23.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClientObject.h"

@interface NextDayClientEnvVars : NextDayClientObject

@property (nonatomic, strong) NSString *weiboID; // REQUIRED
@property (nonatomic, strong) NSString *weiboName; // REQUIRED
@property (nonatomic, strong) NSString *weiboAvatar; // REQUIRED
@property (nonatomic, assign) NSInteger weiboGender; // REQUIRED
@property (nonatomic, strong) NSString *weiboToken; // REQUIRED
@property (nonatomic, strong) NSString *weiboTokenExpiresAt; // REQUIRED
@property (nonatomic, strong) NSString *weiboLocation; // REQUIRED
@property (nonatomic, strong) NSString *apnToken;
@property (nonatomic, strong) NSString *deviceId; // REQUIRED
@property (nonatomic, strong) NSString *version;

@end
