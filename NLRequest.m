//
//  NLRequest.m
//  NetworkingLayerExample
//
//  Created by Mala on 29/04/13.
//  Copyright (c) 2013 pramati. All rights reserved.
//

#import "NLRequest.h"

@implementation NLRequest

@synthesize postData;
@synthesize urlString;
@synthesize requestMethod;
@synthesize postBody;

-(id)initWithURLString: (NSString*) newURL
{
    self.urlString = newURL;
    self.requestMethod = @"GET";
	return self;
}

- (void)setRequestMethod:(NSString *)newRequestMethod
{
	if (requestMethod != newRequestMethod) {
		[requestMethod release];
		requestMethod = [newRequestMethod retain];
	}
}

- (void) addPostDataValue: (NSString*) value forKey: (NSString*)key
{
    if (key == nil) {
        return;
    }
    NSMutableDictionary *pair = [[NSMutableDictionary alloc] initWithCapacity:2];
    [pair setValue:value forKey:@"value"];
    [pair setValue:key forKey:@"key"];
    
    [self.postData addObject:pair];
}

- (NSMutableURLRequest*) buildRequestURL
{
    //urlString = @"http://yourserver.com/upload.php";
    
    //NSString *boundary = @"---------------------------14737809831466499882746641449";
    //NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    NSMutableURLRequest *request= [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:self.urlString]];
    [request setHTTPMethod:self.requestMethod];
    //[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //NSMutableData *postbody = [NSMutableData data];
    //[postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //[postbody appendData:[NSData dataWithData:YOUR_NSDATA_HERE]];
    
    [request setHTTPBody:self.postBody];
    
    //NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", returnString);
    return request;
}


@end
