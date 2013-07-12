//
//  NextDayClient+Bridge.h
//  NextDayKit
//
//  Created by nickcheng on 13-7-12.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClient.h"
#import "NextDayClient+HandlerBlocks.h"

@interface NextDayClient (Bridge)

- (void)ensureEnvVarsReadyWithCompletion:(NextDayClientCompletionBlock)handler;

@end
