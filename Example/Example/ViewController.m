//
//  ViewController.m
//  Example
//
//  Created by nickcheng on 13-6-16.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "ViewController.h"
#import "NextDayClient.h"
#import "NextDayClient+Calendar.h"
#import "NextDayClient+Log.h"
#import "NextDayClient+EnvVars.h"
#import "NextDayClientEnvVars.h"
#import "OpenUDID.h"
#import "NSDate+SSToolkitAdditions.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)Action1Tapped:(id)sender {
//  [[NextDayClient sharedClient] getCalDataFromDate:[NSDate date]
//                                            toDate:[NSDate date]
//                                        completion:^(BOOL success, id result, NSError *error) {
//                                          NSLog(@"IN: %@", result);
//                                        }];
  
//  [[NextDayClient sharedClient] getCalDataFromDates:@[[NSDate date]] completion:^(BOOL success, id result, NSError *error) {
//    NSLog(@"IN: %@", result);
//  }];
  
  NextDayClientEnvVars *ev = [[NextDayClientEnvVars alloc] init];
  ev.weiboID = @"1655001967";
  ev.weiboToken = @"2.00B5qMGDx9UQnB16a6daad5cPgu2bB";
  ev.weiboTokenExpiresAt = [[[NSDate date] dateByAddingTimeInterval:60*60*24] ISO8601String];
  ev.deviceId = [OpenUDID value];
  [[NextDayClient sharedClient] setVars:ev completion:^(BOOL success, id result, NSError *error) {
    if (success) {
      NSLog(@"Set done!");
      [[NextDayClient sharedClient] subscribeFromTS:0 maxReturnCount:10 completion:^(BOOL success, id result, NSError *error) {
        NSLog(@"Result: %@", result);
      }];
    }
  }];
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
	//
  NSString *certPath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
  [[NextDayClient sharedClient] initClientWithCertificate:certPath andCipher:@"123456"];
  [[NextDayClient sharedClient] connect];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
