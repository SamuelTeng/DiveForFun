//
//  AppDelegate.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) UINavigationController *navi;
@property (nonatomic,strong) MainViewController *mainViewController;

@property (readonly , strong , nonatomic) NSManagedObjectModel *managedModel;
@property (readonly , strong , nonatomic) NSPersistentStoreCoordinator *persistentstoreCoordinator;
@property (readonly , strong ,nonatomic) NSManagedObjectContext *context;

@property (nonatomic,strong) NSArray *latGIS;
@property (nonatomic,strong) NSArray *lonGIS;
@property (nonatomic,strong) NSArray *courseGIS;
@property (nonatomic,strong) NSArray *altGIS;
@property (nonatomic,strong) NSArray *timeGIS;
@property (nonatomic,strong) NSArray *logLat;
@property (nonatomic,strong) NSArray *logLon;
@property (nonatomic,strong) NSArray *logDate;
@property (nonatomic,strong) NSArray *logSite;


@end
