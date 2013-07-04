//
//  RouteViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "RouteViewController.h"
#import "CrumbPath.h"
#import "CrumbPathView.h"
#import "AppDelegate.h"
#import "GISDATA.h"
#import "GISViewController.h"
#import "MainViewController.h"
#import "RoutingViewController.h"

@interface RouteViewController (){
    AppDelegate *appDelegate ;
    NSMutableArray *coordinateArray;
    GISViewController *tableViewController;
    NSTimer *timer;
    NSMutableArray *latitudeArray;
    NSMutableArray *lontitudeArray;
    NSMutableArray *courseArray;
    NSMutableArray *altitudeArray;
    NSMutableArray *timestampArry;
    MainViewController *mainViewController;
    RoutingViewController *routingViewController;
}



@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) UIBarButtonItem *startTracking;
@property (nonatomic,strong) UIBarButtonItem *stopTracking;
@property (nonatomic,strong) CrumbPath *path;
@property (nonatomic,strong) CrumbPathView *pathView;
@property (nonatomic,strong) UIView *containerView;
@end

@implementation RouteViewController

@synthesize map = _map;
@synthesize locationManager = _locationManager;
@synthesize startTracking = _startTracking;
@synthesize stopTracking = _stopTracking;
@synthesize path,pathView,containerView,managedObjectContext;
@synthesize location = _location;
@synthesize staAndsto = _staAndsto;
@synthesize toggleBackgroundButton = _toggleBackgroundButton;

- (void)switchToBackgroundMode:(BOOL)background
{
    
    if (background) {
        if (! _toggleBackgroundButton.isOn){
            
            [_locationManager stopUpdatingLocation];
            _locationManager.delegate = nil;
        }
        
    }else{
        
        if (!_toggleBackgroundButton.isOn) {
            _locationManager.delegate = self;
            [_locationManager startUpdatingLocation];
        }
    }
}

-(void)reloadData
{
    
    appDelegate.latGIS = latitudeArray;
    appDelegate.lonGIS = lontitudeArray;
    appDelegate.timeGIS = timestampArry;
    appDelegate.courseGIS = courseArray;
    appDelegate.altGIS = altitudeArray;
    [appDelegate.navi pushViewController:routingViewController animated:YES];
    
    //[appDelegate.navi pushViewController:dataViewController animated:NO];
    
}

-(void)updating:(id)sender
{
    NSLog(@"latitude = %f", self.location.coordinate.latitude);
    //    NSLog(@"longitude = %f", self.location.coordinate.longitude);
    //    NSLog(@"time = %@", [NSDate date]);
    //    NSLog(@"speed = %f", self.location.speed);
    //    NSLog(@"course = %f", self.location.course);
    //    NSLog(@"altitude = %f", self.location.verticalAccuracy);
    
    /*tranform array to data, since they both conform nscoding protocal, then build binary data type core data attribute so that we can save array into core data
     (https://coderwall.com/p/mx_wmq)*/
    
    [latitudeArray addObject:[NSMutableString stringWithFormat:@"%f", self.location.coordinate.latitude]];
    
    [lontitudeArray addObject:[NSMutableString stringWithFormat:@"%f", self.location.coordinate.longitude]];
    
    [courseArray addObject:[NSMutableString stringWithFormat:@"%f", self.location.course]];
    
    [altitudeArray addObject:[NSMutableString stringWithFormat:@"%f", self.location.verticalAccuracy]];
    
    NSTimeInterval eventInterval = [self.location.timestamp timeIntervalSinceNow];
    [timestampArry addObject:[NSMutableString stringWithFormat:@"%f", eventInterval]];
    
    
}

-(void)trackIngstart:(id)sender
{
    [_locationManager startUpdatingLocation];
    [_map setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:NO];
    
    _toggleBackgroundButton.hidden = YES;
    
    NSLog(@"begin with %@", [NSDate date]);
    
    [latitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.latitude]];
    
    [lontitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.longitude]];
    
    [courseArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.course]];
    
    [altitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.verticalAccuracy]];
    NSLog(@"timestamp:%@",_map.userLocation.location.timestamp);
    //NSTimeInterval eventInterval = [_map.userLocation.location.timestamp timeIntervalSinceNow];
    [timestampArry addObject:[NSMutableString stringWithFormat:@"%@", _map.userLocation.location.timestamp]];

    
    /*record every 30 seconds*/
    timer = [NSTimer timerWithTimeInterval:10.0 target:self selector:@selector(updating:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    if (nil == coordinateArray) {
        coordinateArray = [[NSMutableArray alloc] init];
    }
    
}

-(void)trackingStop:(id)sender
{
    [_locationManager stopUpdatingLocation];
    [_map setUserTrackingMode:MKUserTrackingModeNone animated:NO];
    
    [latitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.latitude]];
    
    [lontitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.longitude]];
    
    [courseArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.course]];
    
    [altitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.verticalAccuracy]];
    
    //NSTimeInterval eventInterval = [_map.userLocation.location.timestamp timeIntervalSinceNow];
    [timestampArry addObject:[NSMutableString stringWithFormat:@"%@", _map.userLocation.location.timestamp]];
    
    NSData *latitudeData = [NSKeyedArchiver archivedDataWithRootObject:latitudeArray];
    
    NSData *lontitudeData = [NSKeyedArchiver archivedDataWithRootObject:lontitudeArray];
    
    NSData *courseData = [NSKeyedArchiver archivedDataWithRootObject:courseArray];
    
    NSData *altitudeData = [NSKeyedArchiver archivedDataWithRootObject:altitudeArray];
    
    NSData *timestampData = [NSKeyedArchiver archivedDataWithRootObject:timestampArry];
    //NSLog(@"end time:%@", [timestampArry lastObject]);
    /*putting GIS info into database*/
    GISDATA *database = (GISDATA *)[NSEntityDescription insertNewObjectForEntityForName:@"GISDATA" inManagedObjectContext:managedObjectContext];
    

    database.latitude = latitudeData;
    database.lontitude = lontitudeData;
    database.course = courseData;
    database.altitude = altitudeData;
    database.timestamp = timestampData;

    [database setDate:[NSDate date]];
    
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"error:%@", [error localizedFailureReason]);
    }
    
    
    NSLog(@"number of test array is %i", latitudeArray.count);
    
    
    [self reloadData];

    
    /*stop the timer*/
    [timer invalidate];
    
}

-(void)back:(id)sender
{
    [appDelegate.navi pushViewController:mainViewController animated:YES];
}

-(void)tableViewShow:(id)sender
{
    [appDelegate.navi pushViewController:tableViewController animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    self.location = [locations lastObject];
    NSTimeInterval eventInterval = [newLocation.timestamp timeIntervalSinceNow];
    

    
    if (newLocation) {
        if (abs(eventInterval) < 10.0) {
            if (! self.path) {
                self.path = [[CrumbPath alloc] initWithCenterCoordinate:newLocation.coordinate];
                [_map addOverlay:self.path];
                
                MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 400, 400);
                MKCoordinateRegion adjustedRegion = [_map regionThatFits:region];
                [_map setRegion:adjustedRegion animated:YES];

                
                
            }else{
                
                MKMapRect updateRect = [self.path addCoordinate:newLocation.coordinate];
                
                if (!MKMapRectIsNull(updateRect)) {
                    MKZoomScale currentZoomScale = (CGFloat)(_map.bounds.size.width/_map.visibleMapRect.size.width);
                    CGFloat lineWidth = MKRoadWidthAtZoomScale(currentZoomScale);
                    updateRect = MKMapRectInset(updateRect, -lineWidth, -lineWidth);
                    
                    [self.pathView setNeedsDisplayInMapRect:updateRect];
                }
            }
        }
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error = %@", [error localizedFailureReason]);
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id < MKOverlay >)overlay
{
    if (!self.pathView) {
        self.pathView = [[CrumbPathView alloc] initWithOverlay:overlay];
        
    }
    return self.pathView;
}

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor grayColor];
    appDelegate = [[UIApplication sharedApplication] delegate];

    /*hide default back button*/
    self.navigationItem.hidesBackButton = YES;
    

    mainViewController = [[MainViewController alloc] init];
    tableViewController = [[GISViewController alloc] init];
    routingViewController = [[RoutingViewController alloc] init];
    
    _map = [[MKMapView alloc] initWithFrame:appDelegate.window.frame];
    _map.showsUserLocation = YES;
    _map.delegate = self;
    [self.view addSubview:_map];
    
    UIButton *test = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [test setTitle:@"Start" forState:UIControlStateNormal];
    test.frame = CGRectMake(270, 370, 50, 40);
    [test addTarget:self action:@selector(trackIngstart:) forControlEvents:UIControlEventTouchUpInside];
    _staAndsto = test;
    [_map addSubview:_staAndsto];
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stop setTitle:@"Stop" forState:UIControlStateNormal];
    stop.frame = CGRectMake(130, 370, 50, 40);
    [stop addTarget:self action:@selector(trackingStop:) forControlEvents:UIControlEventTouchUpInside];
    [_map addSubview:stop];
    
    _toggleBackgroundButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, 10, 60, 27)];
    [_toggleBackgroundButton addTarget:self action:@selector(switchToBackgroundMode:) forControlEvents:UIControlEventValueChanged];
    [_toggleBackgroundButton setOn:YES];
    [_map addSubview:_toggleBackgroundButton];
    
    

    UIBarButtonItem *toMain = [[UIBarButtonItem alloc] initWithTitle:@"Main" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = toMain;
    
    UIBarButtonItem *toTable = [[UIBarButtonItem alloc] initWithTitle:@"Table" style:UIBarButtonItemStyleBordered target:self action:@selector(tableViewShow:)];
    self.navigationItem.rightBarButtonItem = toTable;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    managedObjectContext = appDelegate.context;
    //[_locationManager startUpdatingLocation];
    
    latitudeArray = [[NSMutableArray alloc] init];
    lontitudeArray = [[NSMutableArray alloc] init];
    courseArray = [[NSMutableArray alloc] init];
    timestampArry = [[NSMutableArray alloc] init];
    altitudeArray = [[NSMutableArray alloc] init];
}

- (void)dealloc
{
    self.locationManager.delegate = nil;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end