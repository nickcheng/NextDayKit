//
//  NextDayClientRequest.h
//  NextDayKit
//
//  Created by nickcheng on 13-6-17.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClientObject.h"

typedef enum {
  NextDayClientRequestEventAction = 0
} NextDayClientRequestEvent;

@interface NextDayClientRequest : NextDayClientObject

- (id)initWithEvent:(NextDayClientRequestEvent)event;
- (id)initAsAction;

@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, assign) NSInteger messageCount;

@end
