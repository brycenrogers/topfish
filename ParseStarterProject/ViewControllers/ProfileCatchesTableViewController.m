//
//  ProfileCatchesTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 8/11/13.
//
//

#import "ProfileCatchesTableViewController.h"
#import <Parse/Parse.h>
#import "Catch.h"

@interface ProfileCatchesTableViewController ()

@end

@implementation ProfileCatchesTableViewController

@synthesize catches, catchesTable;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(pullRefreshTable) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    [self.catchesTable headerViewForSection:1];
    
    [self fetchCatchesData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pullRefreshTable {
    [self fetchCatchesData];
    [self.refreshControl endRefreshing];
}

#pragma mark - Setup Table data

- (void)fetchCatchesData {
    self.catches = [NSMutableArray array];
    PFQuery *query = [Catch query];
    [query whereKey:@"user" equalTo:PFUser.currentUser];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (int i = 0; i < objects.count; i++) {
                [self.catches addObject:[objects objectAtIndex:i]];
            }
            [self.catchesTable reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.catches count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.catches count] == 0) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier
                             forIndexPath:indexPath];
    if (nil == cell){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.catches objectAtIndex:indexPath.row] name];
    
    cell.detailTextLabel.text = [NSString
                                 stringWithFormat:@"Length - %1.2d, Weight - %1.2d",
                                 [[self.catches objectAtIndex:indexPath.row] length],
                                 [[self.catches objectAtIndex:indexPath.row] weight]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Catches";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // Navigation logic may go here. Create and push another view controller.
//    
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc]
//                                                       initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
