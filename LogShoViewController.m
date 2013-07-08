//
//  LogShoViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/7/4.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "LogShoViewController.h"
#import "AppDelegate.h"
#import "LogRecordViewController.h"

@interface LogShoViewController (){
    
    AppDelegate *delegate;
    LogRecordViewController *logRecordViewController;
    UITextView *log;
}

@end

@implementation LogShoViewController
@synthesize annotation_,date,site,time,airType,preSta,preEnd,maxDep,temp,visib;

-(void)toLogRecord:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        NULL;
    }];
}

-(void)loadView
{
    [super loadView];
    delegate = [[UIApplication sharedApplication] delegate];
    logRecordViewController = [[LogRecordViewController alloc] init];
    
    UIScrollView *logShowView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    logShowView.contentSize = CGSizeMake(self.view.bounds.size.width, 600);
    [self.view addSubview:logShowView];
    
    /*data that is passed by mapview delegate by importing class importing MKAnnotation.h or inherited MKAnnotation*/
    date = annotation_.title;
    site = annotation_.subtitle;
    time = annotation_.timeOfDiving;
    airType = annotation_.airType;
    preSta = annotation_.pressureOfStart;
    preEnd = annotation_.pressureOfEnd;
    maxDep = annotation_.maxiumDepth;
    temp = annotation_.temperature;
    visib = annotation_.visibility;
    
    NSString *_log = [NSString stringWithFormat:@" Date: %@ \n\n Site: %@ \n\n Time of dive: %@ minutes \n\n Type of air: %@ \n\n Start pressure: %@ bar\n\n End pressure: %@ bar\n\n Maxium depth: %@ \n\n Temperature: %@ \n\n Visibility: %@", date,site,time,airType,preSta,preEnd,maxDep,temp,visib];
    
    log = [[UITextView alloc] initWithFrame:self.view.bounds];
    [log setText:_log];
    log.textColor = [UIColor blackColor];
    [log setFont:[UIFont systemFontOfSize:20.0]];
    [logShowView addSubview:log];
    
    NSLog(@"date is %@, site is %@", date,site);
    

    
    self.view.backgroundColor = [UIColor whiteColor];
    
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *toRecord = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(toLogRecord:)];
    self.navigationItem.leftBarButtonItem = toRecord;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
