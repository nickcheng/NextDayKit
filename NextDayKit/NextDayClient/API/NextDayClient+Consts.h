//
//  NextDayClient+Consts.h
//  NextDayKit
//
//  Created by nickcheng on 13-8-20.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClient.h"
#import "NextDayClient+HandlerBlocks.h"

@interface NextDayClient (Consts)

- (void)getAllTableNameAndVersionWithCompletion:(NextDayClientCompletionBlock)completionHandler;
- (void)getTableByNameAndVersion:(NSArray *)nvArray completion:(NextDayClientCompletionBlock)completionHandler;

@end
