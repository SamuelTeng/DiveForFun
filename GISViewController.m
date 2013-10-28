//
//  GISViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/6/21.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "GISViewController.h"
#import "AppDelegate.h"
#import "GISDATA.h"
#import "RoutingViewController.h"
#import "RouteViewController.h"
#import "DIVELOG.h"
#import "LogShoViewController.h"

@interface GISViewController (){
    AppDelegate *delegate;
    GISDATA *database;
    DIVELOG *logDataBase;
    RouteViewController *routeViewController;
    RoutingViewController *routingViewController;
    LogShoViewController *logShowViewController;
    //NSFetchedResultsController *resultController;
}
@property (nonatomic,strong) NSFetchedResultsController *resultController;
@end

@implementation GISViewController
@synthesize resultController;
@synthesize logViewController;

-(void)fetchData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"DIVELOG" inManagedObjectContext:delegate.context]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:descriptors];
    
    NSError *error;
    resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:delegate.context sectionNameKeyPath:@"date" cacheName:nil];
    resultController.delegate = self;
    if (![resultController performFetch:&error]) {
        NSLog(@"error : %@", [error localizedFailureReason]);
    }
}

-(void)toLog:(id)sender
{
    [delegate.navi pushViewController:routeViewController animated:YES];
    NSLog(@"table page");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {

            
        case 1:
            [delegate.navi pushViewController:logViewController animated:NO];
            break;
            
        default:
            break;
    }
}

//-(void)goBack:(id)sender
//{
//    [routingViewController.routeMap removeAnnotations:routingViewController.annotationsRemove];
//    NSLog(@"remove annotations");
//}

-(void)loadView
{
    [super loadView];
    
    delegate = [[UIApplication sharedApplication] delegate];
//    routeViewController = [[RouteViewController alloc] init];
//    routingViewController = [[RoutingViewController alloc] init];
    logShowViewController = [[LogShoViewController alloc] init];
    logViewController = [[LogViewController alloc] init];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toLogView:)];
    self.navigationItem.rightBarButtonItem = add;
    self.navigationItem.hidesBackButton = YES;
    
//    UIBarButtonItem *toLog = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(toLog:)];
//    self.navigationItem.leftBarButtonItem = toLog;
    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Table" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack:)];
//    self.navigationItem.backBarButtonItem = backButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchData];
    
    if (! resultController.fetchedObjects.count) {
        
        UIAlertView *noLogData = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"There are no logs. Press OK to add one or Cancel to leave." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [noLogData show];
        
        NSLog(@"No data at this moment");
        
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    int count = resultController.fetchedObjects.count;
    NSString *title = [NSString stringWithFormat:@"目前支數:%i", count];
    self.navigationItem.title = title;
    
}

-(void)viewDidUnload
{
    database = nil;
    routingViewController = nil;
    routeViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toLogView:(id)sender
{
    [delegate.navi pushViewController:logViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[resultController sections] count];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    //    NSArray *titles = [resultController sectionIndexTitles];
    //    if (titles.count <= section) {
    //        return @"Error";
    //    }
    //
    //    return [titles objectAtIndex:section];
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView
{
    //    return [resultController sectionIndexTitles];
    return nil;
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
        //    NSDate *dataTime = [managedObject valueForKey:@"date"];
        //    NSDateFormatter *toString = [[NSDateFormatter alloc] init];
        //    [toString setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //    NSString *timeStr = [toString stringFromDate:dataTime];
        NSString *timeStr = [managedObject valueForKey:@"date"];
        
        NSData *logImageData = [managedObject valueForKey:@"others"];
        
        if (logImageData == NULL) {
            cell.textLabel.text = timeStr;
        }else{
            
            cell.textLabel.text = timeStr;
            cell.imageView.image = [UIImage imageWithData:logImageData];
            
        }
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSError *error = nil;
        [delegate.context deleteObject:[resultController objectAtIndexPath:indexPath]];
        if (![delegate.context save:&error]) {
            NSLog(@"Error: %@", [error localizedFailureReason]);
        }
        
        [self fetchData];
    }   
 
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}


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
//    NSArray *latArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"latitude"]];
//    NSLog(@"latitude is %@", [latArr lastObject]);
//    NSArray *lonArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"lontitude"]];
//    NSArray *couArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"course"]];
//    NSArray *altArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"altitude"]];
//    NSArray *tsmArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"timestamp"]];
//    
//    delegate.latGIS = latArr;
//    delegate.lonGIS = lonArr;
//    delegate.altGIS = altArr;
//    delegate.courseGIS = couArr;
//    delegate.timeGIS = tsmArr;
    NSString *logDate = [managedObject valueForKey:@"date"];
    NSString *logSite = [managedObject valueForKey:@"site"];
    NSString *logTime = [managedObject valueForKey:@"dive_time"];
    NSString *logDepth = [managedObject valueForKey:@"max_depth"];
    NSString *logGas = [managedObject valueForKey:@"gas_type"];
    NSString *logVisibility = [managedObject valueForKey:@"visibility"];
    NSString *logTemperature = [managedObject valueForKey:@"temperature"];
    NSString *logStartPressure = [managedObject valueForKey:@"start_pressure"];
    NSString *logEndPressure = [managedObject valueForKey:@"end_pressure"];
    NSData *logImageData = [managedObject valueForKey:@"others"];
    NSData *logSignature = [managedObject valueForKey:@"signature"];
    
    delegate.date = logDate;
    delegate.site = logSite;
    delegate.timeOfDiving = logTime;
    delegate.airType = logGas;
    delegate.pressureOfStart = logStartPressure;
    delegate.pressureOfEnd = logEndPressure;
    delegate.maxiumDepth = logDepth;
    delegate.visibility = logVisibility;
    delegate.temperature = logTemperature;
    delegate.imageData = logImageData;
    delegate.signature = logSignature;
    
    UINavigationController *navLogViewController = [[UINavigationController alloc] initWithRootViewController:logShowViewController];
    
    navLogViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navLogViewController animated:YES completion:^{

        NULL;
       
    }];
}


@end
