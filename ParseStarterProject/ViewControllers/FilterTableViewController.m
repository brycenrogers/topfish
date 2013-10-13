//
//  FilterTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 10/12/13.
//
//

#import "FilterTableViewController.h"
#import "SpeciesListTableViewController.h"

@interface FilterTableViewController ()

@end

@implementation FilterTableViewController

@synthesize delegate, selectedSpeciesLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSpeciesList {
    [self performSegueWithIdentifier:@"showSpeciesList" sender:nil];
}

- (void)showMethodList {
    [self performSegueWithIdentifier:@"showMethodListFromFilter" sender:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self showMethodList];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self showSpeciesList];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSpeciesList"])
    {
        SpeciesListTableViewController *speciesList = [segue destinationViewController];
        speciesList.delegate = self;
    }
    
    if ([[segue identifier] isEqualToString:@"showMethodListFromFilter"])
    {
        MethodListTableViewController *methodList = [segue destinationViewController];
        methodList.delegate = self;
    }
}

@end
