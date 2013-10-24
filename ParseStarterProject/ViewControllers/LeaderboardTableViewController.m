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

@interface LeaderboardTableViewController ()

@end

@implementation LeaderboardTableViewController

@synthesize selectedCatch, selectedMethodFilter, selectedSpeciesFilter;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tableView registerClass:[LeaderboardTableViewCell class] forCellReuseIdentifier:@"LeaderboardCell"];
    [self.tableView registerClass:[LeaderboardTableViewCellFirst class] forCellReuseIdentifier:@"LeaderboardCellFirst"];
    self.paginationEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForTable {
    PFQuery *query = [Catch query];
    [query whereKey:@"rankedCatch" equalTo:[NSNumber numberWithBool:YES]];
    [query orderByDescending:@"weight"];
    [query includeKey:@"user"];
    query.limit = 20;
    return query;
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
    
    if ([self.objects count] == 0) {
        return [[LeaderboardTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    
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
                                     stringWithFormat:@"Length - %1@ %1@, Weight - %1@ %1@",
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
                                stringWithFormat:@"Length - %1@ %1@, Weight - %1@ %1@",
                                object[@"length"],
                                object[@"lengthMeasurement"],
                                object[@"weight"],
                                object[@"weightMeasurement"]];
        NSAttributedString *sizeStringAttributed = [[NSAttributedString alloc] initWithString:sizeString attributes:@{NSForegroundColorAttributeName: [UIColor grayColor],
                                                                                                                      NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12.0]}];
        cell.sizeLabel.attributedText = sizeStringAttributed;
        cell.placementString = [NSString stringWithFormat:@"%d", indexPath.row + 1];
        
        cell.imageView.frame = CGRectMake(0, 0, 88, 61);
        
        [self drawPlacementBadgeForCell:cell withNumber:[NSString stringWithFormat:@"%d", indexPath.row + 1]];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 170;
    }
    
    return 60;
}

- (void)drawPlacementBadgeForCell:(PFTableViewCell *)cell withNumber:(NSString *)placementNumber {
    UIView *badge = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 61)];
    badge.tag = 1;
    //badge.backgroundColor = [UIColor greenColor];
    
    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(6, 28, 15, 10)];
    
    NSAttributedString *num = [[NSAttributedString alloc] initWithString:placementNumber attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial" size:12.0]}];
    
    number.attributedText = num;
    number.textAlignment = NSTextAlignmentCenter;
    
    [badge addSubview:number];
    
    [cell.contentView insertSubview:badge atIndex:1];
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
}

@end
