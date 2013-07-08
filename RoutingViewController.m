//
//  RoutingViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "RoutingViewController.h"
#import "GISViewController.h"
#import "GISDATA.h"
#import "AppDelegate.h"
#import "StartAnnotation.h"
#import "StopAnnotation.h"

@interface RoutingViewController (){
    
    AppDelegate *delegate;
    GISViewController *table;
    GISDATA *gisData;
    NSFetchedResultsController *resultController;
    NSArray *latArray;
    NSArray *lonArray;
    NSArray *pointsArray;
    MKMapRect _routeRect;
    NSMutableArray *annotations;
    NSArray *_annotations;

}

@end

@implementation RoutingViewController

@synthesize routeMap = _routeMap;
@synthesize routeLine = _routeLine;
@synthesize routeLineView = _routeLineView;
@synthesize annotationsRemove;

-(void)fetchData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"GISDATA" inManagedObjectContext:delegate.context]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:descriptors];
    
    NSError *error;
    resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:delegate.context sectionNameKeyPath:@"date" cacheName:nil];
    
    if (![resultController performFetch:&error]) {
        NSLog(@"error : %@", [error localizedFailureReason]);
    }
}

-(void)loadRoute
{
    if (!resultController.fetchedObjects.count) {
        NSLog(@"there's no any GIS data in this moment");
    }
    
    //for (GISDATA *coordinate in resultController.fetchedObjects) {
        //latArray = delegate.latGIS;
        //[NSKeyedUnarchiver unarchiveObjectWithData:coordinate.latitude];
        //lonArray = delegate.lonGIS;
        //[NSKeyedUnarchiver unarchiveObjectWithData:coordinate.lontitude];
    
    latArray = delegate.latGIS;
    lonArray = delegate.lonGIS;
    
        MKMapPoint northPoint;
        MKMapPoint southPoint;
        
        //CLLocationCoordinate2D _rectCoordinate;
    
    /*initialized _coordinate for avoiding passing compiler called 'an unlogic argumet value'*/
    
        CLLocationCoordinate2D _coordinate = CLLocationCoordinate2DMake(0, 0);
    
    if (latArray.count == 0) {
        return;
    }
        //MKMapPoint *pointArr = malloc(sizeof(CLLocationCoordinate2D) * latArray.count);
    
    /*change to this line 'cause mkmappoint isn't the same as cllocationCoordinate2D, even though they both have same bytes*/
        MKMapPoint *pointArr = malloc(sizeof(MKMapPoint) * latArray.count);
        
        for (int i = 0 ; i<latArray.count; i++) {
            NSString *latString = [latArray objectAtIndex:i];
            NSString *lonString = [lonArray objectAtIndex:i];
            NSArray *latlonArr = [NSArray arrayWithObjects:latString,lonString, nil];
            
            //NSLog(@"latlonArr[%i] = %@", i, latlonArr[i]);
            
            CLLocationDegrees latitude = [[latlonArr objectAtIndex:0]doubleValue];
            CLLocationDegrees lontitude = [[latlonArr objectAtIndex:1]doubleValue];
            
            //CLLocationCoordinate2D
            _coordinate = CLLocationCoordinate2DMake(latitude, lontitude);
            MKMapPoint point = MKMapPointForCoordinate(_coordinate);
            
            if (i == 0) {
                northPoint = point;
                southPoint = point;
            }else{
                if (point.x > northPoint.x) {
                    northPoint.x = point.x;
                }
                if (point.y > northPoint.y) {
                    northPoint.y = point.y;
                }
                if (point.x < southPoint.x) {
                    southPoint.x = point.x;
                }
                if (point.y < southPoint.y) {
                    southPoint.y = point.y;
                }
            }
            
            pointArr[i] = point;
            //_rectCoordinate = _coordinate;
        }
        
        _routeLine = [MKPolyline polylineWithPoints:pointArr count:latArray.count];
    
    /*free the used array to avoid memeory leak*/
        free(pointArr);
    
        //_routeRect = MKMapRectMake(southPoint.x, southPoint.y, northPoint.x, northPoint.y);
        
        /*zoom in to desired loading area*/
        //MKCoordinateRegion drawRegion = MKCoordinateRegionMakeWithDistance(_rectCoordinate, 400, 400);
        
        MKCoordinateRegion drawRegion = MKCoordinateRegionMakeWithDistance(_coordinate, 400, 400);
        [_routeMap setRegion:drawRegion];
        
    //}
    
    [_routeMap addOverlay:_routeLine];
}

-(void)addAnnotation
{
    annotations = [[NSMutableArray alloc] initWithCapacity:2];
    
    StartAnnotation *startAnnotation = [[StartAnnotation alloc] init];
    [annotations insertObject:startAnnotation atIndex:0];
    
    StopAnnotation *stopAnnotation = [[StopAnnotation alloc] init];
    [annotations insertObject:stopAnnotation atIndex:1];
    
    _annotations = [NSArray arrayWithObjects:[annotations objectAtIndex:0],[annotations objectAtIndex:1], nil];
    [_routeMap addAnnotations:_annotations];
    annotationsRemove = _annotations;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id < MKOverlay >)overlay
{
    MKOverlayPathView *overlayView = nil;
    
    if (overlay == _routeLine) {
        if (nil == _routeLineView) {
            _routeLineView = [[MKPolylineView alloc] initWithPolyline:_routeLine];
            _routeLineView.fillColor = [UIColor redColor];
            _routeLineView.strokeColor = [UIColor redColor];
            _routeLineView.lineWidth = 3;
        }
        
        overlayView = _routeLineView;
    }
    
    return overlayView;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)aAnnotation
{
    if ([aAnnotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if ([aAnnotation isKindOfClass:[StartAnnotation class]]) {
        static NSString *startIdentifier = @"startIdentifier";
        MKPinAnnotationView *startPin = (MKPinAnnotationView *)[_routeMap dequeueReusableAnnotationViewWithIdentifier:startIdentifier];
        if (startPin == nil) {
            MKPinAnnotationView *customView = [[MKPinAnnotationView alloc] initWithAnnotation:aAnnotation reuseIdentifier:startIdentifier];
            customView.pinColor = MKPinAnnotationColorGreen;
            customView.animatesDrop = NO;
            customView.canShowCallout = YES;
            return customView;
        }else{
            startPin.annotation = aAnnotation;
            
        }
        
        return startPin;
        
    }else if ([aAnnotation isKindOfClass:[StopAnnotation class]]){
        
        static NSString *stopIdentifier = @"stopIdentifier";
        MKPinAnnotationView *stopPin = (MKPinAnnotationView *)[_routeMap dequeueReusableAnnotationViewWithIdentifier:stopIdentifier];
        if (stopPin == nil) {
            MKPinAnnotationView *customView = [[MKPinAnnotationView alloc] initWithAnnotation:aAnnotation reuseIdentifier:stopIdentifier];
            customView.pinColor = MKPinAnnotationColorRed;
            customView.animatesDrop = NO;
            customView.canShowCallout = YES;
            return customView;
        }else{
            stopPin.annotation = aAnnotation;
            
        }
        
        return stopPin;
    }
    
    return nil;
}

-(void)tableViewShow:(id)sender
{
    [_routeMap removeAnnotations:_annotations];

    [delegate.navi pushViewController:table animated:NO];
    
}

-(void)loadView
{
    [super loadView];
    

    table = [[GISViewController alloc] init];
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    _routeMap = [[MKMapView alloc] initWithFrame:delegate.window.frame];
    _routeMap.delegate = self;
    [self.view addSubview:_routeMap];
    
    NSString *couStralt = [NSString stringWithFormat:@"course:%@, altitude:%@", [delegate.courseGIS objectAtIndex:0],[delegate.altGIS objectAtIndex:0]];

    
    UITextView *show = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    show.backgroundColor = [UIColor clearColor];
    [show setText:couStralt];
    show.textColor = [UIColor redColor];
    [show setFont:[UIFont systemFontOfSize:10]];
    show.textAlignment = NSTextAlignmentCenter;
    [_routeMap addSubview:show];
    
    UIBarButtonItem *toTable = [[UIBarButtonItem alloc] initWithTitle:@"Table" style:UIBarButtonItemStyleBordered target:self action:@selector(tableViewShow:)];
    self.navigationItem.leftBarButtonItem = toTable;
    
 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchData];
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self loadRoute];
    [self addAnnotation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
