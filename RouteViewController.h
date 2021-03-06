//
//  RouteViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GISViewController.h"

@interface RouteViewController : UIViewController<MKMapViewDelegate , CLLocationManagerDelegate>

- (void)switchToBackgroundMode:(BOOL)background;

- (void)reloadData;
@property (nonatomic,strong) MKMapView *map;
@property (readonly , strong ,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) CLLocation *location;

@property (nonatomic,strong) UIButton *staAndsto;

@property (nonatomic,strong) UISwitch *toggleBackgroundButton;




@end
