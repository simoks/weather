//
//  ModelSerializer.m
//  weather.forecast
//
//  Created by kouissi mohamed on 14/08/15.
//  Copyright (c) 2015 kouissi mohamed. All rights reserved.
//

#import "ModelSerializer.h"
#import "WeatherModel.h"

@implementation ModelSerializer


+ (instancetype) sharedInstance
{
    static id sharedInstance = nil;
    if (!sharedInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[self alloc] init];
        });
    }
    return sharedInstance;
}

- (WeatherModel*) createWeatherDictionary: (NSDictionary*)json {
    
    if(![json isKindOfClass:[NSDictionary class]]){
        
        NSAssert(json, @"Attempt to create an WeatherModel without json Dictionary");
        return nil;
    }
    
    WeatherModel *weather = [[WeatherModel alloc] init];
    
    weather.location = [self createLocationDictionary:[json objectForKey:@"location"]];
    
    weather.astronomy = [self createAstronomyDictionary:[json objectForKey:@"astronomy"]];
    
    weather.atmosphere = [self createAtmosphereDictionary:[json objectForKey:@"atmosphere"]];
    
    id item = [json objectForKey:@"item"];
    weather.condition = [self createConditionDictionary:[item objectForKey:@"condition"]];
    weather.forecast = [self createForcastArrayFromJsonArray:[item objectForKey:@"forecast"]];
    
    return weather;
}

- (Location*) createLocationDictionary: (NSDictionary*)json {
    
    if(![json isKindOfClass:[NSDictionary class]]){
        
        NSAssert(json, @"Attempt to create an Location without json Dictionary");
        return nil;
    }
    
    Location *location = [[Location alloc] init];
    
    location.city = [json objectForKey:@"city"];
    location.country = [json objectForKey:@"contry"];
    
    return location;
}

- (Astronomy*) createAstronomyDictionary: (NSDictionary*)json {
    
    if(![json isKindOfClass:[NSDictionary class]]){
        
        NSAssert(json, @"Attempt to create an Astronomy without json Dictionary");
        return nil;
    }
    
    Astronomy *astronomy = [[Astronomy alloc] init];
    
    astronomy.sunrise = [json objectForKey:@"sunrise"];
    astronomy.sunset = [json objectForKey:@"sunset"];
    
    return astronomy;
}

- (Atmpsphere*) createAtmosphereDictionary: (NSDictionary*)json {
    
    if(![json isKindOfClass:[NSDictionary class]]){
        
        NSAssert(json, @"Attempt to create an atmosphere without json Dictionary");
        return nil;
    }
    
    Atmpsphere *atmosphere = [[Atmpsphere alloc] init];
    
    atmosphere.humidity = [json objectForKey:@"humidity"];
    atmosphere.rising = [json objectForKey:@"rising"];
    atmosphere.pressure = [json objectForKey:@"pressure"];
    
    return atmosphere;
}

- (Condition*) createConditionDictionary: (NSDictionary*)json {
    
    if(![json isKindOfClass:[NSDictionary class]]){
        
        NSAssert(json, @"Attempt to create an Condition without json Dictionary");
        return nil;
    }
    
    Condition *condition = [[Condition alloc] init];
    
    condition.tmp = [json objectForKey:@"temp"];
    condition.descriptionCond = [json objectForKey:@"text"];
    
    return condition;
}

- (Forecast*) createForcastDictionary: (NSDictionary*)json {
    
    if(![json isKindOfClass:[NSDictionary class]]){
        
        NSAssert(json, @"Attempt to create an Forcast without json Dictionary");
        return nil;
    }
    
    Forecast *forcast = [[Forecast alloc] init];
    
    forcast.day = [json objectForKey:@"day"];
    forcast.high = [json objectForKey:@"high"];
    forcast.low = [json objectForKey:@"low"];
    
    return forcast;
}


- (NSArray*)createForcastArrayFromJsonArray:(NSArray*)jsonArray
{
    
    if(!jsonArray){
        
        return nil;
    }
    if(![jsonArray isKindOfClass:[NSArray class]]){
        
        NSAssert(jsonArray, @"json array isn't an NSArray");
        return @[];
    }
    
    NSMutableArray *modelArray =  [[NSMutableArray alloc] initWithCapacity:[jsonArray count]];
    
    for (NSDictionary* jsonObject in jsonArray) {
        
        id model = [self createForcastDictionary:jsonObject];
        
        if(model){
            
            [modelArray addObject:model];
        }
    }
    
    return [NSArray arrayWithArray:modelArray];
}

@end
