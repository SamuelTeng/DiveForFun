//
//  LoginViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 2014/1/2.
//  Copyright (c) 2014年 Samuel Teng. All rights reserved.
//

#import "LoginViewController.h"
#import "StarterViewController.h"

@interface LoginViewController (){
    
    
    StarterViewController *starterViewController;
    
}

@end

@implementation LoginViewController

@synthesize profilePic,asLabel,loginLabel;

-(void)loadView
{
    [super loadView];
    
    FBLoginView *fbLoginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info",@"email",@"user_likes"]];
    fbLoginView.delegate = self;
    fbLoginView.frame = CGRectOffset(fbLoginView.frame, (self.view.center.x - (fbLoginView.frame.size.width/2)), 5);
    fbLoginView.center = self.view.center;
    [self.view addSubview:fbLoginView];
    
    self.profilePic = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(111, 168, 50, 50)];
    [self.view addSubview:self.profilePic];
    
    self.asLabel = [[UILabel alloc] initWithFrame:CGRectMake(158, 159, 145, 21)];
    [self.view addSubview:self.asLabel];
    
    self.loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(222, 178, 156, 21)];
    [self.view addSubview:self.loginLabel];
    
    self.navigationItem.hidesBackButton = YES;
//    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //self.spinner.frame = self.view.bounds;
    //[self.view addSubview:spinner];
    

}


- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    

}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    
    self.profilePic.profileID = user.id;
    self.loginLabel.text = user.name;
    //self.spinner.color = [UIColor blackColor];
    //[self.view addSubview:spinner];
    
    
    if (self.profilePic.profileID != nil) {
        
        [self showMesage:@"You're now logged in" withTitle:@"Welcome!"];
    }
    
}

-(void)showMesage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@"OK!", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"Cancel is clicked");
            break;
        
        case 1:
            NSLog(@"OK is clicked");
            [self toStarterPage];
            break;
            
        default:
            break;
    }
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    self.profilePic.profileID = nil;
    
}

- (void)loginView:(FBLoginView *)loginView
      handleError:(NSError *)error
{
    NSString *alertMessage , *alertTitle;
    
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook 錯誤";
        alertMessage = [FBErrorUtility userMessageForError:error];
    }else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
        alertTitle = @"操作階段錯誤";
        alertMessage = @"您的操作階段已結束 請重新登入";
    }else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled){
        NSLog(@"user cancelled");
    }else{
        alertTitle = @"錯誤";
        alertMessage = @"意外錯誤發生 請稍後再試一次";
        NSLog(@"unexpected error:%@",error);
    }
    
    if (alertMessage) {
        [self showMesage:alertMessage withTitle:alertTitle];
    }
}

-(void)toStarterPage
{
    NSLog(@"selector perform successfully");
    starterViewController = [[StarterViewController alloc] init];
    [self.navigationController pushViewController:starterViewController animated:NO];
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
