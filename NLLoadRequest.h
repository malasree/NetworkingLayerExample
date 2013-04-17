//
//  NLLoadRequest.h
//  NetworkingLayerExample
//
//  Created by Mala on 21/03/13.
//  Copyright (c) 2013 pramati. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NLLoadRequestDelegate <NSObject>

- (void) loadRequestWithResponseData: (NSData*)receivedData;
- (void) loadRequestWithErrorMessage: (NSError*)error;

@end

typedef void (^requestCompletionBlock_t)(NSData*);
typedef void (^requestFailedWithError_t) (NSError*);

@interface NLLoadRequest : NSOperation

{
    NSURLRequest *requestURL;
    
    NSURLConnection *connection;
    NSMutableData *receivedData;
    
    id<NLLoadRequestDelegate> delegate;
    
    NSString *identifier;
}

@property(readonly) BOOL isExecuting;
@property(readonly) BOOL isFinished;

@property(readonly) NSData *receivedData;
@property (nonatomic, assign) id<NLLoadRequestDelegate> delegate;
@property (nonatomic, retain) NSString *identifier;

- (id) initWithURL: (NSURLRequest*) request;
- (id) initWithURL: (NSURLRequest*) request completionBlock:(requestCompletionBlock_t) succBlk failedBlock:(requestFailedWithError_t) failedBlk;

@end