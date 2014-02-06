//
//  SpeciesListTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/22/13.
//
//

#import "SpeciesListTableViewController.h"
#import "SpeciesList.h"
#import "Fish.h"

@interface SpeciesListTableViewController ()

@end

@implementation SpeciesListTableViewController

@synthesize speciesList, delegate;

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

    self.tableView.delegate = self;
    speciesList = [SpeciesList getList];
    self.clearsSelectionOnViewWillAppear = NO;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return speciesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SpeciesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Fish *fish = [speciesList objectAtIndex:indexPath.row];
    cell.textLabel.text = fish.species;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fish *fish = [speciesList objectAtIndex:indexPath.row];
    
    NSArray *words = [fish.species componentsSeparatedByString:@", "];
    NSEnumerator *reversed = [words reverseObjectEnumerator];
    NSMutableString *speciesPhonetic = [[NSMutableString alloc] init];
    int i = 0;
    for (id obj in reversed) {
        if (i != 0) {
            [speciesPhonetic appendString:@" "];
        }
        [speciesPhonetic appendString:obj];
        i++;
    }
    
    self.delegate.selectedSpeciesLabel.text = speciesPhonetic;
    self.delegate.selectedSpeciesLabel.textColor = [UIColor blackColor];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
