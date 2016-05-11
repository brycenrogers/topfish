//
//  MethodListTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 10/12/13.
//
//

#import "MethodListTableViewController.h"
#import "MethodList.h"

@interface MethodListTableViewController ()

@end

@implementation MethodListTableViewController

@synthesize flyFishingMethodList, spinFishingMethodList;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    flyFishingMethodList = [MethodList getFlyFishingList];
    spinFishingMethodList = [MethodList getSpinFishingList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Fly Tackle", @"Fly Tackle");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Conventional Tackle", @"Conventional Tackle");
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return flyFishingMethodList.count;
            break;
        case 1:
            return spinFishingMethodList.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MethodCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *method;
    
    switch (indexPath.section) {
        case 0:
            method = [flyFishingMethodList objectAtIndex:indexPath.row];
            break;
        case 1:
            method = [spinFishingMethodList objectAtIndex:indexPath.row];
            break;
        default:
            method = @"";
            break;
    }
    
    cell.textLabel.text = method;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.delegate.selectedMethodLabel.text = cell.textLabel.text;
    [self.delegate changeMethodFieldIconToColor:@"blue"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clearButton:(UIBarButtonItem *)sender {
    self.delegate.selectedMethodLabel.text = @"Select Method";
    [self.delegate changeMethodFieldIconToColor:@"grey"];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
