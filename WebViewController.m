//
//  WebViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 2013/11/28.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "WebViewController.h"
#import "AppDelegate.h"
#import "StarterViewController.h"

@interface WebViewController (){
    
    UIActivityIndicatorView *spinner;
    AppDelegate *delegate;
    StarterViewController *starterViewController;
}

@end

@implementation WebViewController

@synthesize webView,pageTitle,pathString;

-(void)loadView
{
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    starterViewController = [[StarterViewController alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = pageTitle;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSString *url = pathString;
    NSURL *pathURL = [NSURL URLWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:pathURL];
    [self.webView loadRequest:request];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    self.navigationItem.backBarButtonItem.title = @"首頁";

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webView.frame = self.view.bounds;
    self.webView.scalesPageToFit = YES;
    spinner.frame = self.view.bounds;
}

- (void)webViewDidStartLoad:(UIWebView *)aWebView
{
    spinner.color = [UIColor blackColor];
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    [spinner stopAnimating];
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error
{
    if (error.code == NSURLErrorNotConnectedToInternet) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You are not connected! Please check your internet connection!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"The website is currently not available! Please check it later!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [delegate.navi pushViewController:starterViewController animated:NO];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
