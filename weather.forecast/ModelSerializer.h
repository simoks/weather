//
//  ModelSerializer.h
//  weather.forecast
//
//  Created by kouissi mohamed on 14/08/15.
//  Copyright (c) 2015 kouissi mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherModel.h"

@interface ModelSerializer : NSObject

+ (instancetype) sharedInstance ;

- (WeatherModel*) createWeatherDictionary: (NSDictionary*)json;

@end
