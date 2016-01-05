//
//  WeatherViewController.m
//  GSweather
//
//  Created by Luke sam/Users/Luke/Downloads/Artwork/clear-day-small@3x.pngmut on 4/01/2016.
//  Copyright © 2016 Luke sammut. All rights reserved.
//

#import "WeatherViewController.h"
#import "UIColor+Extended.h"
#import "UIFont+Extended.h"
#import "FileUtilities.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Day.h"
#import "Weather.h"
#import "WeatherUtilities.h"
#import "Time.h"

static NSString *const ReuseIdentifier = @"weatherCell";

@interface WeatherViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *weatherLabel;
@property (strong, nonatomic) UILabel *clearLabel;
@property (strong,nonatomic) UILabel *tempLabel;
@property (strong, nonatomic) UILabel *dateLabel;

@property (strong, nonatomic) UIImage *sunImage;
@property (strong,nonatomic) UIImageView *sunImageView;
@property (strong,nonatomic) UITableView *tabel;

@property (strong, nonatomic) Weather *weather;

@end

@implementation WeatherViewController


#pragma  mark - Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [self fetchJSONData];
    [self setupViews];
    
    
    // Do any additional setup after loading the view.
}

-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setSunImage:(UIImage *)sunImage
{
    _sunImage = sunImage;
    self.sunImageView.image = sunImage;
}


- (void)setupViews
{
    if(self.weather)
    {
        // Title Label
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = [NSString stringWithFormat:@"%@",self.weather.timeZone];
        self.titleLabel.textColor = [UIColor whiteTextColor];
        self.titleLabel.font = [UIFont systemFontOfSize:22];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.view addSubview:self.titleLabel];
        
        // Sun Image
        self.sunImageView = [[UIImageView alloc]init];
        self.sunImageView.image = [UIImage imageNamed:self.weather.currentTime.icon];
        self.sunImageView.translatesAutoresizingMaskIntoConstraints  = NO;
        self.sunImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:self.sunImageView];
        self.sunImageView.layer.shadowOffset = CGSizeMake(3, 3);
        self.sunImageView.layer.shadowOpacity = 0.5;
        self.sunImageView.layer.shadowRadius = 5;
        self.sunImageView.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
        
        //weather Label
        self.weatherLabel = [[UILabel alloc]init];
        self.weatherLabel.text = [NSString stringWithFormat:@"%@°", self.weather.currentTime.temperature];
        self.weatherLabel.textColor = [UIColor whiteTextColor];
        self.weatherLabel.font = [UIFont weatherTitleFont];
        self.weatherLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.weatherLabel];

        
        //background
        CAGradientLayer *gradient =  [CAGradientLayer layer];
        gradient.frame = self.view.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.49 green:0.93 blue:0.73 alpha:1]CGColor],(id)[[UIColor colorWithRed:0.38 green:0.52 blue:0.92 alpha:1]CGColor], nil];
        [self.view.layer insertSublayer:gradient atIndex:0];
        //self.view.backgroundColor = [UIColor colorWithRed:0.38 green:0.52 blue:0.92 alpha:1];
        //
        
        //clearLabel
        self.clearLabel = [[UILabel alloc]init];
        self.clearLabel.text = [NSString stringWithFormat:@"%@", self.weather.currentTime.summary];
        self.clearLabel.textColor = [UIColor blueTextColor];
        self.clearLabel.font = [UIFont smallTitleFont];
        self.clearLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.self.clearLabel];
        
        //tempLabel
        self.tempLabel = [[UILabel alloc]init];
        self.tempLabel.text = [NSString stringWithFormat:@"%f / %f", 0.0, 0.0];
        self.tempLabel.textColor = [UIColor whiteColor];
        self.tempLabel.font = [UIFont smallTitleFont];
        self.tempLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.tempLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.tempLabel];
        
        //dateLabel
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.text = [NSString stringWithFormat:@"%@", self.weather.currentTime.time];
        self.dateLabel.textColor = [UIColor whiteTextColor];
        self.dateLabel.font = [UIFont cellFont];
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.self.dateLabel];
        
        
        //table info
        self.tabel = [[UITableView alloc] init];
        [self.view addSubview:self.tabel];
        self.tabel.backgroundColor = [UIColor clearColor];
        self.tabel.separatorColor = [UIColor colorWithRed:0.62 green:0.98 blue:0.99 alpha:1];
        self.tabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.tabel.delegate = self;
        self.tabel.dataSource = self;
        
    #pragma mark - Constraints
        
        [NSLayoutConstraint activateConstraints:@[
        
        //titlelable constraints
        [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
        
        [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:30],
        
        //self.sunImage constraints
        [NSLayoutConstraint constraintWithItem:self.sunImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.weatherLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:-30],
        [NSLayoutConstraint constraintWithItem:self.sunImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.sunImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30],
        [NSLayoutConstraint constraintWithItem:self.sunImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],

        
        
        //self.weatherLabel constraints
        [NSLayoutConstraint constraintWithItem:self.weatherLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],
        
        [NSLayoutConstraint constraintWithItem:self.weatherLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
        
        //self.self.clearLabel
        [NSLayoutConstraint constraintWithItem:self.clearLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20],
        [NSLayoutConstraint constraintWithItem:self.clearLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.weatherLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10],
        
        //tempLabel
        [NSLayoutConstraint constraintWithItem:self.tempLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20],
        //[NSLayoutConstraint constraintWithItem:self.tempLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.dateLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.tempLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.weatherLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10],
        
        //self.dateLabel
        [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tempLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5],
        [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20],
        
        //tableConstraints
        [NSLayoutConstraint constraintWithItem:self.tabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.tabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.dateLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10],
        [NSLayoutConstraint constraintWithItem:self.tabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.tabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],
        
        ]];
    }
}

#pragma mark -  UITableView DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ReuseIdentifier];
    [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    
    //text
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont cellFont];
    
    //detail
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont cellFont];
    
    //imageView setup
    cell.imageView.frame = CGRectMake(0, 0, 44, 44);

    if(self.weather)
    {
        Day* dailyWeather = [self.weather sortedDailyWeather][indexPath.row];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"EEEE"];
        cell.textLabel.text = [dateFormatter stringFromDate:dailyWeather.date];
        
        
        cell.detailTextLabel.text = [dailyWeather minMaxTemperature];
        
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-small",dailyWeather.icon]];
    }
    
    
    return cell;
}

-(void) updateWeatherDataFields
{
    if(!self.titleLabel)
    {
        [self setupViews];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@",self.weather.timeZone];
    self.sunImageView.image = [UIImage imageNamed:self.weather.currentTime.icon];
    self.weatherLabel.text =
    [NSString stringWithFormat:@"%.1f°",[WeatherUtilities farenheitToCelcius:[self.weather.currentTime.temperature doubleValue]]];
    self.clearLabel.text = [NSString stringWithFormat:@"%@", self.weather.currentTime.summary];
    
    //get min max
    NSArray *dailyWeather = [self.weather sortedDailyWeather];
    Day *firstDay  = [dailyWeather firstObject];
    self.tempLabel.text = [firstDay minMaxTemperature];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc ]init];
    [dateFormatter setDateFormat:@"EEE, d MMM"];
    self.dateLabel.text = [dateFormatter stringFromDate:self.weather.currentTime.time];

    

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!self.weather){
        return 0;
    }else
        return [[self.weather.dailyWeather allObjects] count];
}

-(void) fetchJSONData
{
    //fetch the data from a file (using helper class)
    NSDictionary* jSONDictionary = [FileUtilities dictionaryFromJSONFile:@"weather"];
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        //clear previous weather objects
        [Weather MR_truncateAllInContext:localContext];
        
        //create the weather entity
        //self.weather = [[Weather alloc]init];
        [Weather weatherFromDictionary:jSONDictionary inContext:localContext];

    } completion:^(BOOL contextDidSave, NSError *error) {
        
        //set the value of the weather to be the weather data from the core data
        self.weather = [Weather MR_findFirst];
        [self updateWeatherDataFields];
    }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
