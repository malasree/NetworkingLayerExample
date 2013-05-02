//
//  NLDataRequest.m
//  NetworkingLayerExample
//
//  Created by Mala on 29/04/13.
//  Copyright (c) 2013 pramati. All rights reserved.
//

#import "NLDataRequest.h"


@implementation NLDataRequest

@synthesize stringEncoding;

-(id)initWithURLString: (NSString*) newURL
{
    self = [super initWithURLString:newURL];
    [self setRequestMethod:@"POST"];
    [self setStringEncoding:NSUTF8StringEncoding];
	return self;
}

-(void) buildPostData
{
    // Adds post data
    CFUUIDRef uuid = CFUUIDCreate(nil);
	NSString *uuidString = [(NSString*)CFUUIDCreateString(nil, uuid) autorelease];
	CFRelease(uuid);
    NSString *stringBoundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];
	NSString *endItemBoundary = [NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary];
	NSUInteger i=0;
	for (NSDictionary *val in [self postData])
    {
		[self appendPostString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",[val objectForKey:@"key"]]];
		[self appendPostString:[val objectForKey:@"value"]];
		i++;
		if (i != [[self postData] count] )  //Only add the boundary if this is not the last item in the post body
        {
			[self appendPostString:endItemBoundary];
		}
	}
}

- (void)appendPostString:(NSString *)string
{
	[self appendPostData:[string dataUsingEncoding:[self stringEncoding]]];
}

- (void)appendPostData:(NSData *)data
{
	[self setupPostBody];
	if ([data length] == 0) {
		return;
	}
	[[self postBody] appendData:data];
}

- (void)setupPostBody
{
	if (![self postBody])
    {
        [self setPostBody:[[[NSMutableData alloc] init] autorelease]];
    }
}

@end
