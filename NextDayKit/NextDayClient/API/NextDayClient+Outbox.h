//
//  NextDayClient+Outbox.h
//  NextDayKit
//
//  Created by nickcheng on 13-7-3.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClient.h"
#import "NextDayClient+HandlerBlocks.h"

@class NextDayClientGiftData, NextDayClientGiftReceiver;

@interface NextDayClient (Outbox)

- (void)sendGift:(NextDayClientGiftData *)gift
      toReceiver:(NextDayClientGiftReceiver *)receiver
      completion:(NextDayClientCompletionBlock)completionHandler;

- (void)deleteOutboxItemByID:(double)giftID
                        inTS:(double)ts
                  completion:(NextDayClientCompletionBlock)completionHandler;

@end
