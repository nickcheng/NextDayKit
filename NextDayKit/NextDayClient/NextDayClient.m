//
//  NextDayClient.m
//  NextDayKit
//
//  Created by nickcheng on 13-6-16.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClient.h"
#import "SRWebSocket.h"
#import "NextDayClientConfig.h"

@interface NextDayClient () <SRWebSocketDelegate>
@end

@implementation NextDayClient {
  SRWebSocket *_webSocket;
  NSData *_certData;
  NSString *_certCipher;
  
  NSInteger _messageCount;
}

@synthesize messageCount = _messageCount;

#pragma mark -
#pragma mark Init

+ (instancetype)sharedClient {
  static NextDayClient *sharedNextDayClient = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedNextDayClient = [[NextDayClient alloc] init];
  });
  return sharedNextDayClient;
}

- (id)init {
  //
	if((self = [super init]) == nil) return nil;
  
  //
  _messageCount = 0;
  
  return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)initClientWithCertificate:(NSString *)certURL andCipher:(NSString *)cipher {
  _certData = [[NSData alloc] initWithContentsOfFile:certURL];
  _certCipher = cipher;
  [self initWebSocket];
}

- (void)connect {
  if (_webSocket.readyState != SR_OPEN)
    [_webSocket open];
}

#pragma mark -
#pragma mark SocketRocket

- (void)initWebSocket {
  _webSocket.delegate = nil;
  [_webSocket close];
  
  // Init Websocket connection
  if (_certData != nil && _certCipher.length > 0) {
    NSURL *url = [NSURL URLWithString:NEXTDAY_SERVERURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:request
                                       andClientCertData:_certData
                                     andClientCertCipher:_certCipher];
    _webSocket.delegate = self;
  } else {
    NDLE(@"No certificate found! Can't use NextDayClient.");
  }

}

#pragma mark -
#pragma mark SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
  NDLI(@"Websocket Connected");
  
  // Reset MessageCount
  NDLI(@"Reset MessageCount. Last one was:%d", self.messageCount);
  self.messageCount = 0;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
  NDLI(@"Received \"%@\"", message);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
  NDLI(@"WebSocket closed");
  
  _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
  NDLI(@":( Websocket Failed With Error %@", error);
  
  _webSocket = nil;
}

@end
