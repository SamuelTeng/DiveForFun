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
//#import "MainViewController.h"
#import "RoutingViewController.h"
#import "LogRecordViewController.h"

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
    //MainViewController *mainViewController;
    RoutingViewController *routingViewController;
    LogRecordViewController *logRecordViewController;
    //UIButton *_start;
    //UIButton *_stop;
    
}



@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) UIBarButtonItem *startTracking;
@property (nonatomic,strong) UIBarButtonItem *stopTracking;
@property (nonatomic,strong) CrumbPath *path;
@property (nonatomic,strong) CrumbPathView *pathView;
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) NSMutableArray *latitudeArray;
@property (nonatomic,strong) NSMutableArray *lontitudeArray;
@property (nonatomic,strong) NSMutableArray *courseArray;
@property (nonatomic,strong) NSMutableArray *altitudeArray;
@property (nonatomic,strong) NSMutableArray *timestampArry;
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
@synthesize latitudeArray,lontitudeArray,courseArray,altitudeArray,timestampArry;
- (void)switchToBackgroundMode:(BOOL)background
{
    
    if (_toggleBackgroundButton.isOn) {
        _map.showsUserLocation = YES;
        [self becomeFirstResponder];
    }else{
        _map.showsUserLocation = NO;
        [self resignFirstResponder];
    }
    if (background) {
        if (! _toggleBackgroundButton.isOn){
            
            [_locationManager stopUpdatingLocation];
            _locationManager.delegate = nil;
            NSLog(@"didn't update at background");
        }
        
    }else{
        
        if (_toggleBackgroundButton.isOn) {
            _locationManager.delegate = self;
            [_locationManager startUpdatingLocation];
            NSLog(@"update at background");
        }
    }
}

-(void)reloadData
{
    
//    appDelegate.latGIS = latitudeArray;
//    appDelegate.lonGIS = lontitudeArray;
//    appDelegate.timeGIS = timestampArry;
//    appDelegate.courseGIS = courseArray;
//    appDelegate.altGIS = altitudeArray;
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

-(void)trackingStart
{
    [_locationManager startUpdatingLocation];
    
    [_map setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:NO];
    
    _toggleBackgroundButton.hidden = YES;
    
    UIBarButtonItem *hideTable = self.navigationItem.rightBarButtonItems [0];
    hideTable.enabled = NO;
    UIBarButtonItem *hideLog = [self.navigationItem.rightBarButtonItems lastObject];
    hideLog.enabled = NO;
    
    
    NSLog(@"begin with %@", [_map.userLocation.location timestamp]);
    
    [latitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.latitude]];
    
    [lontitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.longitude]];
    
    [courseArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.course]];
    
    [altitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.verticalAccuracy]];
    NSLog(@"timestamp:%@",_map.userLocation.location.timestamp);
    //NSTimeInterval eventInterval = [_map.userLocation.location.timestamp timeIntervalSinceNow];
   [timestampArry addObject:[NSMutableString stringWithFormat:@"%@", _map.userLocation.location.timestamp]];
    //[timestampArry addObject:[NSMutableString stringWithFormat:@"%f", eventInterval]];
    
    
    /*record every 30 seconds*/
    timer = [NSTimer timerWithTimeInterval:10.0 target:self selector:@selector(updating:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    if (nil == coordinateArray) {
        coordinateArray = [[NSMutableArray alloc] init];
    }

}

//-(void)trackIngstart:(id)sender
//{
//    [_locationManager startUpdatingLocation];
//    
//    [_map setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:NO];
//    
//    _toggleBackgroundButton.hidden = YES;
//    
//    
//    NSLog(@"begin with %@", [NSDate date]);
//    
//    [latitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.latitude]];
//    
//    [lontitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.longitude]];
//    
//    [courseArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.course]];
//    
//    [altitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.verticalAccuracy]];
//    NSLog(@"timestamp:%@",_map.userLocation.location.timestamp);
//    //NSTimeInterval eventInterval = [_map.userLocation.location.timestamp timeIntervalSinceNow];
//    [timestampArry addObject:[NSMutableString stringWithFormat:@"%@", _map.userLocation.location.timestamp]];
//
//    
//    /*record every 30 seconds*/
//    timer = [NSTimer timerWithTimeInterval:10.0 target:self selector:@selector(updating:) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    
//    if (nil == coordinateArray) {
//        coordinateArray = [[NSMutableArray alloc] init];
//    }
//    
//}

-(void)trackStop
{
    [_locationManager stopUpdatingLocation];
    [_map setUserTrackingMode:MKUserTrackingModeNone animated:NO];
    
    [latitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.latitude]];
    
    [lontitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.longitude]];
    
    [courseArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.course]];
    
    [altitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.verticalAccuracy]];
    
    //NSTimeInterval eventInterval = [_map.userLocation.location.timestamp timeIntervalSinceNow];
    [timestampArry addObject:[NSMutableString stringWithFormat:@"%@", _map.userLocation.location.timestamp]];
    //[timestampArry addObject:[NSMutableString stringWithFormat:@"%f", eventInterval]];
    
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

//-(void)trackingStop:(id)sender
//{
//    [_locationManager stopUpdatingLocation];
//    [_map setUserTrackingMode:MKUserTrackingModeNone animated:NO];
//    
//    [latitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.latitude]];
//    
//    [lontitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.coordinate.longitude]];
//    
//    [courseArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.course]];
//    
//    [altitudeArray addObject:[NSMutableString stringWithFormat:@"%f", _map.userLocation.location.verticalAccuracy]];
//    
//    //NSTimeInterval eventInterval = [_map.userLocation.location.timestamp timeIntervalSinceNow];
//    [timestampArry addObject:[NSMutableString stringWithFormat:@"%@", _map.userLocation.location.timestamp]];
//    
//    NSData *latitudeData = [NSKeyedArchiver archivedDataWithRootObject:latitudeArray];
//    
//    NSData *lontitudeData = [NSKeyedArchiver archivedDataWithRootObject:lontitudeArray];
//    
//    NSData *courseData = [NSKeyedArchiver archivedDataWithRootObject:courseArray];
//    
//    NSData *altitudeData = [NSKeyedArchiver archivedDataWithRootObject:altitudeArray];
//    
//    NSData *timestampData = [NSKeyedArchiver archivedDataWithRootObject:timestampArry];
//    //NSLog(@"end time:%@", [timestampArry lastObject]);
//    /*putting GIS info into database*/
//    GISDATA *database = (GISDATA *)[NSEntityDescription insertNewObjectForEntityForName:@"GISDATA" inManagedObjectContext:managedObjectContext];
//    
//
//    database.latitude = latitudeData;
//    database.lontitude = lontitudeData;
//    database.course = courseData;
//    database.altitude = altitudeData;
//    database.timestamp = timestampData;
//
//    [database setDate:[NSDate date]];
//    
//    NSError *error;
//    if (![managedObjectContext save:&error]) {
//        NSLog(@"error:%@", [error localizedFailureReason]);
//    }
//    
//    
//    NSLog(@"number of test array is %i", latitudeArray.count);
//    
//    
//    [self reloadData];
//
//    
//    /*stop the timer*/
//    [timer invalidate];
//    
//}

//-(void)back:(id)sender
//{
//    [appDelegate.navi pushViewController:mainViewController animated:YES];
//}

-(void)tableViewShow:(id)sender
{
    [appDelegate.navi pushViewController:tableViewController animated:YES];
}

-(void)log:(id)sender
{
    [appDelegate.navi pushViewController:logRecordViewController animated:YES];
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

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied) {
        //_start.enabled = NO;
        //_stop.enabled = NO;
        [self resignFirstResponder];
        
    }else if (status == kCLAuthorizationStatusNotDetermined){
    
        //_start.enabled = NO;
        //_stop.enabled = NO;
        [self resignFirstResponder];
        
    }else if (status == kCLAuthorizationStatusRestricted){
    
       // _start.enabled = NO;
       // _stop.enabled = NO;
        [self resignFirstResponder];
        
    }else if (status == kCLAuthorizationStatusAuthorized){
    
       // _start.enabled = YES;
        //_stop.enabled = YES;
        [self becomeFirstResponder];
    }
    
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
    

    //mainViewController = [[MainViewController alloc] init];
    tableViewController = [[GISViewController alloc] init];
    routingViewController = [[RoutingViewController alloc] init];
    logRecordViewController = [[LogRecordViewController alloc] init];
    
    _map = [[MKMapView alloc] initWithFrame:appDelegate.window.frame];
    _map.showsUserLocation = YES;
    _map.userTrackingMode = YES;
    _map.delegate = self;
    [self.view addSubview:_map];
    
//    UIButton *test = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [test setTitle:@"Start" forState:UIControlStateNormal];
//    test.frame = CGRectMake(270, 370, 50, 40);
//    [test addTarget:self action:@selector(trackIngstart:) forControlEvents:UIControlEventTouchUpInside];
//    _staAndsto = test;
//    _start = test;
//    [_map addSubview:_staAndsto];
//    
//    UIButton *stop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [stop setTitle:@"Stop" forState:UIControlStateNormal];
//    stop.frame = CGRectMake(130, 370, 50, 40);
//    [stop addTarget:self action:@selector(trackingStop:) forControlEvents:UIControlEventTouchUpInside];
//    _stop = stop;
//    [_map addSubview:stop];
    
    _toggleBackgroundButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, 10, 60, 27)];
    [_toggleBackgroundButton addTarget:self action:@selector(switchToBackgroundMode:) forControlEvents:UIControlEventValueChanged];
    [_toggleBackgroundButton setOn:YES];
    [_map addSubview:_toggleBackgroundButton];



//    UIBarButtonItem *toMain = [[UIBarButtonItem alloc] initWithTitle:@"Main" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
//    self.navigationItem.leftBarButtonItem = toMain;
    
    UIBarButtonItem *toTable = [[UIBarButtonItem alloc] initWithTitle:@"Table" style:UIBarButtonItemStyleBordered target:self action:@selector(tableViewShow:)];
    
    UIBarButtonItem *toLog = [[UIBarButtonItem alloc] initWithTitle:@"Log" style:UIBarButtonItemStyleBordered target:self action:@selector(log:)];
    NSArray *rightBarArr = [NSArray arrayWithObjects:toTable,toLog, nil];
    self.navigationItem.rightBarButtonItems = rightBarArr;

    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    /*disable the tracking if user denies the access of location service*/
    if ([CLLocationManager locationServicesEnabled]) {
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusNotDetermined:
                
               // _stop.enabled = NO;
               // _start.enabled = NO;
                [self resignFirstResponder];
                
                break;
                
            case kCLAuthorizationStatusDenied:
                
              //  _stop.enabled = NO;
               // _start.enabled = NO;
                [self resignFirstResponder];
                
                break;
                
            case kCLAuthorizationStatusAuthorized:
                
               // _stop.enabled = YES;
               // _start.enabled = YES;
                
                [self becomeFirstResponder];
                
                break;
                
            case kCLAuthorizationStatusRestricted:
                
               // _stop.enabled = NO;
                //_start.enabled = NO;
                [self resignFirstResponder];
                
                break;
                
            default:
                break;
        }
    }
    
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

-(void)viewDidUnload
{
    tableViewController = nil;
    routingViewController = nil;
    logRecordViewController = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self zoomToCurrentLocation];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.locationManager.delegate = nil;
    tableViewController = nil;
    routingViewController = nil;
    logRecordViewController = nil;
    // Dispose of any resources that can be recreated.
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        if (_toggleBackgroundButton.hidden == NO) {
            NSLog(@"shake");
            [self performSelector:@selector(trackingStart)];
        }else if (_toggleBackgroundButton.hidden == YES){
        
            NSLog(@"shake while tracking");
            [self performSelector:@selector(trackStop)];
        }
    }
}

-(void)zoomToCurrentLocation
{
    CLLocation *currentLocation = _map.userLocation.location;
    MKCoordinateRegion visibleRegion = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 400, 400);
    MKCoordinateRegion adjustedRegion = [_map regionThatFits:visibleRegion];
    [_map setRegion:adjustedRegion animated:YES];
}

@end
