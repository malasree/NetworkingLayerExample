//
//  NLViewController.m
//  NetworkingLayerExample
//
//  Created by Mala on 19/03/13.
//  Copyright (c) 2013 pramati. All rights reserved.
//

#import "NLViewController.h"

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
    //NSURLRequest *reqStr = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.apple.com/"]];
    //NLLoadRequest *request = [[NLLoadRequest alloc] initWithURL:reqStr];
    //request.delegate = self;
    
    NSURLRequest *reqStr1 = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://api.meetup.com/2/categories?key=585661c6453d70b3c4dc220683c&sign=true"]];
    NLLoadRequest *request1 = [[NLLoadRequest alloc] initWithURL:reqStr1 completionBlock:^(NSData* receivedData){
        NSString* newStr = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"Received data = %@",newStr );
    }
    failedBlock:^(NSError* error){
        NSLog(@"Request failed with error: %@",error);
    }];
    
    //[op addOperation:request];
    [op addOperation:request1];
    
}

#pragma NLLoadRequestDelegate Calls

//- (void) loadedRequestWithResponseData: (NSData*)receivedData
//{
//    NSString* newStr = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
//    NSLog(@"Received data = %@",newStr );
//}


@end
