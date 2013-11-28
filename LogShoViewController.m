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
#import "GISViewController.h"
#import "LogDatabase.h"

@interface LogShoViewController (){
    
    AppDelegate *delegate;
    //LogRecordViewController *logRecordViewController;
    GISViewController *gisViewController;
    LogDatabase *logDatabase;
    //UITextView *log;
}
@property (nonatomic,strong) UITextView *log;
@end

@implementation LogShoViewController
@synthesize annotation_;
@synthesize  date,site,time,airType,preSta,preEnd,maxDep,temp,visib,log,img,sign,logShowView,waves,current;
@synthesize contenPath;

-(void)toLogRecord:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

-(void)lodeLog
{
    date = [logDatabase date:contenPath];
    //delegate.date;
    site = [logDatabase site:contenPath];
    //delegate.site;
    time = [logDatabase time:contenPath];
    //delegate.timeOfDiving;
    airType = [logDatabase gas:contenPath];
    //delegate.airType;
    preSta = [logDatabase startPressure:contenPath];
    //delegate.pressureOfStart;
    preEnd = [logDatabase endPressure:contenPath];
    //delegate.pressureOfEnd;
    maxDep = [logDatabase depth:contenPath];
    //delegate.maxiumDepth;
    temp = [logDatabase temprature:contenPath];
    //delegate.temperature;
    visib = [logDatabase visibility:contenPath];
    //delegate.visibility;
    img = [logDatabase imageData:contenPath];
    //delegate.imageData;
    sign = [logDatabase signatureData:contenPath];
    //delegate.signature;
    
    waves = [logDatabase waves:contenPath];
    
    current = [logDatabase current:contenPath];
    
    if (img == NULL && sign == NULL) {
        NSString *_log = [NSString stringWithFormat:@" 日期: %@ \n\n 潛點: %@ \n\n 潛水時間: %@ minutes \n\n 氣源: %@ \n\n Start pressure: %@ bar\n\n End pressure: %@ bar\n\n 最大深度: %@ \n\n 水溫: %@ \n\n 能見度: %@", date,site,time,airType,preSta,preEnd,maxDep,temp,visib];
        
        log = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1100)];
        [log setText:_log];
        log.textColor = [UIColor blackColor];
        [log setFont:[UIFont systemFontOfSize:20.0]]; 
        log.editable = NO;
        [logShowView addSubview:log];
        
        NSLog(@"date is %@, site is %@", date,site);
        UIButton *Calendar = [UIButton buttonWithType:UIButtonTypeCustom];
        [Calendar setBackgroundImage:[UIImage imageNamed:@"calendar.png"] forState:UIControlStateNormal];
        [Calendar setTitle:date forState:UIControlStateNormal];
        [Calendar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Calendar setTitleEdgeInsets:UIEdgeInsetsMake(35, 10, 10, 10)];
        [Calendar setFrame:CGRectMake(log.center.x-100, 480, 128, 128)];
        [log addSubview:Calendar];
        
        UIButton *Current = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([current isEqualToString:@"有"]) {
            [Current setBackgroundImage:[UIImage imageNamed:@"current.png"] forState:UIControlStateNormal];
            [Current setFrame:CGRectMake(log.center.x-100, 618, 128, 128)];
            [log addSubview:Current];
        }else if ([current isEqualToString:@"無"]){
            [Current setBackgroundImage:[UIImage imageNamed:@"no_current.png"] forState:UIControlStateNormal];
            [Current setFrame:CGRectMake(log.center.x-100, 618, 128, 128)];
            [log addSubview:Current];
        }
        
        UIButton *_waves = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([waves isEqualToString:@"大"]) {
            [_waves setBackgroundImage:[UIImage imageNamed:@"large_wave.png"] forState:UIControlStateNormal];
            [_waves setFrame:CGRectMake(log.center.x-100, 756, 128, 128)];
            [log addSubview:_waves];
        }else if ([waves isEqualToString:@"中"]){
            [_waves setBackgroundImage:[UIImage imageNamed:@"middle_wave.png"] forState:UIControlStateNormal];
            [_waves setFrame:CGRectMake(log.center.x-100, 756, 128, 128)];
            [log addSubview:_waves];
        }else if ([waves isEqualToString:@"小"]){
            [_waves setBackgroundImage:[UIImage imageNamed:@"small_wave.png"] forState:UIControlStateNormal];
            [_waves setFrame:CGRectMake(log.center.x-100, 756, 128, 128)];
            [log addSubview:_waves];
        }else if ([waves isEqualToString:@"平"]){
            [_waves setBackgroundImage:[UIImage imageNamed:@"no_wave.png"] forState:UIControlStateNormal];
            [_waves setFrame:CGRectMake(log.center.x-100, 756, 128, 128)];
            [log addSubview:_waves];
        }
        
        self.view.backgroundColor = [UIColor grayColor];
        
    }else if(sign == NULL){
        
        UIImage *textViewBackgroundImage = [UIImage imageWithData:img];

        
        /*logShowView.backgroundColor = [UIColor colorWithPatternImage:scrollBackgroundImage];*/
        
        NSString *_log = [NSString stringWithFormat:@" 日期: %@ \n\n 潛點: %@ \n\n 潛水時間: %@ minutes \n\n 氣源: %@ \n\n Start pressure: %@ bar\n\n End pressure: %@ bar\n\n 最大深度: %@ \n\n 水溫: %@ \n\n 能見度: %@", date,site,time,airType,preSta,preEnd,maxDep,temp,visib];
        
        log = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1100)];
        [log setText:_log];
        log.textColor = [UIColor blueColor ];
        [log setFont:[UIFont systemFontOfSize:20.0]];
        log.editable = NO;
        [logShowView addSubview:log];
        
        // NSLog(@"have image in database");
        
        UIImageView *selectedImage =[[UIImageView alloc] initWithFrame:CGRectMake(log.center.x-100, 480, 200, 200)];
        //[[UIImageView alloc] initWithFrame:log.frame];
        selectedImage.image = textViewBackgroundImage;
        
        [log addSubview:selectedImage];
        


        
    }else if(img == NULL){
        

        UIImage *signatureImage = [UIImage imageWithData:sign];
        
        /*logShowView.backgroundColor = [UIColor colorWithPatternImage:scrollBackgroundImage];*/
        
        NSString *_log = [NSString stringWithFormat:@" 日期: %@ \n\n 潛點: %@ \n\n 潛水時間: %@ minutes \n\n 氣源: %@ \n\n Start pressure: %@ bar\n\n End pressure: %@ bar\n\n 最大深度: %@ \n\n 水溫: %@ \n\n 能見度: %@", date,site,time,airType,preSta,preEnd,maxDep,temp,visib];
        
        log = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1100)];
        [log setText:_log];
        log.textColor = [UIColor blueColor ];
        [log setFont:[UIFont systemFontOfSize:20.0]];
        log.editable = NO;
        [logShowView addSubview:log];
        
        // NSLog(@"have image in database");
        

        
        UIImageView *signature = [[UIImageView alloc] initWithFrame:CGRectMake(log.center.x-200, 480, 400, 300)];
        signature.image = signatureImage;
        [log addSubview:signature];

        
    }else{
        
        UIImage *textViewBackgroundImage = [UIImage imageWithData:img];
        UIImage *signatureImage = [UIImage imageWithData:sign];
        
        /*logShowView.backgroundColor = [UIColor colorWithPatternImage:scrollBackgroundImage];*/
        
        NSString *_log = [NSString stringWithFormat:@" 日期: %@ \n\n 潛點: %@ \n\n 潛水時間: %@ minutes \n\n 氣源: %@ \n\n Start pressure: %@ bar\n\n End pressure: %@ bar\n\n 最大深度: %@ \n\n 水溫: %@ \n\n 能見度: %@", date,site,time,airType,preSta,preEnd,maxDep,temp,visib];
        
        log = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1100)];
        [log setText:_log];
        log.textColor = [UIColor blueColor ];
        [log setFont:[UIFont systemFontOfSize:20.0]];
        log.editable = NO;
        [logShowView addSubview:log];
        
       // NSLog(@"have image in database");
        
        UIImageView *selectedImage =[[UIImageView alloc] initWithFrame:CGRectMake(log.center.x-100, 480, 200, 200)];
        //[[UIImageView alloc] initWithFrame:log.frame];
        selectedImage.image = textViewBackgroundImage;
       
        [log addSubview:selectedImage];
        
        UIImageView *signature = [[UIImageView alloc] initWithFrame:CGRectMake(log.center.x-200, 700, 400, 300)];
        signature.image = signatureImage;
        [log addSubview:signature];
        
        //[log sendSubviewToBack:backgroundImage];
        
        /*self.view.backgroundColor = [UIColor colorWithPatternImage:scrollBackgroundImage];*/
        
    }

}

-(void)loadView
{
    [super loadView];
    delegate = [[UIApplication sharedApplication] delegate];
    //logRecordViewController = [[LogRecordViewController alloc] init];
    gisViewController = [[GISViewController alloc] init];
    
    logDatabase = [LogDatabase new];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    /*data that is passed by mapview delegate by importing class importing MKAnnotation.h or inherited MKAnnotation*/
//    date = annotation_.title;
//    site = annotation_.subtitle;
//    time = annotation_.timeOfDiving;
//    airType = annotation_.airType;
//    preSta = annotation_.pressureOfStart;
//    preEnd = annotation_.pressureOfEnd;
//    maxDep = annotation_.maxiumDepth;
//    temp = annotation_.temperature;
//    visib = annotation_.visibility;

    logShowView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    logShowView.contentSize = CGSizeMake(self.view.bounds.size.width,
                                         1100//self.view.bounds.size.height+10
                                         );
    [self.view addSubview:logShowView];
    
    
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIBarButtonItem *toRecord = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(toLogRecord:)];
//    self.navigationItem.leftBarButtonItem = toRecord;

	// Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self lodeLog];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    date = nil;
    site = nil;
    time = nil;
    airType = nil;
    preSta = nil;
    preEnd = nil;
    maxDep = nil;
    temp = nil;
    visib = nil;
    img = nil;
    sign = nil;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    logDatabase = nil;
    date = nil;
    site = nil;
    time = nil;
    airType = nil;
    preSta = nil;
    preEnd = nil;
    maxDep = nil;
    temp = nil;
    visib = nil;
    img = nil;
    sign = nil;

}

@end
