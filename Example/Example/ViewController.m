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

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)Action1Tapped:(id)sender {
  [[NextDayClient sharedClient] getCalDataFromDate:[NSDate date]
                                            toDate:[NSDate date]
                                        completion:^(BOOL success, id result, NSError *error) {
                                          NSLog(@"IN: %@", result);
                                        }];
  
//  [[NextDayClient sharedClient] getCalDataFromDates:@[[NSDate date]] completion:^(BOOL success, id result, NSError *error) {
//    NSLog(@"IN: %@", result);
//  }];
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
