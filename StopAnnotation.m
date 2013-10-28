//
//  StopAnnotation.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "StopAnnotation.h"
#import "AppDelegate.h"

@implementation StopAnnotation

//-(CLLocationCoordinate2D)coordinate
//{
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    NSString *stoptLat = [delegate.latGIS lastObject];
//    NSString *stoptLon = [delegate.lonGIS lastObject];
//    NSArray *stoLatLon = [NSArray arrayWithObjects:stoptLat,stoptLon, nil];
//    CLLocationDegrees latStart = [[stoLatLon objectAtIndex:0] doubleValue];
//    CLLocationDegrees lonStart = [[stoLatLon objectAtIndex:1] doubleValue];
//    CLLocationCoordinate2D stopCoordinate = CLLocationCoordinate2DMake(latStart, lonStart);
//    
//    return stopCoordinate;
//}
//
//// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
//- (NSString *)title
//{
//    return @"Stop Here";
//}
//
//-(NSString *)subtitle
//{
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
////    NSString *begin = delegate.timeGIS[0];
//    NSDateFormatter *_begin = [[NSDateFormatter alloc] init];
//    /*the original data from array is 2013-07-09 14:58:18 +0000. hence, the formatter must transfer all number into date otherwise it will return null*/
//    [_begin setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
//    NSDate *diveBegin = [_begin dateFromString:begin];
//    
////    NSString *finish = [delegate.timeGIS lastObject];
//    NSDateFormatter *_finish = [[NSDateFormatter alloc] init];
//    [_finish setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
//    NSDate *diveFinish = [_finish dateFromString:finish];
//    
//    /*timeInterValSince... is the time difference between desired date and reference date. The reference date could be 1970, now, desired date or other reference date*/
//    NSTimeInterval diveTime = [diveFinish timeIntervalSinceDate:diveBegin];
//    double minutes = diveTime/60;
//    int _minutes = floor(minutes);
//
//    NSString *otherInfo = [NSString stringWithFormat:@"dive time: %i minutes", _minutes];
//    //NSString *otherInfo = [NSString stringWithFormat:@"time:%@", diveFinish];
//    return otherInfo;
//}


@end
