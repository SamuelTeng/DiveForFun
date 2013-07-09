//
//  RoutingViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>


@interface RoutingViewController : UIViewController<MKMapViewDelegate>

@property (nonatomic,strong) MKMapView *routeMap;
@property (nonatomic,strong) MKPolylineView *routeLineView;
@property (nonatomic,strong) MKPolyline *routeLine;
@property (nonatomic,strong) NSArray *annotationsRemove;
@property (nonatomic,strong) NSFetchedResultsController *resultController;
@property (nonatomic,strong) NSArray *latArray;
@property (nonatomic,strong) NSArray *lonArray;
@property (nonatomic,strong) NSArray *pointsArray;

@property (nonatomic,strong) NSMutableArray *annotations;
@property (nonatomic,strong) NSArray *_annotations;

@end
