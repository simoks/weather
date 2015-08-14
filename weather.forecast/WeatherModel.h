//
//  WeatherModel.h
//  weather.forecast
//
//  Created by kouissi mohamed on 14/08/15.
//  Copyright (c) 2015 kouissi mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Forecast.h"
#import "Condition.h"
#import "Atmpsphere.h"
#import "Astronomy.h"

@interface WeatherModel : NSObject

@property (nonatomic) Location *location;
@property (nonatomic) Condition *condition;
@property (nonatomic, strong) NSArray *forecast;
@property (nonatomic) Atmpsphere *atmosphere;
@property (nonatomic) Astronomy *astronomy;

@end
