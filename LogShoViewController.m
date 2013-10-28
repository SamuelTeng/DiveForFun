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

@interface LogShoViewController (){
    
    AppDelegate *delegate;
    //LogRecordViewController *logRecordViewController;
    GISViewController *gisViewController;
    //UITextView *log;
}
@property (nonatomic,strong) UITextView *log;
@end

@implementation LogShoViewController
@synthesize annotation_,date,site,time,airType,preSta,preEnd,maxDep,temp,visib,log,img,sign,logShowView;

-(void)toLogRecord:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)lodeLog
{
    date = delegate.date;
    site = delegate.site;
    time = delegate.timeOfDiving;
    airType = delegate.airType;
    preSta = delegate.pressureOfStart;
    preEnd = delegate.pressureOfEnd;
    maxDep = delegate.maxiumDepth;
    temp = delegate.temperature;
    visib = delegate.visibility;
    img = delegate.imageData;
    sign = delegate.signature;
    
    if (img == NULL && sign == NULL) {
        NSString *_log = [NSString stringWithFormat:@" 日期: %@ \n\n 潛點: %@ \n\n 潛水時間: %@ minutes \n\n 氣源: %@ \n\n Start pressure: %@ bar\n\n End pressure: %@ bar\n\n 最大深度: %@ \n\n 水溫: %@ \n\n 能見度: %@", date,site,time,airType,preSta,preEnd,maxDep,temp,visib];
        
        log = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1100)];
        [log setText:_log];
        log.textColor = [UIColor blackColor];
        [log setFont:[UIFont systemFontOfSize:20.0]];
        [logShowView addSubview:log];
        
        NSLog(@"date is %@, site is %@", date,site);
        
        
        
        self.view.backgroundColor = [UIColor whiteColor];
        
    }else if(sign == NULL){
        
        UIImage *textViewBackgroundImage = [UIImage imageWithData:img];

        
        /*logShowView.backgroundColor = [UIColor colorWithPatternImage:scrollBackgroundImage];*/
        
        NSString *_log = [NSString stringWithFormat:@" 日期: %@ \n\n 潛點: %@ \n\n 潛水時間: %@ minutes \n\n 氣源: %@ \n\n Start pressure: %@ bar\n\n End pressure: %@ bar\n\n 最大深度: %@ \n\n 水溫: %@ \n\n 能見度: %@", date,site,time,airType,preSta,preEnd,maxDep,temp,visib];
        
        log = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1100)];
        [log setText:_log];
        log.textColor = [UIColor blueColor ];
        [log setFont:[UIFont systemFontOfSize:20.0]];
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
    UIBarButtonItem *toRecord = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(toLogRecord:)];
    self.navigationItem.leftBarButtonItem = toRecord;

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
    
}

-(void)viewDidUnload
{
    //logRecordViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
