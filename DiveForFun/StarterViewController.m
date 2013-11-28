//
//  StarterViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 2013/11/28.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "StarterViewController.h"
#import "AppDelegate.h"

@interface StarterViewController (){
    
    AppDelegate *delegate;
}

@end

@implementation StarterViewController

@synthesize logViewController,gisViewController,webViewController;

-(void)toLog:(id)sender
{
    [delegate.navi pushViewController:self.gisViewController animated:NO];
}

-(void)addLog:(id)sender
{
    [delegate.navi pushViewController:self.logViewController animated:NO];
}

-(void)webSite:(id)sender
{
    self.webViewController = [[WebViewController alloc] init];
    self.webViewController.pathString = @"http://www.td-club.com.tw";
    self.webViewController.pageTitle = @"台中潛水";
    [delegate.navi pushViewController:self.webViewController animated:NO];
}

-(void)loadView
{
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
    self.logViewController = [[LogViewController alloc] init];
    self.gisViewController = [[GISViewController alloc] init];
    self.navigationItem.title = @"台中潛水";
    
    UIButton *toLogButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toLogButton setBackgroundImage:[UIImage imageNamed:@"Log_Book.png"] forState:UIControlStateNormal];
    [toLogButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-200, 64, 64)];
    [toLogButton addTarget:self action:@selector(toLog:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toLogButton];
    
    UIButton *addLogBitton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addLogBitton setBackgroundImage:[UIImage imageNamed:@"Edit_Log_Book.png"] forState:UIControlStateNormal];
    [addLogBitton setFrame:CGRectMake(self.view.center.x+24, self.view.center.y-200, 64, 64)];
    [addLogBitton addTarget:self action:@selector(addLog:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addLogBitton];
    
    UIButton *websiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [websiteButton setBackgroundImage:[UIImage imageNamed:@"Taichung_Diving.png"] forState:UIControlStateNormal];
    [websiteButton setFrame:CGRectMake(self.view.center.x-90, self.view.center.y-100, 180, 180)];
    [websiteButton addTarget:self action:@selector(webSite:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:websiteButton];
    
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *backToHome = [[UIBarButtonItem alloc] init];
    backToHome.title = @"首頁";
    self.navigationItem.backBarButtonItem = backToHome;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
