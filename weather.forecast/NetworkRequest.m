//
//  NetworkRequest.m
//  weather.forecast
//
//  Created by kouissi mohamed on 14/08/15.
//  Copyright (c) 2015 kouissi mohamed. All rights reserved.
//

#import "NetworkRequest.h"

#import <AFNetworking/AFHTTPRequestOperation.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <AFNetworking/AFJSONRequestOperation.h>

@interface NetworkRequest ()

@property (strong,nonatomic) AFHTTPRequestOperation *requestOperation  ;

@end

@implementation NetworkRequest

-(void) cancel
{
    
    [_requestOperation cancel];
    _requestOperation = nil ;
    
}

-(void) dataForUrl:(NSString*) urlData
{

//    NSURL *url = [NSURL URLWithString:urlData];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
//                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                                                            timeoutInterval:20.0];
//    [request setHTTPMethod:@"GET"];

    
    NSURL *url = [NSURL URLWithString:urlData];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // PARSE YOUR JSON DICTIONARY HERE
        //[self parseResult:JSON];
        NSLog(@"succes: %@", JSON);
        NSLog(@"succes: %@", JSON);
        id result = [JSON objectForKey:@"query"];
        id channel = [result objectForKey:@"results"];

        [self.delegate networkRequest:self didFinishWithResponse:[channel objectForKey:@"channel"]];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failed to get data from web service, error: %@", [error localizedDescription]);
    }];
    
    [operation start];

}


@end
