//
//  LeaderboardTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import "LeaderboardTableViewController.h"
#import "Catch.h"
#import "CatchDetailTableViewController.h"
#import "LoadingView.h"
#import "LeaderboardTableViewCell.h"
#import "LeaderboardTableViewCellFirst.h"
#import "FilterTableViewController.h"

@interface LeaderboardTableViewController ()

@end

@implementation LeaderboardTableViewController

@synthesize selectedCatch, selectedMethodFilter, selectedSpeciesFilter, noResultsView, filterButton, filteredLayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.parseClassName = @"Catch";
        self.textKey = @"species";
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.selectedMethodFilter != nil || self.selectedSpeciesFilter != nil) {
        [self showFilteredLayer];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tableView registerClass:[LeaderboardTableViewCell class] forCellReuseIdentifier:@"LeaderboardCell"];
    [self.tableView registerClass:[LeaderboardTableViewCellFirst class] forCellReuseIdentifier:@"LeaderboardCellFirst"];
    self.paginationEnabled = NO;
    
    UIView *noResultsV = [[UIView alloc] initWithFrame:CGRectMake(30, -100, 100, 100)];
    UILabel *noResults = [[UILabel alloc] initWithFrame:self.view.frame];
    noResults.text = @"No fish found for selected filters";
    noResultsView.backgroundColor = [UIColor redColor];
    self.noResultsView = noResultsV;
    [self.noResultsView addSubview:noResults];
    [self.view addSubview:self.noResultsView];
    [self.view bringSubviewToFront:self.noResultsView];
    self.noResultsView.hidden = YES;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(262.0, 43.0) radius:4.0 startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = [path CGPath];
    layer.fillColor = [[UIColor whiteColor] CGColor];
    layer.opacity = 0.0;
    self.filteredLayer = layer;
    [self.navigationController.view.layer addSublayer:self.filteredLayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLeaderboardWithFilter {
    [self loadObjects];
}

- (void)showFilteredLayer {
    [self.filteredLayer setOpacity:1.0];
}

- (void)hideFilteredLayer {
    [self.filteredLayer setOpacity:0.0];
}

- (void)setFilterButtonColor:(UIColor *)toColor {
    [self.filterButton setTitleTextAttributes:@{NSForegroundColorAttributeName: toColor} forState:UIControlStateNormal];
}

- (PFQuery *)queryForTable {
    PFQuery *query = [Catch query];
    [query whereKey:@"rankedCatch" equalTo:[NSNumber numberWithBool:YES]];
    if (self.selectedSpeciesFilter != nil) {
        [query whereKey:@"species" equalTo:self.selectedSpeciesFilter];
    }
    if (self.selectedMethodFilter != nil) {
        [query whereKey:@"method" equalTo:self.selectedMethodFilter];
    }
    [query orderByDescending:@"length"];
    [query includeKey:@"user"];
    query.limit = 20;
    return query;
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    if ([self.objects count] == 0) {
        self.noResultsView.hidden = NO;
        [self.tableView setSeparatorColor:[UIColor clearColor]];
    } else {
        self.noResultsView.hidden = YES;
        [self setSeparatorColor];
    }
}

- (void)showNumberOne {
    UIView *numberOneView = [[UIView alloc] initWithFrame:CGRectMake(150, 5, 30, 30)];
    numberOneView.backgroundColor = [UIColor redColor];
    [self.tableView addSubview:numberOneView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[cell.contentView viewWithTag:333] removeFromSuperview];
    [[cell.contentView viewWithTag:334] removeFromSuperview];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[cell.contentView viewWithTag:1] removeFromSuperview];
}

- (PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    if (indexPath.row == 0) {
        LeaderboardTableViewCellFirst *cell = [tableView
                                               dequeueReusableCellWithIdentifier:@"LeaderboardCellFirst"
                                               forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[LeaderboardTableViewCellFirst alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:@"LeaderboardCellFirst"];
        }
        
        NSAttributedString *speciesString = [[NSAttributedString alloc] initWithString:object[@"species"] attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                                                                       NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:16.0]}];
        cell.speciesLabel.attributedText = speciesString;

        NSString *sizeString = [NSString
                                     stringWithFormat:@"%1@ %1@, %1@ %1@",
                                     object[@"length"],
                                     object[@"lengthMeasurement"],
                                     object[@"weight"],
                                     object[@"weightMeasurement"]];
        NSAttributedString *sizeStringAttributed = [[NSAttributedString alloc] initWithString:sizeString attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                                                                      NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:14.0]}];
        cell.sizeLabel.attributedText = sizeStringAttributed;
        
        PFFile *imageFile = object[@"photo"];
        cell.imageView.image = [UIImage imageNamed:@"fish-default-photo.png"];
        cell.imageView.file = imageFile;
        
        return cell;
        
    } else {
        LeaderboardTableViewCell *cell = [tableView
                                          dequeueReusableCellWithIdentifier:@"LeaderboardCell"
                                          forIndexPath:indexPath];
        
        if (cell == nil) {
        cell = [[LeaderboardTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:@"LeaderboardCell"];
        }
        
        PFFile *imageFile = object[@"photo"];
        cell.imageView.image = [UIImage imageNamed:@"fish-default-photo.png"];
        cell.imageView.file = imageFile;
        
        NSAttributedString *speciesString = [[NSAttributedString alloc] initWithString:object[@"species"] attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                                                                       NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:16.0]}];
        cell.speciesLabel.attributedText = speciesString;
        
        NSString *sizeString = [NSString
                                stringWithFormat:@"%1@ %1@, %1@ %1@",
                                object[@"length"],
                                object[@"lengthMeasurement"],
                                object[@"weight"],
                                object[@"weightMeasurement"]];
        NSAttributedString *sizeStringAttributed = [[NSAttributedString alloc] initWithString:sizeString attributes:@{NSForegroundColorAttributeName: [UIColor grayColor],
                                                                                                                      NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12.0]}];
        cell.sizeLabel.attributedText = sizeStringAttributed;
        cell.placementString = [NSString stringWithFormat:@"%d", indexPath.row + 1];
        
        cell.imageView.frame = CGRectMake(0, 0, 88, 61);
        
        [cell drawPlacementBadgeWithNumber:[NSString stringWithFormat:@"%d", indexPath.row + 1]];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 170;
    }
    
    return 60;
}

// Segues

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedCatch = [self.objects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showCatchDetailsFromLeaderboard" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCatchDetailsFromLeaderboard"])
    {
        CatchDetailTableViewController *catchDetailVC = [segue destinationViewController];
        catchDetailVC.selectedCatch = selectedCatch;
    }
    if ([[segue identifier] isEqualToString:@"showFilterSegue"])
    {
        FilterTableViewController *filterTVC = (FilterTableViewController *)[segue destinationViewController];
        filterTVC.delegate = self;
        [self hideFilteredLayer];
    }
}

@end
