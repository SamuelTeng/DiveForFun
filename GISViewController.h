//
//  GISViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LogViewController.h"

@interface GISViewController : UITableViewController<UITableViewDelegate, NSFetchedResultsControllerDelegate,UIAlertViewDelegate>


@property (nonatomic,strong) LogViewController *logViewController;



@end
