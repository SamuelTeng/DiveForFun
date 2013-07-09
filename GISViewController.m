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

@interface GISViewController (){
    AppDelegate *delegate;
    GISDATA *database;
    RouteViewController *routeViewController;
    RoutingViewController *routingViewController;
    //NSFetchedResultsController *resultController;
}
@property (nonatomic,strong) NSFetchedResultsController *resultController;
@end

@implementation GISViewController
@synthesize resultController;

-(void)fetchData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"GISDATA" inManagedObjectContext:delegate.context]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:descriptors];
    
    NSError *error;
    resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:delegate.context sectionNameKeyPath:@"date" cacheName:nil];
    
    if (![resultController performFetch:&error]) {
        NSLog(@"error : %@", [error localizedFailureReason]);
    }
}

-(void)toMap:(id)sender
{
    [delegate.navi pushViewController:routeViewController animated:YES];
    NSLog(@"table page");
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
    routeViewController = [[RouteViewController alloc] init];
    routingViewController = [[RoutingViewController alloc] init];
    
    UIBarButtonItem *toMap = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStyleBordered target:self action:@selector(toMap:)];
    self.navigationItem.leftBarButtonItem = toMap;
    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Table" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack:)];
//    self.navigationItem.backBarButtonItem = backButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSDate *dataTime = [managedObject valueForKey:@"date"];
    NSDateFormatter *toString = [[NSDateFormatter alloc] init];
    [toString setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeStr = [toString stringFromDate:dataTime];
    cell.textLabel.text = timeStr;
    
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
    NSArray *latArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"latitude"]];
    NSLog(@"latitude is %@", [latArr lastObject]);
    NSArray *lonArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"lontitude"]];
    NSArray *couArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"course"]];
    NSArray *altArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"altitude"]];
    NSArray *tsmArr = [NSKeyedUnarchiver unarchiveObjectWithData:[managedObject valueForKey:@"timestamp"]];
    
    delegate.latGIS = latArr;
    delegate.lonGIS = lonArr;
    delegate.altGIS = altArr;
    delegate.courseGIS = couArr;
    delegate.timeGIS = tsmArr;
    

    
    [delegate.navi pushViewController:routingViewController animated:YES];
}


@end
