//
//  LogShoViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/7/4.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogAnnotation.h"

@interface LogShoViewController : UIViewController

@property (nonatomic,strong) LogAnnotation *annotation_;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *site;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *airType;
@property (nonatomic,strong) NSString *preSta;
@property (nonatomic,strong) NSString *preEnd;
@property (nonatomic,strong) NSString *maxDep;
@property (nonatomic,strong) NSString *temp;
@property (nonatomic,strong) NSString *visib;


@end
