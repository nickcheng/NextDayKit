//
//  NextDayClient+SharingStatus.h
//  NextDay
//
//  Created by nickcheng on 14-8-9.
//  Copyright (c) 2014年 nxmix.com. All rights reserved.
//

#import "NextDayClient.h"
#import "NextDayClient+HandlerBlocks.h"

typedef enum {
  NextDaySharingChannelWeChatMoments = 0,
  NextDaySharingChannelWeibo,
  NextDaySharingChannelInstagram,
  NextDaySharingChannelTwitter,
  NextDaySharingChannelFacebook
} NextDaySharingChannel;

@interface NextDayClient (SharingStatus)

- (void)shareGift:(id)gift
        inChannel:(NextDaySharingChannel)channel
       completion:(NextDayClientCompletionBlock)completionHandler;

- (void)shareGiftByID:(NSString *)sharingID
            inChannel:(NextDaySharingChannel)channel
           completion:(NextDayClientCompletionBlock)completionHandler;

@end
