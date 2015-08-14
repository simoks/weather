//
//  NetworkRequest.h
//  weather.forecast
//
//  Created by kouissi mohamed on 14/08/15.
//  Copyright (c) 2015 kouissi mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NetworkRequest;

@protocol NetworkRequestDelegate <NSObject>

@required

- (void)networkRequest:(NetworkRequest*) request didFailedWithError:(NSError*) error ;
- (void)networkRequest:(NetworkRequest*) request didFinishWithResponse:(id) response ;
@end

@interface NetworkRequest : NSObject

-(void) dataForUrl:(NSString*) urlData;
-(void) cancel ;

@property (nonatomic,assign) id <NetworkRequestDelegate> delegate ;

@end
