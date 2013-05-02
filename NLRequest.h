//
//  NLRequest.h
//  NetworkingLayerExample
//
//  Created by Mala on 29/04/13.
//  Copyright (c) 2013 pramati. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLRequest : NSObject
{
    //URL
    NSString *urlString;
    
    // Parameters that will be POSTed to the url
	NSMutableArray *postData;
    
    // HTTP method to use (eg: GET / POST) Default: GET
	NSString *requestMethod;
}

@property (nonatomic, retain) NSMutableArray *postData;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSString *requestMethod;
@property (retain) NSMutableData *postBody;

- (id) initWithURLString: (NSString*) newURL;
- (void) setRequestMethod: (NSString *) newRequestMethod;
- (NSMutableURLRequest*) buildRequestURL;
- (void) addPostDataValue: (NSString*) value forKey: (NSString*)key;

@end
