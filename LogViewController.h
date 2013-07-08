//
//  LogViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/24.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate>


@property (readonly , strong ,nonatomic) NSManagedObjectContext *managedObjectContext;

@end
