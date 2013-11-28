//
//  WebViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 2013/11/28.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController<UIWebViewDelegate,UIAlertViewDelegate>




@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)NSString *pathString;
@property (nonatomic,strong)NSString *pageTitle;


@end
