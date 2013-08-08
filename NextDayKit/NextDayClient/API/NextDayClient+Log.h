//
//  NextDayClient+Log.h
//  NextDayKit
//
//  Created by nickcheng on 13-6-23.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClient.h"
#import "NextDayClient+HandlerBlocks.h"

@interface NextDayClient (Log)

- (void)subscribeLogFromTS:(NSTimeInterval)ts
            maxReturnCount:(NSInteger)count
                completion:(NextDayClientCompletionBlock)completionHandler;
- (void)subscribeLogFromTS:(NSTimeInterval)ts
            partCompletion:(NextDayClientCompletionBlock)partCompletionHandler;
- (void)getLogDetailsFrom:(NSArray *)logArray
               completion:(NextDayClientCompletionBlock)completionHandler;

@end
