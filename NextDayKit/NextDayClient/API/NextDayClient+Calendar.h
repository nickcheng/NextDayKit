//
//  NextDayClient+Calendar.h
//  NextDayKit
//
//  Created by nickcheng on 13-6-16.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClient.h"
#import "NextDayClient+HandlerBlocks.h"

@interface NextDayClient (Calendar)

- (void)getCalDataFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(NextDayClientCompletionBlock)completionHandler;
- (void)getCalDataFromDates:(NSArray *)dateArray completion:(NextDayClientCompletionBlock)completionHandler;
- (void)getCalDataKeysAfterTS:(NSTimeInterval)ts completion:(NextDayClientCompletionBlock)completionHandler;

@end
