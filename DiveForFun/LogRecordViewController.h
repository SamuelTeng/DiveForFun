//
//  LogRecordViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/7/3.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DIVELOG.h"
#import "LogViewController.h"
#import "LogAnnotation.h"
#import "LogShoViewController.h"
#import "RouteViewController.h"

@interface LogRecordViewController : UIViewController<MKMapViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) MKMapView *logMap;
@property (nonatomic,strong)DIVELOG *diveLog;
@property (nonatomic,strong)LogViewController *logViewController;
//MainViewController *mainViewController;
@property (nonatomic,strong)LogShoViewController *logShowController;
@property (nonatomic,strong)RouteViewController *routeViewController;
@property (nonatomic,strong)NSFetchedResultsController *resultController;
@property (nonatomic,strong)NSArray *dateArr;
@property (nonatomic,strong)NSArray *latArr;
@property (nonatomic,strong)NSArray *lonArr;
@property (nonatomic,strong)NSArray *siteArr;
@property (nonatomic,strong)NSArray *timeArr;
@property (nonatomic,strong)NSArray *depthArr;
@property (nonatomic,strong)NSArray *airArr;
@property (nonatomic,strong)NSArray *staArr;
@property (nonatomic,strong)NSArray *endArr;
@property (nonatomic,strong)NSArray *visiArr;
@property (nonatomic,strong)NSArray *tempArr;
@property (nonatomic,strong)NSMutableArray *annotations;
@property (nonatomic,strong)LogAnnotation *logAnnotation;


@end
