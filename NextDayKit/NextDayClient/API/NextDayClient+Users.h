//
//  NextDayClient+Users.h
//  NextDayKit
//
//  Created by nickcheng on 13-8-9.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClient.h"
#import "NextDayClient+HandlerBlocks.h"

@interface NextDayClient (Users)

- (void)checkNextDayUserFromArray:(NSArray *)idArray completion:(NextDayClientCompletionBlock)completionHandler;

@end
