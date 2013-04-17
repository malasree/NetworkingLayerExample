//
//  NLLoadRequest.m
//  NetworkingLayerExample
//
//  Created by Mala on 21/03/13.
//  Copyright (c) 2013 pramati. All rights reserved.
//

#import "NLLoadRequest.h"

@interface NLLoadRequest ()

@property(assign) BOOL isExecuting;
@property(assign) BOOL isFinished;
@property (nonatomic, copy) requestCompletionBlock_t successBlock;
@property (nonatomic, copy) requestFailedWithError_t failureBlock;

@end

@implementation NLLoadRequest

@synthesize isExecuting;
@synthesize isFinished;
@synthesize receivedData;
@synthesize delegate;
@synthesize identifier;


#pragma mark Initialization

- (id) initWithURL: (NSURLRequest*) request
{
    [super init];
    requestURL = [request retain];
    return self;
}

- (id) initWithURL: (NSURLRequest*) request completionBlock:(requestCompletionBlock_t) succBlk failedBlock:(requestFailedWithError_t) failedBlk
{
    [super init];
    requestURL = [request retain];
    self.successBlock = succBlk;
    self.failureBlock = failedBlk;
    return self;
}

- (void) dealloc
{
    [requestURL release];
    [receivedData release];
    [super dealloc];
}

#pragma mark NSOperation Stuff

- (void) main
{
    // Bail out early if cancelled.
    if ([self isCancelled]) {
        [self setIsFinished:YES];
        [self setIsExecuting:NO];
        return;
    }
    
    [self setIsExecuting:YES];
    [self setIsFinished:NO];
    
    // Make sure the connection runs in the main run loop.
    connection = [[NSURLConnection alloc] initWithRequest:requestURL delegate:self startImmediately:NO];
    [self release];
        
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [connection start];
}

#pragma mark NSURLConnection Callbacks

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = [[NSMutableData data] retain];
}

- (void) connection: (NSURLConnection*) cn didReceiveData: (NSData*) data
{
    
    // Not cancelled, receive data.
    if (![self isCancelled]) {
        [receivedData appendData:data];
        return;
    }
    
    // Cancelled, tear down connection.
    [self setIsExecuting:NO];
    [self setIsFinished:YES];
    [connection cancel];
    [connection release];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) cn
{
    [self setIsExecuting:NO];
    [self setIsFinished:YES];
    
    if ([self.delegate respondsToSelector:@selector(loadRequestWithResponseData:)]) {
        
        [self.delegate loadRequestWithResponseData: receivedData];
    }
    
    if (self.successBlock)
    {
        self.successBlock (receivedData);
    }
    
    [connection release];
}

- (void) connection: (NSURLConnection*) cn didFailWithError: (NSError*) error
{
    [self setIsExecuting:NO];
    [self setIsFinished:YES];
    
    if ([self.delegate respondsToSelector:@selector(loadRequestWithErrorMessage:)]) {
        
        [self.delegate loadRequestWithErrorMessage: error];
    }
    
    if (self.failureBlock)
    {
        self.failureBlock (error);
    }
    
    [connection release];
    [receivedData release];
}

@end
