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
//#import "LogOptionsViewController.h"
#import "GISViewController.h"
#import "PhotoViewController.h"
#import "SignatureViewController.h"

@interface LogViewController (){
    
//    UIScrollView *scrollView;
//    UILabel *dateLabel;
//    UILabel *siteLabel;
//    UILabel *latLabel;
//    UILabel *lonLabel;
//    UILabel *maxDepLabel;
//    UILabel *gasLabel;
//    UILabel *divetimeLabel;
//    UILabel *visiLabel;
//    UILabel *temperLabel;
//    UILabel *staPrelabel;
//    UILabel *endPreLabel;
//    UILabel *otherLabel;
//    UITextField *dateField;
//    UITextField *siteField;
//    UITextField *latField;
//    UITextField *lonField;
//    UITextField *maxDepField;
//    UITextField *gasField;
//    UITextField *divetimeField;
//    UITextField *visiField;
//    UITextField *temperField;
//    UITextField *staPreField;
//    UITextField *endPreField;
//    UITextField *otherField;
//    
//    NSString *selectedRow;
//    NSArray *gasArr;
//    NSArray *firstRow;
//    NSArray *secondRow;
//    NSArray *thirdRow;
//    NSArray *forthRow;
//    NSArray *mAndf;
//    NSArray *cAndf;
    
    AppDelegate *delegate;
    LogRecordViewController *logRecordViewController;
    //LogOptionsViewController *logOptionsViewController;
    GISViewController *gisViewController;
    PhotoViewController *photoViewController;
    SignatureViewController *signatureViewController;
    
}


@end

@implementation LogViewController

@synthesize managedObjectContext,scrollView,secondRow,selectedRow,siteField,siteLabel,staPreField,staPrelabel,dateField,dateLabel,divetimeField,divetimeLabel,wavesField,wavesLabel,currentField,currentLabel,mAndf,maxDepField,maxDepLabel,temperField,temperLabel,thirdRow,visiField,visiLabel,otherField,otherLabel,gasArr,gasField,gasLabel,dateFromData,wavesFromData,currentFromData,timeFromData,selectedImagePresent,signaturePresent,wavesArr,currentArr;


-(void)saveToData:(id)sender
{
    if (selectedImagePresent.image == nil && signaturePresent.image == nil) {
        NSString *dateStr = dateField.text;
        NSLog(@"%@",dateStr);
        
        
        NSString *site = siteField.text;
        
        
        
        NSString *waves = wavesField.text;
        
        
        NSString *current= currentField.text;
        
        
        
        NSString *maxDepth = maxDepField.text;
        
        
        NSString *gasType = gasField.text;
        
        
        NSString *diveTime = divetimeField.text;
        NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
        [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
        
        
        NSString *visibility = visiField.text;
        
        
        NSString *temperature = temperField.text;
        
        
        NSString *startPressure = staPreField.text;
        //    NSNumberFormatter *startPressureFormatter = [[NSNumberFormatter alloc] init];
        //    [startPressureFormatter setNumberStyle:NSNumberFormatterNoStyle];
        //    NSNumber *_startPressure = [startPressureFormatter numberFromString:startPressure];
        
        
        NSString *endPressure = _endPreField.text;
        //    NSNumberFormatter *endPressureFormatter = [[NSNumberFormatter alloc] init];
        //    [endPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        //    NSNumber *_endPressure = [endPressureFormatter numberFromString:endPressure];
        dateField.text = nil;
        siteField.text = nil;
        wavesField.text = nil;
        currentField.text = nil;
        maxDepField.text = nil;
        gasField.text = nil;
        divetimeField.text = nil;
        visiField.text = nil;
        temperField.text = nil;
        staPreField.text = nil;
        _endPreField.text = nil;
        
        DIVELOG *database = (DIVELOG *)[NSEntityDescription insertNewObjectForEntityForName:@"DIVELOG" inManagedObjectContext:managedObjectContext ];
        
        database.date = dateStr;
        database.site = site;
        database.waves = waves;
        database.current = current;
        database.max_depth = maxDepth;
        database.gas_type = gasType;
        database.dive_time = _diveTime;
        database.visibility = visibility;
        database.temperature = temperature;
        database.start_pressure = startPressure;
        database.end_pressure = endPressure;
        
        
        
        NSError *error;
        if (![managedObjectContext save:&error]) {
            NSLog(@"error:%@", [error localizedFailureReason]);
        }
        
       
        
        //[delegate.navi pushViewController:logRecordViewController animated:YES];
        [delegate.navi pushViewController:gisViewController animated:YES];

    }else if(signaturePresent.image == nil){
        
        NSString *dateStr = dateField.text;
        NSLog(@"%@",dateStr);
        
        
        NSString *site = siteField.text;
        
        
        
        NSString *waves = wavesField.text;
        
        
        NSString *current= currentField.text;
        
        
        
        NSString *maxDepth = maxDepField.text;
        
        
        NSString *gasType = gasField.text;
        
        
        NSString *diveTime = divetimeField.text;
        NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
        [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
        
        
        NSString *visibility = visiField.text;
        
        
        NSString *temperature = temperField.text;
        
        
        NSString *startPressure = staPreField.text;
        //    NSNumberFormatter *startPressureFormatter = [[NSNumberFormatter alloc] init];
        //    [startPressureFormatter setNumberStyle:NSNumberFormatterNoStyle];
        //    NSNumber *_startPressure = [startPressureFormatter numberFromString:startPressure];
        
        
        NSString *endPressure = _endPreField.text;
        //    NSNumberFormatter *endPressureFormatter = [[NSNumberFormatter alloc] init];
        //    [endPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        //    NSNumber *_endPressure = [endPressureFormatter numberFromString:endPressure];
        
        NSData *imgData = [NSData dataWithData:UIImagePNGRepresentation(selectedImagePresent.image)];
        
        dateField.text = nil;
        siteField.text = nil;
        wavesField.text = nil;
        currentField.text = nil;
        maxDepField.text = nil;
        gasField.text = nil;
        divetimeField.text = nil;
        visiField.text = nil;
        temperField.text = nil;
        staPreField.text = nil;
        _endPreField.text = nil;
        selectedImagePresent.image = nil;
        delegate.selectedCellImage = nil;

        
        DIVELOG *database = (DIVELOG *)[NSEntityDescription insertNewObjectForEntityForName:@"DIVELOG" inManagedObjectContext:managedObjectContext ];
        
        database.date = dateStr;
        database.site = site;
        database.waves = waves;
        database.current = current;
        database.max_depth = maxDepth;
        database.gas_type = gasType;
        database.dive_time = _diveTime;
        database.visibility = visibility;
        database.temperature = temperature;
        database.start_pressure = startPressure;
        database.end_pressure = endPressure;
        database.others = imgData;
        
        
        NSError *error;
        if (![managedObjectContext save:&error]) {
            NSLog(@"error:%@", [error localizedFailureReason]);
        }
        
        NSLog(@"image selected");
        
        //[delegate.navi pushViewController:logRecordViewController animated:YES];
        [delegate.navi pushViewController:gisViewController animated:YES];
        
    }else if (selectedImagePresent.image == nil){
        NSString *dateStr = dateField.text;
        NSLog(@"%@",dateStr);
        
        
        NSString *site = siteField.text;
        
        
        
        NSString *waves = wavesField.text;
        
        
        NSString *curret= currentField.text;
        
        
        
        NSString *maxDepth = maxDepField.text;
        
        
        NSString *gasType = gasField.text;
        
        
        NSString *diveTime = divetimeField.text;
        NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
        [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
        
        
        NSString *visibility = visiField.text;
        
        
        NSString *temperature = temperField.text;
        
        
        NSString *startPressure = staPreField.text;
        //    NSNumberFormatter *startPressureFormatter = [[NSNumberFormatter alloc] init];
        //    [startPressureFormatter setNumberStyle:NSNumberFormatterNoStyle];
        //    NSNumber *_startPressure = [startPressureFormatter numberFromString:startPressure];
        
        
        NSString *endPressure = _endPreField.text;
        //    NSNumberFormatter *endPressureFormatter = [[NSNumberFormatter alloc] init];
        //    [endPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        //    NSNumber *_endPressure = [endPressureFormatter numberFromString:endPressure];
        
        NSData *signData = [NSData dataWithData:UIImagePNGRepresentation(signaturePresent.image)];
        
        dateField.text = nil;
        siteField.text = nil;
        wavesField.text = nil;
        currentField.text = nil;
        maxDepField.text = nil;
        gasField.text = nil;
        divetimeField.text = nil;
        visiField.text = nil;
        temperField.text = nil;
        staPreField.text = nil;
        _endPreField.text = nil;
        signaturePresent.image = nil;
        delegate.signatureImage = nil;
        
        DIVELOG *database = (DIVELOG *)[NSEntityDescription insertNewObjectForEntityForName:@"DIVELOG" inManagedObjectContext:managedObjectContext ];
        
        database.date = dateStr;
        database.site = site;
        database.waves = waves;
        database.current = curret;
        database.max_depth = maxDepth;
        database.gas_type = gasType;
        database.dive_time = _diveTime;
        database.visibility = visibility;
        database.temperature = temperature;
        database.start_pressure = startPressure;
        database.end_pressure = endPressure;
        database.signature = signData;
        
        
        NSError *error;
        if (![managedObjectContext save:&error]) {
            NSLog(@"error:%@", [error localizedFailureReason]);
        }
        
        NSLog(@"sign");
        
        //[delegate.navi pushViewController:logRecordViewController animated:YES];
        [delegate.navi pushViewController:gisViewController animated:YES];
    }else{
        
        NSString *dateStr = dateField.text;
        NSLog(@"%@",dateStr);
        
        
        NSString *site = siteField.text;
        
        
        
        NSString *waves = wavesField.text;
        
        
        NSString *current= currentField.text;
        
        
        
        NSString *maxDepth = maxDepField.text;
        
        
        NSString *gasType = gasField.text;
        
        
        NSString *diveTime = divetimeField.text;
        NSNumberFormatter *diveTimeFormatter = [[NSNumberFormatter alloc] init];
        [diveTimeFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *_diveTime = [diveTimeFormatter numberFromString:diveTime];
        
        
        NSString *visibility = visiField.text;
        
        
        NSString *temperature = temperField.text;
        
        
        NSString *startPressure = staPreField.text;
        //    NSNumberFormatter *startPressureFormatter = [[NSNumberFormatter alloc] init];
        //    [startPressureFormatter setNumberStyle:NSNumberFormatterNoStyle];
        //    NSNumber *_startPressure = [startPressureFormatter numberFromString:startPressure];
        
        
        NSString *endPressure = _endPreField.text;
        //    NSNumberFormatter *endPressureFormatter = [[NSNumberFormatter alloc] init];
        //    [endPressureFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        //    NSNumber *_endPressure = [endPressureFormatter numberFromString:endPressure];
        NSData *imgData = [NSData dataWithData:UIImagePNGRepresentation(selectedImagePresent.image)];
        NSData *signData = [NSData dataWithData:UIImagePNGRepresentation(signaturePresent.image)];
        
        dateField.text = nil;
        siteField.text = nil;
        wavesField.text = nil;
        currentField.text = nil;
        maxDepField.text = nil;
        gasField.text = nil;
        divetimeField.text = nil;
        visiField.text = nil;
        temperField.text = nil;
        staPreField.text = nil;
        _endPreField.text = nil;
        selectedImagePresent.image = nil;
        delegate.selectedCellImage = nil;
        signaturePresent.image = nil;
        delegate.signatureImage = nil;
        
        DIVELOG *database = (DIVELOG *)[NSEntityDescription insertNewObjectForEntityForName:@"DIVELOG" inManagedObjectContext:managedObjectContext ];
        
        database.date = dateStr;
        database.site = site;
        database.waves = waves;
        database.current = current;
        database.max_depth = maxDepth;
        database.gas_type = gasType;
        database.dive_time = _diveTime;
        database.visibility = visibility;
        database.temperature = temperature;
        database.start_pressure = startPressure;
        database.end_pressure = endPressure;
        database.others = imgData;
        database.signature = signData;
        
        
        NSError *error;
        if (![managedObjectContext save:&error]) {
            NSLog(@"error:%@", [error localizedFailureReason]);
        }
        
        NSLog(@"image selected and sign");
        
        //[delegate.navi pushViewController:logRecordViewController animated:YES];
        [delegate.navi pushViewController:gisViewController animated:YES];
    }
    
    
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
    }else if (aPickerView.tag == 207){
        return 1;
    }else if (aPickerView.tag == 208){
        return 1;
    }

    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 201) {
        return [gasArr count];
    }else if (pickerView.tag == 202){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (pickerView.tag == 203){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }
    }else if (pickerView.tag == 204){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [_forthRow count];
        }else if (component == 4){
            return [mAndf count];
        }

    }else if (pickerView.tag == 205){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [_forthRow count];
        }else if (component == 4){
            return [_cAndf count];
        }
    }else if (pickerView.tag == 206){
        if (component == 0) {
            return [_firstRow count];
        }else if (component == 1){
            return [secondRow count];
        }else if (component == 2){
            return [thirdRow count];
        }else if (component == 3){
            return [mAndf count];
        }
        
    }else if (pickerView.tag == 207){
        return [wavesArr count];
    }else if (pickerView.tag == 208){
        return [currentArr count];
    }

    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 201) {
        return [gasArr objectAtIndex:row];
    }else if (pickerView.tag == 202){
        if (component == 0) {
            return [_firstRow objectAtIndex:row];
        }else if (component == 1){
            return [secondRow objectAtIndex:row];
        }else if (component == 2){
            return [thirdRow objectAtIndex:row];
        }
    }else if (pickerView.tag == 203){
        if (component == 0) {
            return [_firstRow objectAtIndex:row];
        }else if (component == 1){
            return [secondRow objectAtIndex:row];
        }else if (component == 2){
            return [thirdRow objectAtIndex:row];
        }
    }else if (pickerView.tag == 204){
        if (component == 0) {
            return [_firstRow objectAtIndex:row];
        }else if (component == 1){
            return [secondRow objectAtIndex:row];
        }else if (component == 2){
            return [thirdRow objectAtIndex:row];
        }else if (component == 3){
            return [_forthRow objectAtIndex:row];
        }else if (component == 4){
            return [mAndf objectAtIndex:row];
        }
    }else if (pickerView.tag == 205){
        if (component == 0) {
            return [_firstRow objectAtIndex:row];
        }else if (component == 1){
            return [secondRow objectAtIndex:row];
        }else if (component == 2){
            return [thirdRow objectAtIndex:row];
        }else if (component == 3){
            return [_forthRow objectAtIndex:row];
        }else if (component == 4){
            return [_cAndf objectAtIndex:row];
        }
    }else if (pickerView.tag == 206){
        if (component == 0) {
            return [_firstRow objectAtIndex:row];
        }else if (component == 1){
            return [secondRow objectAtIndex:row];
        }else if (component == 2){
            return [thirdRow objectAtIndex:row];
        }else if (component == 3){
            return [mAndf objectAtIndex:row];
        }
    }else if (pickerView.tag == 207){
        return [wavesArr objectAtIndex:row];
    }else if (pickerView.tag == 208){
        return [currentArr objectAtIndex:row];
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
        staPreField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (pickerView.tag == 203){
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        NSInteger row3 = [pickerView selectedRowInComponent:2];
        _endPreField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
    }else if (pickerView.tag == 204){
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        NSInteger row3 = [pickerView selectedRowInComponent:2];
        NSInteger row4 = [pickerView selectedRowInComponent:3];
        NSInteger row5 = [pickerView selectedRowInComponent:4];
        maxDepField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[mAndf objectAtIndex:row5]];
    }else if (pickerView.tag == 205){
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        NSInteger row3 = [pickerView selectedRowInComponent:2];
        NSInteger row4 = [pickerView selectedRowInComponent:3];
        NSInteger row5 = [pickerView selectedRowInComponent:4];
        temperField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[_cAndf objectAtIndex:row5]];
    }else if (pickerView.tag == 206){
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        NSInteger row3 = [pickerView selectedRowInComponent:2];
        NSInteger row4 = [pickerView selectedRowInComponent:3];
        visiField.text = [NSString stringWithFormat:@"%@%@%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[mAndf objectAtIndex:row4]];
    }else if (pickerView.tag == 207){
        NSInteger row = [pickerView selectedRowInComponent:0];
        selectedRow = [wavesArr objectAtIndex:row];
        wavesField.text = selectedRow;
    }else if (pickerView.tag == 208){
        NSInteger row = [pickerView selectedRowInComponent:0];
        selectedRow = [currentArr objectAtIndex:row];
        currentField.text = selectedRow;
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
        
        UIPickerView *wavePicker = [[UIPickerView alloc] init];
        wavePicker.delegate = self;
        wavePicker.dataSource = self;
        wavePicker.showsSelectionIndicator = YES;
        [wavePicker setFrame:CGRectMake(0, 480, 320, 180)];
        
        [wavePicker setTag:207];
        
        aTextField.inputView = wavePicker;
        NSInteger row = [wavePicker selectedRowInComponent:0];
        aTextField.text = [wavesArr objectAtIndex:row];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
    }else if (aTextField.tag == 104){
        
        UIPickerView *currentPicker = [[UIPickerView alloc] init];
        currentPicker.delegate = self;
        currentPicker.dataSource = self;
        currentPicker.showsSelectionIndicator = YES;
        [currentPicker setFrame:CGRectMake(0, 480, 320, 180)];
        
        [currentPicker setTag:208];
        
        aTextField.inputView = currentPicker;
        NSInteger row = [currentPicker selectedRowInComponent:0];
        aTextField.text = [currentArr objectAtIndex:row];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;
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
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
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
        aTextField.text = [NSString stringWithFormat:@"%@ %@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3]];
        
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
        aTextField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[mAndf objectAtIndex:row5]];
        
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
        aTextField.text = [NSString stringWithFormat:@"%@%@%@.%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[_forthRow objectAtIndex:row4],[_cAndf objectAtIndex:row5]];
        
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
        aTextField.text = [NSString stringWithFormat:@"%@%@%@ %@",[_firstRow objectAtIndex:row1],[secondRow objectAtIndex:row2],[thirdRow objectAtIndex:row3],[mAndf objectAtIndex:row4]];
        
        UIToolbar *cancelBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePicking:)];
        cancelBar.items = [NSArray arrayWithObject:right];
        aTextField.inputAccessoryView = cancelBar;

    }else if (aTextField.tag == 111){
        
        aTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        aTextField.returnKeyType = UIReturnKeyDone;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ((dateField.text.length > 0) && (wavesField.text.length > 0) && (currentField.text.length > 0)
        && (gasField.text.length > 0) && (staPreField.text.length > 0) &&
        (_endPreField.text.length > 0) && (maxDepField.text.length > 0) && (divetimeField.text.length >0) && (temperField.text.length > 0) && (visiField.text.length > 0)) {
               self.navigationItem.rightBarButtonItem.enabled = YES;
            }
            else{
        
                self.navigationItem.rightBarButtonItem.enabled = NO;
                
            }

}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
////    if (dateField.text.length == 0||  latField.text.length == 0 || lonField.text.length == 0 || gasField.text.length == 0 || staPreField.text.length == 0 || endPreField.text.length == 0 || maxDepField.text.length == 0 || divetimeField.text.length == 0 || temperField.text.length == 0 || visiField.text.length == 0) {
////        
////        self.navigationItem.rightBarButtonItem.enabled = NO;
////    }
//    if ((latField.text.length > 0) && (lonField.text.length > 0)) {
//        self.navigationItem.rightBarButtonItem.enabled = YES;
//    }
//    else{
//    
//        self.navigationItem.rightBarButtonItem.enabled = NO;
//    }
//    return YES;
//}

-(void)textAndLabel
{
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 88, 80, 21)];
    [dateLabel setText:@"日期"];
    [scrollView addSubview:dateLabel];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(130, 85, 97, 30)];
    [dateField setTag:101];
    dateField.delegate = self;
    dateField.placeholder = @"YYYY-mm-dd";
    dateField.borderStyle = UITextBorderStyleRoundedRect;
    dateField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:dateField];
    
    siteLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 154, 80, 21)];
    [siteLabel setText:@"潛點"];
    [scrollView addSubview:siteLabel];
    
    siteField = [[UITextField alloc] initWithFrame:CGRectMake(130, 151, 97, 30)];
    [siteField setTag:102];
    siteField.delegate = self;
    siteField.placeholder = @"Site Name";
    siteField.borderStyle = UITextBorderStyleRoundedRect;
    siteField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:siteField];
    
    wavesLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 220, 100, 21)];
    [wavesLabel setText:@"浪況"];
    [scrollView addSubview:wavesLabel];
    
    wavesField = [[UITextField alloc] initWithFrame:CGRectMake(130, 217, 97, 30)];
    [wavesField setTag:103];
    wavesField.delegate = self;
    //wavesField.placeholder = @"25.061033";
    wavesField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:wavesField];
    
    currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 286, 100, 21)];
    [currentLabel setText:@"水流"];
    [scrollView addSubview:currentLabel];
    
    currentField = [[UITextField alloc] initWithFrame:CGRectMake(130, 283, 97, 30)];
    [currentField setTag:104];
    currentField.delegate = self;
    //currentField.placeholder = @"121.646056";
    currentField.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:currentField];
    
    gasLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 352, 100, 21)];
    [gasLabel setText:@"氣源"];
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
    
    _endPreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 494, 200, 21)];
    [_endPreLabel setText:@"End Pressure"];
    [scrollView addSubview:_endPreLabel];
    
    _endPreField = [[UITextField alloc] initWithFrame:CGRectMake(130, 491, 97, 30)];
    [_endPreField setTag:107];
    _endPreField.delegate = self;
    _endPreField.placeholder = @"60 bar";
    _endPreField.borderStyle = UITextBorderStyleRoundedRect;
    _endPreField.adjustsFontSizeToFitWidth = YES;
    _endPreField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:_endPreField];
    
    maxDepLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 560, 100, 21)];
    [maxDepLabel setText:@"最大深度"];
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
    [divetimeLabel setText:@"潛水時間"];
    [scrollView addSubview:divetimeLabel];
    
    divetimeField = [[UITextField alloc] initWithFrame:CGRectMake(130, 623, 97, 30)];
    [divetimeField setTag:111];
    divetimeField.delegate = self;
    divetimeField.placeholder = @"in minutes";
    divetimeField.borderStyle = UITextBorderStyleRoundedRect;
    divetimeField.adjustsFontSizeToFitWidth = YES;
    divetimeField.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:divetimeField];
    
    temperLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 692, 100, 21)];
    [temperLabel setText:@"水溫"];
    [scrollView addSubview:temperLabel];
    
    temperField = [[UITextField alloc] initWithFrame:CGRectMake(130, 689, 97, 30)];
    [temperField setTag:109];
    temperField.delegate = self;
    temperField.placeholder = @"";
    temperField.borderStyle = UITextBorderStyleRoundedRect;
    temperField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:temperField];
    
    visiLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 758, 100, 21)];
    [visiLabel setText:@"能見度"];
    [scrollView addSubview:visiLabel];
    
    visiField = [[UITextField alloc] initWithFrame:CGRectMake(130, 755, 97, 30)];
    [visiField setTag:110];
    visiField.delegate = self;
    visiField.placeholder = @"15M";
    visiField.borderStyle = UITextBorderStyleRoundedRect;
    visiField.adjustsFontSizeToFitWidth = YES;
    [scrollView addSubview:visiField];
    


}

//-(void)loadFromGIS:(id)sender
//{
//    UINavigationController *toTable = [[UINavigationController alloc] initWithRootViewController:logOptionsViewController];
//    toTable.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    [self presentViewController:toTable animated:YES completion:^{
//        NULL;
//        
//    }];
//
//}

-(void)loadPhoto:(id)sender
{
    
    [delegate.navi pushViewController:photoViewController animated:YES];
}

-(void)partnerSingnature:(id)sender
{
    if (signaturePresent.image != nil) {
        [delegate.navi pushViewController:signatureViewController animated:YES];
        signaturePresent.image = nil;
    }else{
        
        [delegate.navi pushViewController:signatureViewController animated:YES];
    }
    
    
}

-(void)loadView
{
    [super loadView];
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1500);
    [self.view addSubview:scrollView];
    
    [self textAndLabel];
    
    gasArr = [NSArray arrayWithObjects:@"Normal Air",@"Nitrox",@"Closed Circuit",@"Surface Supplied", nil];
    _firstRow = [NSArray arrayWithObjects:@" ",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    secondRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    thirdRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    _forthRow = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    mAndf = [NSArray arrayWithObjects:@"m",@"ft", nil];
    _cAndf = [NSArray arrayWithObjects:@"°C",@"°F", nil];
    
    wavesArr = [NSArray arrayWithObjects:@"平",@"小",@"中",@"大", nil];
    currentArr = [NSArray arrayWithObjects:@"有",@"無", nil];
    
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveToData:)];
    self.navigationItem.rightBarButtonItem = save;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UIButton *load = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [load setTitle:@"Load" forState:UIControlStateNormal];
    load.frame = CGRectMake(scrollView.center.x-25, 810, 50, 40);
    [load addTarget:self action:@selector(loadPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:load];
    
    UIButton *singnature = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [singnature setTitle:@"潛伴簽名" forState:UIControlStateNormal];
    singnature.frame = CGRectMake(scrollView.center.x-50, selectedImagePresent.frame.origin.y+1070, 100, 50);
    [singnature addTarget:self action:@selector(partnerSingnature:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:singnature];
    
    delegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = delegate.context;
    
    logRecordViewController = [[LogRecordViewController alloc] init];
//    logOptionsViewController = [[LogOptionsViewController alloc] init];
//    logOptionsViewController.delegate = self;
    gisViewController = [[GISViewController alloc] init];
    photoViewController = [[PhotoViewController alloc] init];
    signatureViewController = [[SignatureViewController alloc] init];
//    UIBarButtonItem *toLogRecord = [[UIBarButtonItem alloc] initWithTitle:@"Log" style:UIBarButtonItemStyleBordered target:self action:@selector(toLogRecord:)];
//    NSArray *barButtonArr = [NSArray arrayWithObjects:save,toLogRecord, nil];
    //self.navigationItem.rightBarButtonItems = barButtonArr;
    //self.navigationItem.hidesBackButton = YES;
}


//-(void)didSelectDate:(NSString *)aCellData latitude:(NSString *)bCellData lontitude:(NSString *)cCellData time:(NSString *)dCelldata
//{
//    /*first, establish a class that contain data from database and display in table; second, insert the table into alertview, then set up alert view in tableview class and assign it to another alrtview which establish in this class; third, build a delegate protocal in table view class so that it can contain and pass value to this class; finally, use the method that create in table class delegate to pass the text value to this class's textfield*/
//    
//    dateFromData = aCellData;
//    latFromData = bCellData;
//    lonFromData = cCellData;
//    timeFromData = dCelldata;
//    
//    dateField.text = dateFromData;
//    latField.text = latFromData;
//    lonField.text = lonFromData;
//    divetimeField.text = timeFromData ;
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self presentSelectImage];
    [self presentSignature];
    


}

-(void)presentSelectImage
{
    selectedImagePresent = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.center.x-100, 864, 200, 200)];
    selectedImagePresent.image =//[UIImage imageNamed:[delegate.selectedDictionary objectForKey:@"AlAssetPropertyURLs"]];
    delegate.selectedCellImage;
    [scrollView addSubview:selectedImagePresent];
}

-(void)presentSignature
{
    signaturePresent = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.center.x-200, 1080, 400, 300)];
    if (delegate.signatureImage == nil) {
        NSLog(@"no image");
    }
    signaturePresent.image = delegate.signatureImage;
    [scrollView addSubview:signaturePresent];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
