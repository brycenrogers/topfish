//
//  ProfileCatchesTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import "ProfileCatchesTableViewController.h"
#import "Catch.h"
#import "CatchDetailTableViewController.h"
#import "LeaderboardTableViewCell.h"

@interface ProfileCatchesTableViewController ()

@end

@implementation ProfileCatchesTableViewController

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
    [self.tableView registerClass:[LeaderboardTableViewCell class] forCellReuseIdentifier:@"LeaderboardCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForTable {
    PFQuery *query = [Catch query];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"user"];
    return query;
}

- (PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedCatch = [self.objects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showCatchDetailFromProfile" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCatchDetailFromProfile"])
    {
        CatchDetailTableViewController *catchDetailVC = [segue destinationViewController];
        catchDetailVC.selectedCatch = selectedCatch;
    }
}

@end
