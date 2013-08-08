//
//  NextDayClientGiftData.m
//  NextDayKit
//
//  Created by nickcheng on 13-7-3.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClientGiftData.h"

@implementation NextDayClientGiftData {
  NSString *_backgroundColor;
  NSString *_imageURL;
  NSString *_phrase1;
  NSString *_phrase2;
  NSString *_event;
  NSString *_previewImageURL;
}

@synthesize backgroundColor = _backgroundColor;
@synthesize imageURL = _imageURL;
@synthesize phrase1 = _phrase1;
@synthesize phrase2 = _phrase2;
@synthesize event = _event;
@synthesize previewImageURL = _previewImageURL;

#pragma mark -
#pragma mark Init

- (id)init {
  //
	if((self = [super init]) == nil) return nil;
  
  // Custom initialization
  _backgroundColor = nil;
  _imageURL = nil;
  _phrase1 = nil;
  _phrase2 = nil;
  _event = nil;
  _previewImageURL = nil;
  
  return self;
}

#pragma mark -
#pragma mark Public Methods

- (NSDictionary *)dict {
  NSDictionary *result = @{
                           @"colors": @{
                               @"background": self.backgroundColor
                               },
                           @"images": @{
                               @"small": self.imageURL,
                               @"smallWithDate": self.previewImageURL
                               },
                           @"text": @{
                               @"comment1": self.phrase1,
                               @"comment2": self.phrase2,
                               },
                           @"event": self.event
                           };
  
  return result;
}


@end
