//
//  PageViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 2013/11/13.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "PageViewController.h"
#import "ModelController.h"
#import "LogShoViewController.h"
#import "LogDatabase.h"

@interface PageViewController (){
    
    ModelController *modelController;
    LogDatabase *logDatabase;
    LogShoViewController *logShowViewController;
}

@end

@implementation PageViewController

@synthesize startPage,_section;

//-(id)init
//{
//   
//    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
//    
//    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
//    return self;
//}

-(void)loadView
{
    [super loadView];
    
    //logShowViewController = [[LogShoViewController alloc] init];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.delegate = self;
    
    modelController = [[ModelController alloc] init];
    self.dataSource = modelController;
    
    logDatabase = [LogDatabase new];
    
    //logShowViewController = [[LogShoViewController alloc] init];
//    logShowViewController.contenPath = [NSIndexPath indexPathForRow:self.startPage inSection:self._section];
//    [self setViewControllers:[NSArray arrayWithObjects:logShowViewController, nil] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//    NSLog(@"pageview: row=%i section=%i", self.startPage, self._section);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    logShowViewController = [[LogShoViewController alloc] init];
    logShowViewController.contenPath = [NSIndexPath indexPathForRow:self.startPage inSection:self._section];
    
    /*set "animated" to "NO" to prevent "UIWindow" issue from happening*/
    [self setViewControllers:[NSArray arrayWithObjects:logShowViewController, nil] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    NSLog(@"pageview: row=%i section=%i", self.startPage, self._section);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    logDatabase = nil;
    logShowViewController = nil;
    modelController = nil;
}

@end
