//
//  NextDayClientRequest.m
//  NextDayKit
//
//  Created by nickcheng on 13-6-17.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClientRequest.h"

@implementation NextDayClientRequest {
  NSMutableDictionary *_data;
  NSInteger _messageCount;
  
  
}

@synthesize data = _data;
@synthesize messageCount = _messageCount;


#pragma mark -
#pragma mark Init

- (id)initWithEvent:(NextDayClientRequestEvent)event {
  //
	if((self = [super init]) == nil) return nil;
  
  // Custom initialization
  _messageCount = -1;
  
  //
  NSString *eventString = [self eventStringFromEnum:event];
  NSDictionary *dict = @{
                         @"event": eventString
                         };
  _data = [NSMutableDictionary dictionaryWithDictionary:dict];
  
  return self;
}

- (id)initAsAction {
  return [self initWithEvent:NextDayClientRequestEventAction];
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)eventStringFromEnum:(NextDayClientRequestEvent)event {
  if (event == 0)
    return @"action";
  return nil;
}

@end
