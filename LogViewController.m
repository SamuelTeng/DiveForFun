//
//  LogViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/24.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "LogViewController.h"
#import "DIVELOG.h"
#import "AppDelegate.h"
#import "LogRecordViewController.h"

@interface LogViewController (){
    
    UIScrollView *scrollView;
    UILabel *dateLabel;
    UILabel *siteLabel;
    UILabel *latLabel;
    UILabel *lonLabel;
    UILabel *maxDepLabel;
    UILabel *gasLabel;
    UILabel *divetimeLabel;
    UILabel *visiLabel;
    UILabel *temperLabel;
    UILabel *staPrelabel;
    UILabel *endPreLabel;
    UILabel *otherLabel;
    UITextField *dateField;
    UITextField *siteField;
    UITextField *latField;
    UITextField *lonField;
    UITextField *maxDepField;
    UITextField *gasField;
    UITextField *divetimeField;
    UITextField *visiField;
    UITextField *temperField;
    UITextField *staPreField;
    UITextField *endPreField;
    UITextField *otherField;
    
    NSString *selectedRow;
    NSArray *gasArr;
    NSArray *firstRow;
    NSArray *secondRow;
    NSArray *thirdRow;
    NSArray *forthRow;
    NSArray *mAndf;
    NSArray *cAndf;
    
    AppDelegate *delegate;
    LogRecordViewController *logRecordViewController;
}

@end

@implementation LogViewController

@synthesize managedObjectContext;

-(void)saveToData:(id)sender
{
    NSString *dateStr = dateField.text;
    NSLog(@"%@",dateStr);
    dateField.text = nil;
    
    NSString *site = siteField.text;
    siteField.text = nil;
    
    NSString *latitude = latField.text;
    latField.text = nil;
    
    NSString *lontitude = lonField.text;
    lonField.text = nil;
    
    NSString *maxDepth = maxDepField.text;
    maxDepField.text = nil;
    
    NSString *gasType = gasField.text;
    gasField.text = nil;
    
    NSString *diveTime = divetimeField.text;
    NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
    [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
    divetimeField.text = nil;
    
    NSString *visibility = visiField.text;
    visiField.text = nil;
    
    NSString *temperature = temperField.text;
    temperField.text = nil;
    
    NSString *startPressure = staPreField.text;
    NSNumberFormatter *startPressureFormatter = [[NSNumberFormatter alloc] init];
    [startPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *_startPressure = [startPressureFormatter numberFromString:startPressure];
    staPreField.text = nil;
    
    NSString *endPressure = endPreField.text;
    NSNumberFormatter *endPressureFormatter = [[NSNumberFormatter alloc] init];
    [endPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *_endPressure = [endPressureFormatter numberFromString:endPressure];
    endPreField.text = nil;
    
    DIVELOG *database = (DIVELOG *)[NSEntityDescription insertNewObjectForEntityForName:@"DIVELOG" inManagedObjectContext:managedObjectContext ];
    database.date = dateStr;
    database.site = site;
    database.latitude = latitude;
    database.lontitude = lontitude;
    database.max_depth = maxDepth;
    database.gas_type = gasType;
    database.dive_time = _diveTime;
    database.visibility = visibility;
    database.temperature = temperature;
    database.start_pressure = _startPressure;
    database.end_pressure = _endPressure;
    
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"error:%@", [error localizedFailureReason]);
    }
    
    //[delegate.navi pushViewController:logRecordViewController animated:YES];
}

-(void)toLogRecord:(id)sender
{
    [delegate.navi pushViewController:logRecordViewController animated:YES];
}

-(NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc ] init];
//    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formatData = [dateFormatter stringFromDate:date];
    return formatData;
    
}

-(void)updateDateField:(id)sender
{
    UIDatePicker *picker =(UIDatePicker *) dateField.inputView;
    dateField.text = [self formatDate:picker.date];
}

-(void)donePicking:(id)sender
{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)aPickerView
{
    if (aPickerView.tag == 201) {
        return 1;
    }else if (aPickerView.tag == 202){
        return 3;
    }else if (aPickerView.tag == 203){
        return 3;
    }else if (aPickerView.tag == 204){
        return 5;
    }else if (aPickerView.tag == 205){
        return 5;
    }else if (aPickerView.tag == 206){
        return 4;
    }

    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 201) {
        return [gasArr count];
    }else if (pickerView.tag == 202){
        if (component == 0) {
            return [firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (pickerView.tag == 203){
        if (component == 0) {
            return [firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (pickerView.tag == 204){
        if (component == 0) {
            return [firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [forthRow count];
        }else if (component == 4){
            return [mAndf count];
        }

    }else if (pickerView.tag == 205){
        if (component == 0) {
            return [firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [forthRow count];
        }else if (component == 4){
            return [cAndf count];
        }
    }else if (pickerView.tag == 206){
        if (component == 0) {
            return [firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [mAndf count];
        }
        
    }

    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 201) {
        return [gasArr objectAtIndex:row];
    }else if (pickerView.tag == 202){
        if (component == 0) {
            return [firstRow objectAtIndex:row];
        }else if (component == 1){
            return [secondRow objectAtIndex:row];
        }else if (component == 2){
            return [thirdRow objectAtIndex:row];
        }
    }else if (pickerView.tag == 203){
        if (component == 0) {
            return [firstRow objectAtIndex:row];
        }else if (component == 1){
            return [secondRow objectAtIndex:row];
        }else if (component == 2){
            return [thirdRow objectAtIndex:row];
        }
    }else if (pickerView.tag == 204){
        if (component == 0) {
            return [firstRow objectAtIndex:row];
        }else if (component == 1){
            return [secondRow objectAtIndex:row];
        }else if (component == 2){
            return [thirdRow objectAtIndex:row];
        }else if (component == 3){
            return [forthRow objectAtIndex:row];
        }else if (component == 4){
            return [mAndf objectAtIndex:row];
        }
    }else if (pickerView.tag == 205){
        if (component == 0) {
            return [firstRow objectAtIndex:row];
        }else if (component == 1){
            return [secondRow objectAtIndex:row];
        }else if (component == 2){
            return [thirdRow objectAtIndex:row];
        }else if (component == 3){
            return [forthRow objectAtIndex:row];
        }else if (component == 4){
            return [cAndf objectAtIndex:row];
        }
    }else if (pickerView.tag == 206){
        if (component == 0) {
            return [firstRow objectAtIndex:row];
        }else if (component == 1){
            return [secondRow objectAtIndex:row];
        }else if (component == 2){
            return [thirdRow objectAtIndex:row];
        }else if (component == 3){
            return [mAndf objectAtIndex:row];
        }
    }

    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 201) {
        NSInteger row = [pickerView selectedRowInComponent:0];
        selectedRow = [gasArr objectAtIndex:row];
        gasField.text = selectedRow;
    }else if (pickerView.tag == 202){
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        NSInteger row3 = [pickerView selectedRowInComponent:2];
        staPreField.text = [NSString stringWithFormat:@"%@ %@ %@",[firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (pickerView.tag == 203){
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        NSInteger row3 = [pickerView selectedRowInComponent:2];
        endPreField.text = [NSString stringWithFormat:@"%@ %@ %@",[firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (pickerView.tag == 204){
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        NSInteger row3 = [pickerView selectedRowInComponent:2];
        NSInteger row4 = [pickerView selectedRowInComponent:3];
        NSInteger row5 = [pickerView selectedRowInComponent:4];
        maxDepField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[forthRow objectAtIndex:row4],[mAndf objectAtIndex:row5]];
    }else if (pickerView.tag == 205){
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        NSInteger row3 = [pickerView selectedRowInComponent:2];
        NSInteger row4 = [pickerView selectedRowInComponent:3];
        NSInteger row5 = [pickerView selectedRowInComponent:4];
        temperField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[forthRow objectAtIndex:row4],[cAndf objectAtIndex:row5]];
    }else if (pickerView.tag == 206){
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        NSInteger row3 = [pickerView selectedRowInComponent:2];
        NSInteger row4 = [pickerView selectedRowInComponent:3];
        visiField.text = [NSString stringWithFormat:@"%@%@%@ %@",[firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[mAndf objectAtIndex:row4]];
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)aTextField
{
    if (aTextField.tag == 101) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:-31536000];
        //[NSDate dateWithTimeIntervalSinceNow:-31536000];
        [datePicker setDate:[NSDate date]];
        [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
        aTextField.inputView = datePicker;
        aTextField.text = [self formatDate:datePicker.date];
        
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        
        aTextField.inputAccessoryView = cancelBar;
    }else if (aTextField.tag == 102){
        
        aTextField.returnKeyType = UIReturnKeyDone;
        
    }else if (aTextField.tag == 103){
        
        aTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        aTextField.returnKeyType = UIReturnKeyDone;
        
    }else if (aTextField.tag == 104){
        
        aTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        aTextField.returnKeyType = UIReturnKeyDone;
    }else if (aTextField.tag == 105){
        
        UIPickerView *gasPicker = [[UIPickerView alloc] init];
        gasPicker.delegate = self;
        gasPicker.dataSource = self;
        gasPicker.showsSelectionIndicator = YES;
        [gasPicker setFrame:CGRectMake(0, 480, 320, 180)];
        
        [gasPicker setTag:201];
        
        aTextField.inputView = gasPicker;
        NSInteger row = [gasPicker selectedRowInComponent:0];
        aTextField.text = [gasArr objectAtIndex:row];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 106){
        
        UIPickerView *staPre = [[UIPickerView alloc] init];
        staPre.delegate = self;
        staPre.dataSource = self;
        staPre.showsSelectionIndicator = YES;
        [staPre setFrame:CGRectMake(0, 480, 320, 180)];
        [staPre setTag:202];
        
        aTextField.inputView = staPre;
        NSInteger row1 = [staPre selectedRowInComponent:0];
        NSInteger row2 = [staPre selectedRowInComponent:1];
        NSInteger row3 = [staPre selectedRowInComponent:2];
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@",[firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;

    }else if (aTextField.tag == 107){
        
        UIPickerView *endPre = [[UIPickerView alloc] init];
        endPre.delegate = self;
        endPre.dataSource = self;
        endPre.showsSelectionIndicator = YES;
        [endPre setFrame:CGRectMake(0, 480, 320, 180)];
        [endPre setTag:203];
        
        aTextField.inputView = endPre;
        NSInteger row1 = [endPre selectedRowInComponent:0];
        NSInteger row2 = [endPre selectedRowInComponent:1];
        NSInteger row3 = [endPre selectedRowInComponent:2];
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@",[firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;

    }else if (aTextField.tag == 108){
        
        UIPickerView *maxD = [[UIPickerView alloc] init];
        maxD.delegate = self;
        maxD.dataSource = self;
        maxD.showsSelectionIndicator = YES;
        [maxD setFrame:CGRectMake(0, 480, 320, 180)];
        [maxD setTag:204];
        
        aTextField.inputView = maxD;
        NSInteger row1 = [maxD selectedRowInComponent:0];
        NSInteger row2 = [maxD selectedRowInComponent:1];
        NSInteger row3 = [maxD selectedRowInComponent:2];
        NSInteger row4 = [maxD selectedRowInComponent:3];
        NSInteger row5 = [maxD selectedRowInComponent:4];
        aTextField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[forthRow objectAtIndex:row4],[mAndf objectAtIndex:row5]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
        
    }else if (aTextField.tag == 109){
        UIPickerView *temp = [[UIPickerView alloc] init];
        temp.delegate = self;
        temp.dataSource = self;
        temp.showsSelectionIndicator = YES;
        [temp setFrame:CGRectMake(0, 480, 320, 180)];
        [temp setTag:205];
        
        aTextField.inputView = temp;
        NSInteger row1 = [temp selectedRowInComponent:0];
        NSInteger row2 = [temp selectedRowInComponent:1];
        NSInteger row3 = [temp selectedRowInComponent:2];
        NSInteger row4 = [temp selectedRowInComponent:3];
        NSInteger row5 = [temp selectedRowInComponent:4];
        aTextField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[forthRow objectAtIndex:row4],[cAndf objectAtIndex:row5]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;

    }else if (aTextField.tag == 110){
        UIPickerView *visi = [[UIPickerView alloc] init];
        visi.delegate = self;
        visi.dataSource = self;
        visi.showsSelectionIndicator = YES;
        [visi setFrame:CGRectMake(0, 480, 320, 180)];
        [visi setTag:206];
        
        aTextField.inputView = visi;
        NSInteger row1 = [visi selectedRowInComponent:0];
        NSInteger row2 = [visi selectedRowInComponent:1];
        NSInteger row3 = [visi selectedRowInComponent:2];
        NSInteger row4 = [visi selectedRowInComponent:3];
        aTextField.text = [NSString stringWithFormat:@"%@%@%@ %@",[firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[mAndf objectAtIndex:row4]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;

    }else if (aTextField.tag == 111){
        
        aTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        aTextField.returnKeyType = UIReturnKeyDone;
    }
}

-(void)textAndLabel
{
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 88, 80, 21)];
    [dateLabel setText:@"Date"];
    [scrollView addSubview:dateLabel];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(130, 85, 97, 30)];
    [dateField setTag:101];
    dateField.delegate = self;
    dateField.placeholder = @"YYYY-mm-dd";
    dateField.borderStyle = UITextBorderStyleRoundedRect;
    dateField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:dateField];
    
    siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 154, 80, 21)];
    [siteLabel setText:@"Site"];
    [scrollView addSubview:siteLabel];
    
    siteField = [[UITextField alloc] initWithFrame:CGRectMake(130, 151, 97, 30)];
    [siteField setTag:102];
    siteField.delegate = self;
    siteField.placeholder = @"Site Name";
    siteField.borderStyle = UITextBorderStyleRoundedRect;
    siteField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:siteField];
    
    latLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 220, 100, 21)];
    [latLabel setText:@"Latitude"];
    [scrollView addSubview:latLabel];
    
    latField = [[UITextField alloc] initWithFrame:CGRectMake(130, 217, 97, 30)];
    [latField setTag:103];
    latField.delegate = self;
    latField.placeholder = @"25.061033";
    latField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:latField];
    
    lonLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 286, 100, 21)];
    [lonLabel setText:@"Lontitude"];
    [scrollView addSubview:lonLabel];
    
    lonField = [[UITextField alloc] initWithFrame:CGRectMake(130, 283, 97, 30)];
    [lonField setTag:104];
    lonField.delegate = self;
    lonField.placeholder = @"121.646056";
    lonField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:lonField];
    
    gasLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 352, 100, 21)];
    [gasLabel setText:@" Gas Type"];
    [scrollView addSubview:gasLabel];
    
    gasField = [[UITextField alloc] initWithFrame:CGRectMake(130, 349, 97, 30)];
    [gasField setTag:105];
    gasField.delegate = self;
    gasField.placeholder = @"Type of Gas";
    gasField.borderStyle = UITextBorderStyleRoundedRect;
    gasField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:gasField];
    
    staPrelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 428, 200, 21)];
    [staPrelabel setText:@"Start Pressure"];
    [scrollView addSubview:staPrelabel];
    
    staPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 425, 97, 30)];
    [staPreField setTag:106];
    staPreField.delegate = self;
    staPreField.placeholder = @"200 bar";
    staPreField.borderStyle = UITextBorderStyleRoundedRect;
    staPreField.adjustsFontSizeToFitWidth = YES;
    staPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:staPreField];
    
    endPreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 494, 200, 21)];
    [endPreLabel setText:@"End Pressure"];
    [scrollView addSubview:endPreLabel];
    
    endPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 491, 97, 30)];
    [endPreField setTag:107];
    endPreField.delegate = self;
    endPreField.placeholder = @"60 bar";
    endPreField.borderStyle = UITextBorderStyleRoundedRect;
    endPreField.adjustsFontSizeToFitWidth = YES;
    endPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:endPreField];
    
    maxDepLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 560, 100, 21)];
    [maxDepLabel setText:@"Max Depth"];
    [scrollView addSubview:maxDepLabel];
    
    maxDepField = [[UITextField alloc] initWithFrame:CGRectMake(130, 557, 97, 30)];
    [maxDepField setTag:108];
    maxDepField.delegate = self;
    maxDepField.placeholder = @"40 M";
    maxDepField.borderStyle = UITextBorderStyleRoundedRect;
    maxDepField.adjustsFontSizeToFitWidth = YES;
    maxDepField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:maxDepField];
    
    divetimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 626, 100, 21)];
    [divetimeLabel setText:@"Dive Time"];
    [scrollView addSubview:divetimeLabel];
    
    divetimeField = [[UITextField alloc] initWithFrame:CGRectMake(130, 623, 97, 30)];
    [divetimeField setTag:111];
    divetimeField.delegate = self;
    divetimeField.placeholder = @"in minutes";
    divetimeField.borderStyle = UITextBorderStyleRoundedRect;
    divetimeField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:divetimeField];
    
    temperLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 692, 100, 21)];
    [temperLabel setText:@"Temperture"];
    [scrollView addSubview:temperLabel];
    
    temperField = [[UITextField alloc] initWithFrame:CGRectMake(130, 689, 97, 30)];
    [temperField setTag:109];
    temperField.delegate = self;
    temperField.placeholder = @"";
    temperField.borderStyle = UITextBorderStyleRoundedRect;
    temperField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:temperField];
    
    visiLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 758, 100, 21)];
    [visiLabel setText:@"Visibility"];
    [scrollView addSubview:visiLabel];
    
    visiField = [[UITextField alloc] initWithFrame:CGRectMake(130, 755, 97, 30)];
    [visiField setTag:110];
    visiField.delegate = self;
    visiField.placeholder = @"15M";
    visiField.borderStyle = UITextBorderStyleRoundedRect;
    visiField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:visiField];

}

-(void)loadView
{
    [super loadView];
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1000);
    [self.view addSubview:scrollView];
    
    [self textAndLabel];
    
    gasArr = [NSArray arrayWithObjects:@"Normal Air",@"Nitrox",@"Closed Circuit",@"Surface Supplied", nil];
    firstRow = [NSArray arrayWithObjects:@" ",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    secondRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    thirdRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    forthRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    mAndf = [NSArray arrayWithObjects:@"m",@"ft", nil];
    cAndf = [NSArray arrayWithObjects:@"°C",@"°F", nil];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveToData:)];
    
    
    delegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = delegate.context;
    
    logRecordViewController = [[LogRecordViewController alloc] init];
    
    UIBarButtonItem *toLogRecord = [[UIBarButtonItem alloc] initWithTitle:@"Log" style:UIBarButtonItemStyleBordered target:self action:@selector(toLogRecord:)];
    NSArray *barButtonArr = [NSArray arrayWithObjects:save,toLogRecord, nil];
    self.navigationItem.rightBarButtonItems = barButtonArr;
    //self.navigationItem.hidesBackButton = YES;
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