//
//  NextDayClient+Inbox.h
//  NextDayKit
//
//  Created by nickcheng on 13-7-28.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClient.h"
#import "NextDayClient+HandlerBlocks.h"

@interface NextDayClient (Inbox)

- (void)markInboxItemsReadByIds:(NSArray *)ids
                     completion:(NextDayClientCompletionBlock)completionHandler;

- (void)deleteInboxItemsByIds:(NSArray *)ids
                   completion:(NextDayClientCompletionBlock)completionHandler;

@end
