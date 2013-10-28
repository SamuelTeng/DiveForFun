//
//  LogOptionsViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/8/23.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "LogOptionsViewController.h"
#import "GISDATA.h"
#import "AppDelegate.h"
#import "LogViewController.h"

@implementation ViewCover
@synthesize alert;

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

@end



@interface LogOptionsViewController (){
    
    AppDelegate *aDelegate;
    LogViewController *logViewController;
}

@property (nonatomic,strong) NSFetchedResultsController *resultController;

@end

@implementation LogOptionsViewController
@synthesize dateStr,latArr,lonArr,timeArr,resultController,aDateStr,bLatData,cLonData,dTimeData;


//-(void)loadFromTable
//{
//  
//    options = [[UIAlertView alloc] initWithTitle:@"Choose one to load" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:NULL, nil];
//
//    UITableView *fromGis = self.tableView;
//    fromGis.frame = CGRectZero;
//
//    [options addSubview:self.tableView];
//    [options show];
//    //[self dimissAlertView];
//
//    
//    
//}

-(void)fetchData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"GISDATA" inManagedObjectContext:aDelegate.context]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:descriptors];
    
    NSError *error;
    resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:aDelegate.context sectionNameKeyPath:@"date" cacheName:nil];
    
    if (![resultController performFetch:&error]) {
        NSLog(@"error : %@", [error localizedFailureReason]);
    }
}

//-(void)dimissAlertView
//{
//    ViewCover *cover = [[ViewCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    cover.userInteractionEnabled = YES;
//    cover.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.01];
//    cover.alert = options;
//    options = [[UIAlertView alloc] initWithTitle:@"Choose one to load" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:NULL, nil];
//    UITableView *fromGis = self.tableView;
//    [fromGis addSubview:cover];
//    fromGis.frame = CGRectZero;
//    [options addSubview:fromGis];
//    //[options addSubview:cover];
//    [options show];
//    //[[cover superview] sendSubviewToBack:cover];
//}

-(void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        NULL;
    }];
}

-(void)loadView
{
    [super loadView];
    aDelegate = [[UIApplication sharedApplication] delegate];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchData];
    
    UIBarButtonItem *goBack = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = goBack;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self dimissAlertView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [[resultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[resultController sections] objectAtIndex:section] numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basic cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"basic cell"];
    }
    
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexPath];
    NSDate *dataTime = [managedObject valueForKey:@"date"];
    NSDateFormatter *toString = [[NSDateFormatter alloc] init];
    [toString setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateStr = [toString stringFromDate:dataTime];
    cell.textLabel.text = dateStr;
    
    // Configure the cell...
    
    return cell;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSManagedObject *managedObject = [resultController objectAtIndexPath:indexPath];
    latArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"latitude"]];
    lonArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"lontitude"]];

    timeArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"timestamp"]];
    NSDate *dataTime = [managedObject valueForKey:@"date"];
    NSDateFormatter *toString = [[NSDateFormatter alloc] init];
    [toString setDateFormat:@"yyyy-MM-dd"];
    aDateStr = [toString stringFromDate:dataTime];
    bLatData = latArr[0];
    cLonData = lonArr[0];
    
    NSString *begin = timeArr[0];
    NSDateFormatter *_begin = [[NSDateFormatter alloc] init];
    [_begin setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *diveBegin = [_begin dateFromString:begin];
    
    NSString *finish = [timeArr lastObject];
    NSDateFormatter *_finish = [[NSDateFormatter alloc] init];
    [_finish setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *diveFinish = [_finish dateFromString:finish];
    
    NSTimeInterval diveTime = [diveFinish timeIntervalSinceDate:diveBegin];
    double minutes = diveTime/60;
    int _minutes = floor(minutes);
    dTimeData = [NSString stringWithFormat:@"%i",_minutes];
    [self.delegate didSelectDate:aDateStr latitude:bLatData lontitude:cLonData time:dTimeData];
    
    [self dismissViewControllerAnimated:YES completion:^{
        NULL;
    }];
}




@end
