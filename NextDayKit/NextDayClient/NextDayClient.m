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
#import "NextDayClientRequest.h"
#import "NSArray+SSToolkitAdditions.h"

@interface NextDayClient () <SRWebSocketDelegate>
@end

@implementation NextDayClient {
  SRWebSocket *_webSocket;
  NSData *_certData;
  NSString *_certCipher;
  NSMutableArray *_sendQueueWhenConnecting;
  
  NextDayClientReadyState _readyState;
  NSInteger _messageCount;
  NSMutableDictionary *_requestHandlers;
  
  BOOL _isEnvReady;
  BOOL _triedFailReconnectFlag;
  BOOL _triedSendReconnectFlag;
}

@synthesize readyState = _readyState;
@synthesize messageCount = _messageCount;
@synthesize isEnvReady = _isEnvReady;

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
  _messageCount = 1;
  _requestHandlers = [[NSMutableDictionary alloc] init];
  _readyState = NextDayClientReadyStateClosed;
  _sendQueueWhenConnecting = [[NSMutableArray alloc] init];
  _isEnvReady = NO;
  _triedFailReconnectFlag = NO;
  _triedSendReconnectFlag = NO;
  
  return self;
}

#pragma mark -
#pragma mark Getter / Setter

- (NextDayClientReadyState)readyState {
  if (_webSocket != nil)
    _readyState = (NextDayClientReadyState)_webSocket.readyState;
    
  return _readyState;
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

- (void)send:(NextDayClientRequest *)request completion:(NextDayClientResponseBlock)handler {
  // If socket is connecting, queue the request
  if (self.readyState == NextDayClientReadyStateConnecting) {
    [_sendQueueWhenConnecting addObject:@[request, handler]];
    return;
  }
  
  // Check connection. If need reconnect.
  if (self.readyState != NextDayClientReadyStateOpen) {
    if (!_triedSendReconnectFlag) {
      _triedSendReconnectFlag = YES;
      [_sendQueueWhenConnecting addObject:@[request, handler]];
      //
      _webSocket = nil;
      [self initWebSocket];
      [self connect];
    } else {
      NSError *error = [NSError errorWithDomain:NEXTDAYCLIENT_ERRORDOMAIN
                                           code:400
                                       userInfo:@{NSLocalizedDescriptionKey: @"Connection is not open. Please check connection or try again later."}];
      if (handler != nil)
        handler(nil, error);
      
      _triedSendReconnectFlag = NO;
    }
    return;
  }
  
  // Add MessageCount to request
  request.messageCount = self.messageCount;
  self.messageCount ++;
  
  // Parse request to json
  NSError *error;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:request.data options:NSJSONWritingPrettyPrinted error:&error];
  if (error != nil) {
    if (handler != nil)
      handler(nil, error);
    return;
  }
  NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

  // Send json
  NDLI(@"Sending No.%d message: %@", request.messageCount, jsonString);
  [_webSocket send:jsonString];
  _requestHandlers[[NSNumber numberWithInteger:request.messageCount]] = handler;
}

#pragma mark -
#pragma mark Private Methods

- (void)resetVariables {
  if (!_triedSendReconnectFlag)
    [_requestHandlers removeAllObjects];
  self.messageCount = 1;
  self.isEnvReady = NO;
  _triedFailReconnectFlag = NO;
  _triedSendReconnectFlag = NO;
}

- (void)processAPIMessage:(NSDictionary *)dict {
  
}

- (void)processResponseMessage:(NSDictionary *)dict {
  // Get messagecount and Callback handler
  NSNumber *responseMessageCount = dict[@"messageCount"];
  if ([_requestHandlers.allKeys containsObject:responseMessageCount]) {
    NDLI(@"Response found matched request handler: %@", responseMessageCount);
    NextDayClientResponseBlock handler = _requestHandlers[responseMessageCount];
    handler(dict, nil);
    
    // Remove handler
    [_requestHandlers removeObjectForKey:responseMessageCount];
  } else {
    NDLE(@"Response can't found matched request handler: %@", responseMessageCount);
  }
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
  [self resetVariables];
  
  // Process requests sent when connecting
  if (_sendQueueWhenConnecting != nil && _sendQueueWhenConnecting.count > 0) {
    NSArray *array = _sendQueueWhenConnecting.firstObject;
    while (array != nil) {
      if (array != nil && array.count == 2) {
        NextDayClientRequest *req = array[0];
        NextDayClientResponseBlock resB = array[1];
        [self send:req completion:resB];
      }
      [_sendQueueWhenConnecting removeObject:array];
      array = _sendQueueWhenConnecting.firstObject;
    }
  }
  
  // Call connection opened handler
  if (self.connectedHandler != nil) {
    self.connectedHandler();
  }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
  NDLI(@"Received \"%@\"", message);
  
  // Parse response to dict
  NSData *jsonData = [(NSString *)message dataUsingEncoding:NSUTF8StringEncoding];
  NSError *error;
  NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
  if (error != nil) {
    NDLE(@"Parsing server response to json dict error: %@", error);
    return;
  }
  
  // check is response or api
  NSString *context = jsonObject[@"context"];
  if ([context isEqualToString:@"api"]) {
    [self processAPIMessage:jsonObject];
  } else if ([context isEqualToString:@"response"]) {
    [self processResponseMessage:jsonObject];
  }

}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
  NDLI(@"WebSocket closed. Code:%d. reason:%@", code, reason);
  
  _webSocket = nil;
  _readyState = NextDayClientReadyStateClosed;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
  NDLI(@":( Websocket Failed With Error %@", error);
  
  //
  _webSocket = nil;
  _readyState = NextDayClientReadyStateClosed;
  
  // Reconnect once
  if (!_triedFailReconnectFlag) {
    _triedFailReconnectFlag = YES;
    [self initWebSocket];
    [self connect];
  }
}

@end
