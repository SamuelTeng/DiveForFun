//
//  PageViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 2013/11/13.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIPageViewController<UIPageViewControllerDelegate>

@property (nonatomic) int startPage;
@property (nonatomic) int _section;

@end
