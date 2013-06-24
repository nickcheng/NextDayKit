//
//  NextDayClient+EnvVars.h
//  NextDayKit
//
//  Created by nickcheng on 13-6-23.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClient.h"
#import "NextDayClient+HandlerBlocks.h"

@class NextDayClientEnvVars;

@interface NextDayClient (EnvVars)

- (void)setVars:(NextDayClientEnvVars *)envVars completion:(NextDayClientCompletionBlock)completionHandler;
- (void)getVarsWithCompletion:(NextDayClientCompletionBlock)completionHandler;

@end
