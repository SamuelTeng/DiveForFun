//
//  LogAnnotation.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/7/3.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LogAnnotation : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D _coordinate;
@property (nonatomic,strong) NSString *_title;
@property (nonatomic,strong) NSString *_subtitle;
@property (nonatomic,strong) NSString *timeOfDiving;
@property (nonatomic,strong) NSString *airType;
@property (nonatomic,strong) NSString *pressureOfStart;
@property (nonatomic,strong) NSString *pressureOfEnd;
@property (nonatomic,strong) NSString *maxiumDepth;
@property (nonatomic,strong) NSString *visibility;
@property (nonatomic,strong) NSString *temperature;

@end
