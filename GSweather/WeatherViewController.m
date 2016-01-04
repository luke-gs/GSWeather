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

@end

@implementation WeatherViewController


#pragma  mark - Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setNeedsStatusBarAppearanceUpdate];
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
    // Title Label
    self.self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"Melbourne, AU";
    self.titleLabel.textColor = [UIColor whiteTextColor];
    self.titleLabel.font = [UIFont systemFontOfSize:22];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.view addSubview:self.titleLabel];
    
    // Sun Image
    self.sunImageView = [[UIImageView alloc]init];
    self.sunImageView.image = [UIImage imageNamed:@"clear-day.png"];
    self.sunImageView.translatesAutoresizingMaskIntoConstraints  = NO;
    self.sunImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.sunImageView];
    self.sunImageView.layer.shadowOffset = CGSizeMake(3, 3);
    self.sunImageView.layer.shadowOpacity = 0.5;
    self.sunImageView.layer.shadowRadius = 5;
    self.sunImageView.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    
    //weather Label
    self.weatherLabel = [[UILabel alloc]init];
    self.weatherLabel.text = [NSString stringWithFormat:@"%@", @"17.6°"];
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
    self.clearLabel.text = @"Clear Day";
    self.clearLabel.textColor = [UIColor blueTextColor];
    self.clearLabel.font = [UIFont smallTitleFont];
    self.clearLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.self.clearLabel];
    
    //tempLabel
    self.tempLabel = [[UILabel alloc]init];
    self.tempLabel.text =@"15°/24°";
    self.tempLabel.textColor = [UIColor whiteColor];
    self.tempLabel.font = [UIFont smallTitleFont];
    self.tempLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.tempLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.tempLabel];
    
    //dateLabel
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.text = [NSString stringWithFormat:@"Mon, 4 Jan"];
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
    
    //table Cells
    
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
    [NSLayoutConstraint constraintWithItem:self.tempLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0],
    [NSLayoutConstraint constraintWithItem:self.tempLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.dateLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0],
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

#pragma mark -  UITableView DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ReuseIdentifier];
    [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    
    //text
    cell.textLabel.text = @"Monday";
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont cellFont];
    
    //detail
    cell.detailTextLabel.text = @"15°/24°";
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont cellFont];
    //image
    cell.imageView.image = [UIImage imageNamed:@"clear-day-small"];
    
    
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
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
