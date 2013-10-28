//
//  DIVELOG.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DIVELOG : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * dive_time;
@property (nonatomic, retain) NSString * max_depth;
@property (nonatomic, retain) NSString * gas_type;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * lontitude;
@property (nonatomic, retain) NSString * site;
@property (nonatomic, retain) NSString * visibility;
@property (nonatomic, retain) NSString * temperature;
@property (nonatomic, retain) NSString * start_pressure;
@property (nonatomic, retain) NSString * end_pressure;
@property (nonatomic, retain) NSData * others;
@property (nonatomic, retain) NSData * signature;

@end
