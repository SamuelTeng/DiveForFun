//
//  LogAnnotation.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/7/3.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "LogAnnotation.h"
#import "AppDelegate.h"

@implementation LogAnnotation
@synthesize _coordinate,_title,_subtitle;

-(CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

-(NSString *)title
{
    return _title;
}

-(NSString *)subtitle
{
    return _subtitle;
}
@end
