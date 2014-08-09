//
//  NextDayClientGiftData.h
//  NextDayKit
//
//  Created by nickcheng on 13-7-3.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClientObject.h"

@interface NextDayClientGiftData : NextDayClientObject

@property (nonatomic, strong) NSString *backgroundColor;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *shortPhrase;
@property (nonatomic, strong) NSString *event;
@property (nonatomic, strong) NSString *previewImageURL;

- (NSDictionary *)dict;

@end
