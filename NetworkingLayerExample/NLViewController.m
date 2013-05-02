//
//  NLViewController.m
//  NetworkingLayerExample
//
//  Created by Mala on 19/03/13.
//  Copyright (c) 2013 pramati. All rights reserved.
//

#import "NLViewController.h"
#import "NLRequest.h"

@interface NLViewController ()

@end

@implementation NLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender
{
    NSOperationQueue *op = [[NSOperationQueue alloc] init];
        
    NSURLRequest *reqStr1 = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.apple.com/"]];
    NSLog(@"url %@",reqStr1);
    
    NLLoadRequest *request1 = [[NLLoadRequest alloc] initWithURL:reqStr1 completionBlock:^(NSData* receivedData){
        NSString* newStr = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"Received data = %@",newStr );
    }
    failedBlock:^(NSError* error){
        NSLog(@"Request failed with error: %@",error);
    }];
    
    
    
    NLRequest *nlRequest = [[NLRequest alloc] initWithURLString:@"http://www.apple.com/"];
    NSURLRequest *req = (NSURLRequest*)[nlRequest buildRequestURL];
    NSLog(@"url %@",req);
    
    NLLoadRequest *request2 = [[NLLoadRequest alloc] initWithURL:req completionBlock:^(NSData* receivedData){
        NSString* newStr = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"Received data = %@",newStr );
    }
                                                     failedBlock:^(NSError* error){
                                                         NSLog(@"Request failed with error: %@",error);
                                                     }];
    [op addOperation:request1];
    [op addOperation:request2];
    
}

#pragma NLLoadRequestDelegate Calls

//- (void) loadedRequestWithResponseData: (NSData*)receivedData
//{
//    NSString* newStr = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
//    NSLog(@"Received data = %@",newStr );
//}


@end
