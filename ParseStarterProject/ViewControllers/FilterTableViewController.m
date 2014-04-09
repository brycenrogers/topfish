//
//  FilterTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 10/12/13.
//
//

#import "FilterTableViewController.h"
#import "SpeciesListTableViewController.h"
#import "LeaderboardTableViewController.h"

@interface FilterTableViewController ()

@end

@implementation FilterTableViewController

@synthesize delegate, selectedSpeciesLabel, selectedMethodLabel, allMethodsSwitch, allSpeciesSwitch;

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
    [self.allMethodsSwitch addTarget:self action:@selector(allMethodsSwitched) forControlEvents:UIControlEventValueChanged];
    [self.allSpeciesSwitch addTarget:self action:@selector(allSpeciesSwitched) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.delegate.selectedMethodFilter != nil) {
        self.selectedMethodLabel.text = self.delegate.selectedMethodFilter;
        self.selectedMethodLabel.textColor = [UIColor blackColor];
        self.allMethodsSwitch.on = NO;
    }
    
    if (self.delegate.selectedSpeciesFilter != nil) {
        self.selectedSpeciesLabel.text = self.delegate.selectedSpeciesFilter;
        self.selectedSpeciesLabel.textColor = [UIColor blackColor];
        self.allSpeciesSwitch.on = NO;
    }
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

- (void)applyFilter {
    LeaderboardTableViewController *leaderboardTVC = (LeaderboardTableViewController *)self.delegate;
    if ([selectedSpeciesLabel.text isEqualToString:@"Filter by Species"]) {
        leaderboardTVC.selectedSpeciesFilter = nil;
        [leaderboardTVC setFilterButtonColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    } else {
        leaderboardTVC.selectedSpeciesFilter = self.selectedSpeciesLabel.text;
        [leaderboardTVC setFilterButtonColor:[UIColor colorWithRed:(22.0f/255.0f) green:(159.0f/255.0f) blue:(46.0f/255.0f) alpha:0.75f]];
    }
    if ([selectedMethodLabel.text isEqualToString:@"Filter by Method"]) {
        leaderboardTVC.selectedMethodFilter = nil;
        if ([selectedSpeciesLabel.text isEqualToString:@"Filter by Species"]) {
            [leaderboardTVC setFilterButtonColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
        } else {
            [leaderboardTVC setFilterButtonColor:[UIColor colorWithRed:(22.0f/255.0f) green:(159.0f/255.0f) blue:(46.0f/255.0f) alpha:0.75f]];
        }
    } else {
        leaderboardTVC.selectedMethodFilter = self.selectedMethodLabel.text;
        [leaderboardTVC setFilterButtonColor:[UIColor colorWithRed:(22.0f/255.0f) green:(159.0f/255.0f) blue:(46.0f/255.0f) alpha:0.75f]];
    }
    [leaderboardTVC loadObjects];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        if (self.allMethodsSwitch.on) {
            [self.allMethodsSwitch setOn:NO animated:YES];
        }
        self.delegate.selectedMethodFilter = nil;
        [self showMethodList];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        if (self.allSpeciesSwitch.on) {
            [self.allSpeciesSwitch setOn:NO animated:YES];
        }
        self.delegate.selectedSpeciesFilter = nil;
        [self showSpeciesList];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self applyFilter];
    }
    if (indexPath.section == 3 && indexPath.row == 0) {
        [self clearAllFilters];
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

- (void)allMethodsSwitched {
    if (self.allMethodsSwitch.on) {
        self.selectedMethodLabel.text = @"Filter by Method";
    }
}

- (void)allSpeciesSwitched {
    if (self.allSpeciesSwitch.on) {
        self.selectedSpeciesLabel.text = @"Filter by Species";
    }
}

- (void)clearAllFilters {
    self.selectedSpeciesLabel.text = @"Filter by Species";
    self.allSpeciesSwitch.on = YES;
    self.selectedMethodLabel.text = @"Filter by Method";
    self.allMethodsSwitch.on = YES;
    [self applyFilter];
}

@end
