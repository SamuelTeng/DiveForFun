//
//  StartAnnotation.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "StartAnnotation.h"
#import "AppDelegate.h"

@implementation StartAnnotation

//-(CLLocationCoordinate2D)coordinate
//{
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    NSString *startLat = [delegate.latGIS objectAtIndex:0];
//    NSString *startLon = [delegate.lonGIS objectAtIndex:0];
//    NSArray *staLatLon = [NSArray arrayWithObjects:startLat,startLon, nil];
//    CLLocationDegrees latStart = [[staLatLon objectAtIndex:0] doubleValue];
//    CLLocationDegrees lonStart = [[staLatLon objectAtIndex:1] doubleValue];
//    CLLocationCoordinate2D startCoordinate = CLLocationCoordinate2DMake(latStart, lonStart);
//    
//    return startCoordinate;
//}
//
//// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
//- (NSString *)title
//{
//    return @"Start Here";
//}
//
//-(NSString *)subtitle
//{
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    NSString *coordinate = [NSString stringWithFormat:@"Latitude: %@ \n Lontitude: %@",delegate.latGIS[0],delegate.lonGIS[0]];
//    return coordinate;
//}

@end
