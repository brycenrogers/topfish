//
//  ReportedCatchesViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 7/13/14.
//
//

#import "ReportedCatchesViewController.h"
#import "Catch.h"
#import "CatchTableViewCell.h"
#import "ThemeColors.h"
#import "CatchDetailTableViewController.h"

@interface ReportedCatchesViewController ()

@end

@implementation ReportedCatchesViewController

@synthesize selectedCatch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.parseClassName = @"Catch";
        self.textKey = @"species";
        self.imageKey = @"photo";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tableView registerClass:[CatchTableViewCell class] forCellReuseIdentifier:@"ReportedCatchCell"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController setDelegate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController setDelegate:self];
    // Unselect the selected row if any
	NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
	if (selection) {
		[self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

- (PFQuery *)queryForTable {
    PFQuery *query = [Catch query];
    [query whereKey:@"reported" equalTo:[NSNumber numberWithBool:YES]];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"user"];
    return query;
}

- (PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    CatchTableViewCell *cell = [tableView
                                dequeueReusableCellWithIdentifier:@"ReportedCatchCell"
                                forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CatchTableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:@"ReportedCatchCell"];
    }
    
    PFFile *imageFile = object[@"photo"];
    cell.imageView.image = [UIImage imageNamed:@"fish-default-photo.png"];
    cell.imageView.file = imageFile;
    
    NSAttributedString *speciesString = [[NSAttributedString alloc] initWithString:object[@"species"] attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                                                                   NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:16.0]}];
    cell.speciesLabel.attributedText = speciesString;
    
    NSString *sizeString = [NSString
                            stringWithFormat:@"Length - %1@ %1@, Weight - %1@ %1@",
                            object[@"length"],
                            object[@"lengthMeasurement"],
                            object[@"weight"],
                            object[@"weightMeasurement"]];
    NSAttributedString *sizeStringAttributed = [[NSAttributedString alloc] initWithString:sizeString attributes:@{NSForegroundColorAttributeName: [UIColor grayColor],
                                                                                                                  NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12.0]}];
    cell.sizeLabel.attributedText = sizeStringAttributed;
    
    // Change text color on reported catches
    if (object[@"reported"] == [NSNumber numberWithBool:YES]) {
        NSAttributedString *speciesStringRed = [[NSAttributedString alloc] initWithString:object[@"species"] attributes:@{NSForegroundColorAttributeName: [ThemeColors redColor],
                                                                                                                          NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:16.0]}];
        cell.speciesLabel.attributedText = speciesStringRed;
        
        NSAttributedString *reportedString = [[NSAttributedString alloc] initWithString:@"Reported for content!" attributes:@{NSForegroundColorAttributeName: [ThemeColors redColor],
                                                                                                                              NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12.0]}];
        cell.sizeLabel.attributedText = reportedString;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.objects.count && self.paginationEnabled) {
        // Load More Cell
        return [self loadNextPage];
    }
    
    selectedCatch = [self.objects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showCatchDetailFromReported" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCatchDetailFromReported"])
    {
        CatchDetailTableViewController *catchDetailVC = [segue destinationViewController];
        catchDetailVC.selectedCatch = selectedCatch;
        catchDetailVC.fromSelectedCatchUsersCatches = NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
