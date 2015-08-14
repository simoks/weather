//
//  WeatherManager.h
//  weather.forecast
//
//  Created by kouissi mohamed on 14/08/15.
//  Copyright (c) 2015 kouissi mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkRequest.h"
@class WeatherManager;


@protocol WeatherManagerDelegate <NSObject>

@optional

-(void) weatherManager:(WeatherManager*) manager didLoadWeather:(id) model ;

@end

@interface WeatherManager : NSObject <NetworkRequestDelegate>

@property (strong,nonatomic) NetworkRequest *networkRequest ;
-(void) startNetworkRequest;

@property (nonatomic,assign) id <WeatherManagerDelegate> delegate ;

@end
