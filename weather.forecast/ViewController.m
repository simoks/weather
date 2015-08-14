//
//  ViewController.m
//  weather.forecast
//
//  Created by kouissi mohamed on 14/08/15.
//  Copyright (c) 2015 kouissi mohamed. All rights reserved.
//

#import "ViewController.h"
#import "WeatherModel.h"

@interface ViewController () <UITableViewDataSource, UITableViewDataSource>
{

    WeatherManager *weatherManager;
    
    __weak IBOutlet UILabel *_city;
    
    __weak IBOutlet UILabel *_description;
    
    __weak IBOutlet UILabel *_temp;
    
    
    __weak IBOutlet UITableView *_forecasstTableView;
    
    NSArray *_forecastData;
    
    
    __weak IBOutlet UILabel *_sunrise;
    __weak IBOutlet UILabel *_sunset;
    __weak IBOutlet UILabel *_rain;
    __weak IBOutlet UILabel *_pression;
    __weak IBOutlet UILabel *_humidity;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    weatherManager = [[WeatherManager alloc] init];
    
    weatherManager.delegate = self;
    [weatherManager startNetworkRequest];
}

-(void) weatherManager:(WeatherManager*) manager didLoadWeather:(id) model
{

    WeatherModel *weather = model;
    _city.text = weather.location.city;
    _description.text = weather.condition.descriptionCond;
    _temp.text = weather.condition.tmp;
    
    _sunrise.text = weather.astronomy.sunrise;
    _sunset.text = weather.astronomy.sunset;
    
    _rain.text = weather.atmosphere.rising;
    _humidity.text = weather.atmosphere.humidity;
    _pression.text = weather.atmosphere.pressure;
    
    _forecastData = weather.forecast;
    
    [self reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_forecastData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Forecast *forecast = [_forecastData objectAtIndex:indexPath.row];
    
    NSString *espace = @"                                    ";
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@  %@", forecast.day,espace, [self FahrenheitToCelsius:forecast.low], [self FahrenheitToCelsius:forecast.high]];
    
    return cell;
}

- (void) reloadData
{
    [_forecasstTableView reloadData];
}

- (NSString*) FahrenheitToCelsius:(NSString*)Fahrenheit{

    NSInteger valF = [Fahrenheit integerValue];
    
    NSInteger valC = (valF  -  32)  *  5/9 ;
    
    return [NSString stringWithFormat:@"%ld", (long)valC];
}


@end
