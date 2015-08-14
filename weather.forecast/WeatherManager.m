//
//  WeatherManager.m
//  weather.forecast
//
//  Created by kouissi mohamed on 14/08/15.
//  Copyright (c) 2015 kouissi mohamed. All rights reserved.
//

#import "WeatherManager.h"
#import "ModelSerializer.h"


NSString * dataUrl = @"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22lyon%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";

@implementation WeatherManager 



-(void) startNetworkRequest
{
    
    [self cancel];
    // inject dependence in Managers by a RequestFactory
    _networkRequest = [[NetworkRequest alloc] init];
    _networkRequest.delegate = self ;
    
    [self.networkRequest dataForUrl:dataUrl];
    
}


- (void)networkRequest:(NetworkRequest*) request didFailedWithError:(NSError*) error
{

}

- (void)networkRequest:(NetworkRequest*) request didFinishWithResponse:(id) response
{

    id object = [[ModelSerializer sharedInstance] createWeatherDictionary:response];
    
    [self.delegate weatherManager:self didLoadWeather:object];
}

-(void) cancel
{
    if ( _networkRequest )
    {
        _networkRequest.delegate = nil ;
        [_networkRequest cancel];
        _networkRequest = nil ;
    }
    
}


@end
