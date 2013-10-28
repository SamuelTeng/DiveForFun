//
//  LogOptionsViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/8/23.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewCover : UIView

@property (nonatomic,assign) UIAlertView *alert;



@end

@protocol LogOptionsViewControllerDelegate <NSObject>


-(void)didSelectDate:(NSString *)aCellData latitude:(NSString *)bCellData lontitude:(NSString *)cCellData time:(NSString *)dCelldata;

@end

@interface LogOptionsViewController : UITableViewController<UITableViewDelegate,NSFetchedResultsControllerDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) NSString *dateStr;
@property (nonatomic,strong) NSArray *latArr;
@property (nonatomic,strong) NSArray *lonArr;
@property (nonatomic,strong) NSArray *timeArr;
//@property (nonatomic,strong) UIAlertView *options;
@property (nonatomic,strong) NSString *aDateStr;
@property (nonatomic,strong) NSString *bLatData;
@property (nonatomic,strong) NSString *cLonData;
@property (nonatomic,strong) NSString *dTimeData;
@property (nonatomic,strong) id<LogOptionsViewControllerDelegate> delegate;
//-(void)loadFromTable;

@end
