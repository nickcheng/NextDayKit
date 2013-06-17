//
//  NextDayClient.h
//  NextDayKit
//
//  Created by nickcheng on 13-6-16.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NextDayClient : NSObject

@property (nonatomic, assign) NSInteger messageCount;

+ (instancetype)sharedClient;

- (void)initClientWithCertificate:(NSString *)certURL andCipher:(NSString *)cipher;
- (void)connect;

@end
