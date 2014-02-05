//
//  LoginViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 2014/1/2.
//  Copyright (c) 2014年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController : UIViewController<FBLoginViewDelegate, UIAlertViewDelegate>

@property (nonatomic,strong) FBProfilePictureView *profilePic;

@property (nonatomic,strong) UILabel *asLabel;

@property (nonatomic,strong) UILabel *loginLabel;

//@property (nonatomic,strong) UIActivityIndicatorView *spinner;

@end
