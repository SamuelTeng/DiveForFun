//
//  GISDATA.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GISDATA : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSData * latitude;
@property (nonatomic, retain) NSData * lontitude;
@property (nonatomic, retain) NSData * course;
@property (nonatomic, retain) NSData * timestamp;
@property (nonatomic, retain) NSData * altitude;

@end
