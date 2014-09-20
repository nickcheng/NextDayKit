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
  NSNumber *_geoLatitude;
  NSNumber *_geoLongitude;
  NSString *_geoReverse;
}

@synthesize backgroundColor = _backgroundColor;
@synthesize imageURL = _imageURL;
@synthesize shortPhrase = _shortPhrase;
@synthesize event = _event;
@synthesize previewImageURL = _previewImageURL;
@synthesize geoLatitude = _geoLatitude;
@synthesize geoLongitude = _geoLongitude;
@synthesize geoReverse = _geoReverse;

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
  _geoReverse = nil;
  
  return self;
}

#pragma mark -
#pragma mark Public Methods

- (NSDictionary *)dict {
  NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
  [result addEntriesFromDictionary:@{
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
                                     }];
  //
  NSMutableDictionary *geoPart = [[NSMutableDictionary alloc] init];
  if (self.geoReverse && self.geoReverse.length > 0)
    [geoPart setObject:self.geoReverse forKey:@"reverse"];
  if (self.geoLatitude && self.geoLongitude)
    [geoPart addEntriesFromDictionary:@{
                                        @"lat": self.geoLatitude,
                                        @"lng": self.geoLongitude,
                                        }];
  //
  if (geoPart.count && geoPart.count > 0)
    [result setObject:geoPart forKey:@"geo"];
  
  return result;
}

@end
