//
//  NextDayClient+Outbox.h
//  NextDayKit
//
//  Created by nickcheng on 13-7-3.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClient.h"
#import "NextDayClient+HandlerBlocks.h"

@class NextDayClientGiftData, NextDayClientGiftReceiver, NextDayClientGiftOutboxItem;

@interface NextDayClient (Outbox)

- (void)sendGift:(NextDayClientGiftData *)gift
      toReceiver:(NextDayClientGiftReceiver *)receiver
      completion:(NextDayClientCompletionBlock)completionHandler;

- (void)saveGift:(NextDayClientGiftData *)gift
      completion:(NextDayClientCompletionBlock)completionHandler;

- (void)deleteOutboxItemByID:(double)giftID
                        inTS:(double)ts
                  completion:(NextDayClientCompletionBlock)completionHandler;

- (void)updateGiftByID:(double)giftID
                  inTS:(double)ts
              withData:(NextDayClientGiftData *)gift
          withReceiver:(NextDayClientGiftReceiver *)receiver
            completion:(NextDayClientCompletionBlock)completionHandler;

@end
