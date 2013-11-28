//
//  StarterViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 2013/11/28.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogViewController.h"
#import "GISViewController.h"
#import "WebViewController.h"

@interface StarterViewController : UIViewController

@property (nonatomic,strong) LogViewController *logViewController;
@property (nonatomic,strong) GISViewController *gisViewController;
@property (nonatomic,strong) WebViewController *webViewController;

@end
