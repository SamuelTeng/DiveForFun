//
//  LogRecordViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/7/3.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "LogRecordViewController.h"
#import "AppDelegate.h"
#import "DIVELOG.h"
#import "LogViewController.h"
#import "LogAnnotation.h"
//#import "MainViewController.h"
#import "LogShoViewController.h"
#import "RouteViewController.h"

@interface LogRecordViewController (){
    
    AppDelegate *delegate;
//    DIVELOG *diveLog;
//    LogViewController *logViewController;
//    //MainViewController *mainViewController;
//    LogShoViewController *logShowController;
//    RouteViewController *routeViewController;
//    NSFetchedResultsController *resultController;
//    NSArray *dateArr;
//    NSArray *latArr;
//    NSArray *lonArr;
//    NSArray *siteArr;
//    NSArray *timeArr;
//    NSArray *depthArr;
//    NSArray *airArr;
//    NSArray *staArr;
//    NSArray *endArr;
//    NSArray *visiArr;
//    NSArray *tempArr;
//    NSMutableArray *annotations;
//    LogAnnotation *logAnnotation;
}

@end

@implementation LogRecordViewController

@synthesize logMap,diveLog,logViewController,routeViewController,resultController,dateArr,latArr,lonArr,timeArr,siteArr,depthArr,airArr,staArr,endArr,visiArr,tempArr,annotations,logAnnotation;

-(void)fetchData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"DIVELOG" inManagedObjectContext:delegate.context]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:descriptors];
    
    NSError *error;
    resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:delegate.context sectionNameKeyPath:@"date" cacheName:nil];
    
    if (![resultController performFetch:&error]) {
        NSLog(@"error : %@", [error localizedFailureReason]);
    }
}

-(void)lodeLog
{
    
        if (! resultController.fetchedObjects.count) {
            NSLog(@"There is no Log at this moment");
        }
        
        for (DIVELOG *diveLog in resultController.fetchedObjects) {
            dateArr = [resultController.fetchedObjects valueForKey:@"date"];
            siteArr = [resultController.fetchedObjects valueForKey:@"site"];
            latArr = [resultController.fetchedObjects valueForKey:@"latitude"];
            lonArr = [resultController.fetchedObjects valueForKey:@"lontitude"];
            timeArr = [resultController.fetchedObjects valueForKey:@"dive_time"];
            depthArr = [resultController.fetchedObjects valueForKey:@"max_depth"];
            airArr = [resultController.fetchedObjects valueForKey:@"gas_type"];
            staArr = [resultController.fetchedObjects valueForKey:@"start_pressure"];
            endArr = [resultController.fetchedObjects valueForKey:@"end_pressure"];
            visiArr = [resultController.fetchedObjects valueForKey:@"visibility"];
            tempArr = [resultController.fetchedObjects valueForKey:@"temperature"];
        }
        
        delegate.logDate = dateArr;
        delegate.logSite = siteArr;
        delegate.logLat = latArr;
        delegate.logLon = lonArr;

    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    /*passing data to deisred detail description viewcontroller*/
    _logShowController = [[LogShoViewController alloc] init];
    
    _logShowController.annotation_ = view.annotation;
    
    
    /*following is the way to keep navi bar when adopting UIModalTransitionStyle into desired animation-in viewController*/
    UINavigationController *navLogViewController = [[UINavigationController alloc] initWithRootViewController:_logShowController];
    
    navLogViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navLogViewController animated:YES completion:^{
        NULL;
    }];

}

-(void)addAnnotations
{
    
        CLLocationCoordinate2D logCoordinate;
        for (int i = 0; i < dateArr.count; i++) {
            logAnnotation = [[LogAnnotation alloc] init];
            CLLocationDegrees latitude = [[latArr objectAtIndex:i] doubleValue];
            CLLocationDegrees lontitude = [[lonArr objectAtIndex:i] doubleValue];
            logCoordinate.latitude = latitude;
            logCoordinate.longitude = lontitude;
            
            logAnnotation._coordinate = logCoordinate;
            logAnnotation._title = [NSString stringWithFormat:@"%@",[dateArr objectAtIndex:i]];
            logAnnotation._subtitle = [NSString stringWithFormat:@"%@",[siteArr objectAtIndex:i]];
            logAnnotation.timeOfDiving = [NSString stringWithFormat:@"%@", [timeArr objectAtIndex:i]];
            logAnnotation.airType = [NSString stringWithFormat:@"%@",[airArr objectAtIndex:i]];
            logAnnotation.pressureOfStart = [NSString stringWithFormat:@"%@",[staArr objectAtIndex:i]];
            logAnnotation.pressureOfEnd = [NSString stringWithFormat:@"%@",[endArr objectAtIndex:i]];
            logAnnotation.maxiumDepth = [NSString stringWithFormat:@"%@",[depthArr objectAtIndex:i]];
            logAnnotation.temperature = [NSString stringWithFormat:@"%@",[tempArr objectAtIndex:i]];
            logAnnotation.visibility = [NSString stringWithFormat:@"%@",[visiArr objectAtIndex:i]];
            
                [logMap addAnnotation:logAnnotation];
                [annotations addObject:logAnnotation];
           
            

        }
        
        /*make all annotations visible when view load*/
        MKMapRect focus = MKMapRectNull;
        for (logAnnotation in annotations) {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(logAnnotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
            
            if (MKMapRectIsNull(focus)) {
                focus = pointRect;
            }else{
                focus = MKMapRectUnion(focus, pointRect);
            }
            
        }
        
            logMap.visibleMapRect = focus;
        
        

    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)aAnnotation
{
    if ([aAnnotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if ([aAnnotation isKindOfClass:[LogAnnotation class]]) {
        static NSString *logIdentifier = @"logIdentifier";
        MKPinAnnotationView *logPin = (MKPinAnnotationView *)[logMap dequeueReusableAnnotationViewWithIdentifier:logIdentifier];
        if (logPin == nil) {
            MKPinAnnotationView *customView = [[MKPinAnnotationView alloc] initWithAnnotation:aAnnotation reuseIdentifier:logIdentifier];
            customView.pinColor = MKPinAnnotationColorPurple;
            customView.animatesDrop = NO;
            customView.canShowCallout = YES;
            
            /*show right disclosure and push to logShow view*/
            // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
            //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
            //

            UIButton *showLog = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

            customView.rightCalloutAccessoryView = showLog;
            return customView;
        }else{
            logPin.annotation = aAnnotation;
        }
        
        return logPin;
    }
    
    return nil;
}

-(void)toLogView:(id)sender
{
    [logMap removeAnnotations:annotations];
    [delegate.navi pushViewController:logViewController animated:NO];
    
}

-(void)toMainView:(id)sender
{
    [logMap removeAnnotations:annotations];
    [delegate.navi pushViewController:routeViewController animated:NO];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [delegate.navi pushViewController:routeViewController animated:NO];
            break;
            
        case 1:
            [delegate.navi pushViewController:logViewController animated:NO];
            break;
            
        default:
            break;
    }
}

-(void)loadView
{
    
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    logMap = [[MKMapView alloc] initWithFrame:delegate.window.frame];
    logMap.delegate = self;
    
    [self.view addSubview:logMap];
    
    
    //mainViewController = [[MainViewController alloc] init];
    
    logViewController = [[LogViewController alloc] init];
    routeViewController = [[RouteViewController alloc] init];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(toMainView:)];
    self.navigationItem.leftBarButtonItem = back;
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toLogView:)];
    self.navigationItem.rightBarButtonItem = add;
    
    self.navigationItem.hidesBackButton = YES;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self fetchData];
    if (! resultController.fetchedObjects.count) {
        
        UIAlertView *noLogData = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"There are no logs. Press OK to add one or Cancel to leave." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [noLogData show];
        
        NSLog(@"No data at this moment");
        
    }else{
       
            [self lodeLog];
            [self addAnnotations];
      

    }
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end
