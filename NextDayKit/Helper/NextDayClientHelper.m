//
//  NextDayClientHelper.m
//  Example
//
//  Created by nickcheng on 14-6-12.
//  Copyright (c) 2014年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClientHelper.h"

@implementation NSDate (NextDayClient)

- (NSString *)yyyyMMddString {
  //
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyyMMdd"];
  NSString *dateString = [dateFormatter stringFromDate:self];
  
  return dateString;
}

- (NSString *)ISO8601String {
	struct tm *timeinfo;
	char buffer[80];
	
	time_t rawtime = (time_t)[self timeIntervalSince1970];
	timeinfo = gmtime(&rawtime);
	
	strftime(buffer, 80, "%Y-%m-%dT%H:%M:%SZ", timeinfo);
	
	return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

@end
