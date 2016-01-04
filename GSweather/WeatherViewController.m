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

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    
    
    // Do any additional setup after loading the view.
}


- (void)setupViews
{
    // Title Label
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"Melbourne, AU";
    titleLabel.textColor = [UIColor whiteTextColor];
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.view addSubview:titleLabel];
    
    // Sun Image
    UIImageView *sunImage = [[UIImageView alloc]init];
    sunImage.image = [UIImage imageNamed:@"clear-day.png"];
    sunImage.translatesAutoresizingMaskIntoConstraints  = NO;
    sunImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:sunImage];
    sunImage.layer.shadowOffset = CGSizeMake(3, 3);
    sunImage.layer.shadowOpacity = 0.5;
    sunImage.layer.shadowRadius = 5;
    sunImage.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    
    //weather Label
    UILabel *weatherLabel = [[UILabel alloc]init];
    weatherLabel.text = [NSString stringWithFormat:@"%@", @"17.6°"];
    weatherLabel.textColor = [UIColor whiteTextColor];
    weatherLabel.font = [UIFont weatherTitleFont];
    weatherLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:weatherLabel];

    
    //background
    CAGradientLayer *gradient =  [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.49 green:0.93 blue:0.73 alpha:1]CGColor],(id)[[UIColor colorWithRed:0.38 green:0.52 blue:0.92 alpha:1]CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    //self.view.backgroundColor = [UIColor colorWithRed:0.38 green:0.52 blue:0.92 alpha:1];
    //
    
    //clearLabel
    UILabel *clearLabel = [[UILabel alloc]init];
    clearLabel.text = @"Clear Day";
    clearLabel.textColor = [UIColor blueTextColor];
    clearLabel.font = [UIFont smallTitleFont];
    clearLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:clearLabel];
    
    //tempLabel
    UILabel *tempLabel = [[UILabel alloc]init];
    tempLabel.text =@"15°/24°";
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.font = [UIFont smallTitleFont];
    tempLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tempLabel];
    
    //dateLabel
    UILabel *dateLabel = [[UILabel alloc]init];
    dateLabel.text = [NSString stringWithFormat:@"Mon, 4 Jan"];
    dateLabel.textColor = [UIColor whiteTextColor];
    dateLabel.font = [UIFont cellFont];
    dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:dateLabel];
    
    
    //table info
    UITableView *tabel = [[UITableView alloc] init];
    [self.view addSubview:tabel];
    tabel.backgroundColor = [UIColor clearColor];
    tabel.separatorColor = [UIColor colorWithRed:0.62 green:0.98 blue:0.99 alpha:1];
    tabel.translatesAutoresizingMaskIntoConstraints = NO;
    tabel.delegate = self;
    tabel.dataSource = self;
    
    //table Cells
    
    [NSLayoutConstraint activateConstraints:@[
    
    //titlelable constraints
    [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
    
    [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:30],
    
    //sunImage constraints
    [NSLayoutConstraint constraintWithItem:sunImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:weatherLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:-30],
    [NSLayoutConstraint constraintWithItem:sunImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
    [NSLayoutConstraint constraintWithItem:sunImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30],
    [NSLayoutConstraint constraintWithItem:sunImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],

    
    
    //weatherLabel constraints
    [NSLayoutConstraint constraintWithItem:weatherLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],
    
    [NSLayoutConstraint constraintWithItem:weatherLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
    
    //clearLabel
    [NSLayoutConstraint constraintWithItem:clearLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20],
    [NSLayoutConstraint constraintWithItem:clearLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:weatherLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10],
    
    //tempLabel
    [NSLayoutConstraint constraintWithItem:tempLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0],
    [NSLayoutConstraint constraintWithItem:tempLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:dateLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0],
    [NSLayoutConstraint constraintWithItem:tempLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:weatherLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10],
    
    //dateLabel
    [NSLayoutConstraint constraintWithItem:dateLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tempLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5],
    [NSLayoutConstraint constraintWithItem:dateLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20],
//    [NSLayoutConstraint constraintWithItem:dateLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:tempLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0],
    
    //tableConstraints
    [NSLayoutConstraint constraintWithItem:tabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
    [NSLayoutConstraint constraintWithItem:tabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:dateLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10],
    [NSLayoutConstraint constraintWithItem:tabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0],
    [NSLayoutConstraint constraintWithItem:tabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],
    
    ]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected cell at row %ld", (long)indexPath.row);
}

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
