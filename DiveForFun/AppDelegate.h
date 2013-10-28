//
//  AppDelegate.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MainViewController.h"
//#import "RouteViewController.h"
#import "GISViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) UINavigationController *navi;
//@property (nonatomic,strong) MainViewController *mainViewController;
//@property (nonatomic,strong) RouteViewController *routeViewController;
@property (nonatomic,strong) GISViewController *gisViewController;


@property (readonly , strong , nonatomic) NSManagedObjectModel *managedModel;
@property (readonly , strong , nonatomic) NSPersistentStoreCoordinator *persistentstoreCoordinator;
@property (readonly , strong ,nonatomic) NSManagedObjectContext *context;

//@property (nonatomic,strong) NSArray *latGIS;
//@property (nonatomic,strong) NSArray *lonGIS;
//@property (nonatomic,strong) NSArray *courseGIS;
//@property (nonatomic,strong) NSArray *altGIS;
//@property (nonatomic,strong) NSArray *timeGIS;
//@property (nonatomic,strong) NSArray *logLat;
//@property (nonatomic,strong) NSArray *logLon;
//@property (nonatomic,strong) NSArray *logDate;
//@property (nonatomic,strong) NSArray *logSite;


@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *site;
@property (nonatomic,strong) NSString *timeOfDiving;
@property (nonatomic,strong) NSString *airType;
@property (nonatomic,strong) NSString *pressureOfStart;
@property (nonatomic,strong) NSString *pressureOfEnd;
@property (nonatomic,strong) NSString *maxiumDepth;
@property (nonatomic,strong) NSString *visibility;
@property (nonatomic,strong) NSString *temperature;
@property (nonatomic,strong) NSData *imageData;
@property (nonatomic,strong) NSData *signature;

@property (nonatomic,strong) UIImage *selectedCellImage;
@property (nonatomic,strong) UIImage *signatureImage;

@end
