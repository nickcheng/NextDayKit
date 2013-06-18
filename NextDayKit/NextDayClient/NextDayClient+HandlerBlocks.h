//
//  NextDayClient+HandlerBlocks.h
//  NextDayKit
//
//  Created by nickcheng on 13-6-17.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClient.h"

typedef void (^NextDayClientCompletionBlock)(BOOL success, id result, NSError *error);

@interface NextDayClient (HandlerBlocks)

@end
