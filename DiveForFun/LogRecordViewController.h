//
//  LogRecordViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/7/3.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LogRecordViewController : UIViewController<MKMapViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) MKMapView *logMap;


@end
