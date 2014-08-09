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
  NSString *_shortPhrase;
  NSString *_event;
  NSString *_previewImageURL;
}

@synthesize backgroundColor = _backgroundColor;
@synthesize imageURL = _imageURL;
@synthesize shortPhrase = _shortPhrase;
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
  _shortPhrase = nil;
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
                               @"big": self.imageURL,
                               @"bigWithDate": self.previewImageURL
                               },
                           @"text": @{
                               @"short": self.shortPhrase
                               },
                           @"event": self.event
                           };
  
  return result;
}


@end
