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
#import "NextDayClientGiftData.h"
#import "NextDayClientGiftReceiver.h"
#import "NextDayClient+Outbox.h"
#import "NextDayClient+Consts.h"
#import "SingletonData.h"
#import "Consts.h"
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
  
  [[NextDayClient sharedClient] subscribeLogFromTS:0 maxReturnCount:10 completion:^(BOOL success, id result, NSError *error) {
    NSLog(@"Result: %@", result);
  }];
}

- (IBAction)Action2Tapped:(id)sender {
  [[NextDayClient sharedClient] getLogDetailsFrom:@[@{@"source": @"in", @"sourceId": @"2840117825+4"}]
                                       completion:^(BOOL success, id result, NSError *error) {
                                         NSLog(@"Result: %@", result);
                                       }];
}

- (IBAction)sendGiftTapped:(id)sender {
  
  // Build gift
  NextDayClientGiftData *gift = [[NextDayClientGiftData alloc] init];
  gift.backgroundColor = @"#000000";
  gift.imageURL = @"{img}/userpic/0D15D885-2676-4729-B62F-5E54577CD629-26825-0001491991835669.jpg";
  gift.phrase1 = @"这个是测试礼物";
  gift.phrase2 = @"一堆一堆的礼物飞了过来啊吧哈啦!";
  gift.event = @"愚蠢愚人节";
  
  // Build Recevier
  NextDayClientGiftReceiver *receiver = [[NextDayClientGiftReceiver alloc] init];
  receiver.weiboID = @"1655001967";
  receiver.weiboName = @"Receiver";
  receiver.weiboRemark = @"收件人";
  receiver.weiboAvatar = @"http://tp1.sinaimg.cn/1404376560/180/0/1";
  receiver.timezoneOffset = @"+8:00"; // todo: Get timezone from user's location
  receiver.scheduledDate = [NSString stringWithFormat:@"%d-%02d-%02d 00:00:01",
                            2013, 7, 30];
  
  //
  [[NextDayClient sharedClient] sendGift:gift
                              toReceiver:receiver
                              completion:^(BOOL success, id result, NSError *error) {
                                NSLog(@"Result: %@; Error: %@", result, error);
                              }];
}

- (IBAction)getConstsTableNameTapped:(id)sender {
  [[NextDayClient sharedClient] getAllTableNameAndVersionWithCompletion:^(BOOL success, id result, NSError *error) {
    NSLog(@"%@", result);
  }];
}

- (IBAction)getConstTableTapped:(id)sender {
  NSArray *array = @[
                     @{
                       @"name": @"asset",
                       @"version": @0
                       },
                     @{
                       @"name": @"colors",
                       @"version": @0
                       },
                     @{
                       @"name": @"config",
                       @"version": @0
                       },
                     @{
                       @"name": @"holiday",
                       @"version": @0
                       },
                     @{
                       @"name": @"holiday/zh-cn",
                       @"version": @0
                       },
                     @{
                       @"name": @"short_timezone",
                       @"version": @0
                       },
                     @{
                       @"name": @"weibo_province",
                       @"version": @0
                       },
                     @{
                       @"name": @"upload",
                       @"version": @0
                       },
                     ];
  [[NextDayClient sharedClient] getTableByNameAndVersion:array completion:^(BOOL success, id result, NSError *error) {
    NSDictionary *dict = result;
    NSLog(@"%@", dict);
    
    //
  }];
  
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
 
	//
  NSString *certPath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
  [[NextDayClient sharedClient] initClientWithCertificate:certPath andCipher:@"123456"];
  [[NextDayClient sharedClient] connect];
  
  //
//  [NextDayClient sharedClient].connectedHandler = ^{
//    NextDayClientEnvVars *ev = [[NextDayClientEnvVars alloc] init];
//    ev.weiboID = @"2840117825"; // Nick: 1655001967; Jacob: 1641430494; Dev@nxmix.com: 2840117825
//    ev.weiboToken = @"2.00B5qMGDLRYaHEde7a79127bzhLSLC";
//    ev.weiboTokenExpiresAt = [[[NSDate date] dateByAddingTimeInterval:60*60*24] ISO8601String];
//    ev.weiboAvatar = @"http://tp1.sinaimg.cn/1653971412/180/5650247490/1";
//    ev.weiboName = @"兔子劫机Jackey";
//    ev.weiboGender = 2;
//    ev.weiboLocation = @"月球上的某处";
//    ev.deviceId = [OpenUDID value];
//    [[NextDayClient sharedClient] setVars:ev completion:^(BOOL success, id result, NSError *error) {
//      if (success)
//        NSLog(@"Env Set!");
//      else
//        NSLog(@"Env set error: %@", error);
//    }];
//  };
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
