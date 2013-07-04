//
//  MainViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "RouteViewController.h"
#import "LogRecordViewController.h"

@interface MainViewController (){
    
    AppDelegate *delegate;
    RouteViewController *routeViewController;
    LogRecordViewController *logRecordViewController;

}

@end

@implementation MainViewController
@synthesize ice,log,route,info;


-(void)toLog:(id)sender
{
    [delegate.navi pushViewController:logRecordViewController animated:YES];
}

-(void)toRoute:(id)sender
{
    [delegate.navi pushViewController:routeViewController animated:YES];
}

-(void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor grayColor];
    delegate = [[UIApplication sharedApplication] delegate];
    self.navigationItem.hidesBackButton = YES;
    
    ice = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ice.frame = CGRectMake(124, 64, 73, 44);
    [ice setTitle:@"ICE" forState:UIControlStateNormal];
    ice.titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:ice];
    
    log = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    log.frame = CGRectMake(124, 154, 73, 44);
    [log setTitle:@"Log" forState:UIControlStateNormal];
    log.titleLabel.textColor = [UIColor blackColor];
    [log addTarget:self action:@selector(toLog:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:log];
    
    route = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    route.frame = CGRectMake(124, 244, 73, 44);
    [route setTitle:@"Route" forState:UIControlStateNormal];
    route.titleLabel.textColor = [UIColor blackColor];
    [route addTarget:self action:@selector(toRoute:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:route];
    
    info = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    info.frame = CGRectMake(124, 334, 73, 44);
    [info setTitle:@"Info" forState:UIControlStateNormal];
    info.titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:info];
    
    routeViewController = [[RouteViewController alloc] init];
    logRecordViewController = [[LogRecordViewController alloc] init];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
