//
//  StarterViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 2013/11/28.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "StarterViewController.h"
#import "AppDelegate.h"

#import "LoginViewController.h"

@interface StarterViewController (){
    
    AppDelegate *delegate;
    
    LoginViewController *loggedInAndOut;
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

-(void)fbLogInAndOut:(id)sender
{
    [delegate.navi pushViewController:loggedInAndOut animated:NO];
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
    //UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"main_background.png"]];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"main_background_.png"]];
    self.logViewController = [[LogViewController alloc] init];
    self.gisViewController = [[GISViewController alloc] init];
    
    loggedInAndOut = [[LoginViewController alloc] init];
    self.navigationItem.title = @"台中潛水";
    
    UIButton *toLogButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toLogButton setBackgroundImage:[UIImage imageNamed:@"main_button2.png"] forState:UIControlStateNormal];
    [toLogButton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-200, 180, 60)];
    [toLogButton addTarget:self action:@selector(toLog:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toLogButton];
    
    UIButton *addLogBitton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addLogBitton setBackgroundImage:[UIImage imageNamed:@"main_button.png"] forState:UIControlStateNormal];
    [addLogBitton setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-120, 180, 60)];
    [addLogBitton addTarget:self action:@selector(addLog:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addLogBitton];
    
    UIButton *FBLoginout = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [FBLoginout setFrame:CGRectMake(self.view.center.x-84, self.view.center.y-100, 180, 60)];
    [FBLoginout setTitle:@"登入/登出" forState:UIControlStateNormal];
    [FBLoginout addTarget:self action:@selector(fbLogInAndOut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FBLoginout];
    
    UIButton *websiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [websiteButton setBackgroundImage:[UIImage imageNamed:@"Taichung_Diving.png"] forState:UIControlStateNormal];
    [websiteButton setFrame:CGRectMake(self.view.center.x-90, self.view.center.y-0, 180, 180)];
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

@end
