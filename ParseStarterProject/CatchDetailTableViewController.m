//
//  CatchDetailViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 10/13/13.
//
//

#import "CatchDetailTableViewController.h"
#import "CatchPhotoDetailView.h"
#import <Parse/Parse.h>
#import "Catch.h"
#import "CatchPhotoScrollViewController.h"
#import "AddCatchMapLocationViewController.h"
#import "CatchesTableViewController.h"
#import "CatchesNavigationController.h"
#import "ThemeColors.h"

@interface CatchDetailTableViewController ()

@end

@implementation CatchDetailTableViewController

@synthesize selectedCatch,
catchImageView,
caughtByButton,
rankedCatchLabel,
viewOnMapButton,
lengthLabel,
weightLabel,
methodLabel,
gestureRecognizer,
editButton,
deleteButton,
fromSelectedCatchUsersCatches,
catchNotesLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self refreshViewForSelectedCatch];
    [self buildSingleTapGestureRecognizer];
    [self setupViewOnMapButton];
}

- (void)setupViewOnMapButton {
    if (selectedCatch.location.latitude == -90.0 && selectedCatch.location.longitude == 0) {
        [self.viewOnMapButton setEnabled:NO];
        [self.viewOnMapButton setTitle:@"No Location Set" forState:UIControlStateNormal];
    } else {
        [self.viewOnMapButton setEnabled:YES];
        [self.viewOnMapButton setTitle:@"View on Map" forState:UIControlStateNormal];
    }
}

- (void)editButtonClicked
{
    [self performSegueWithIdentifier:@"editCatchSegue" sender:nil];
}

- (void)deleteButtonClicked
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Catch"
                                                    message:@"Are you sure you want to delete this catch?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Delete", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [selectedCatch deleteInBackground];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Check to see if the catch has been updated recently, if so, reload it's data
    UINavigationController<CatchUpdatedNavigationControllerProtocol> *cnc = (UINavigationController<CatchUpdatedNavigationControllerProtocol> *)self.navigationController;
    if (cnc.catchUpdated) {
        [self updateObject];
    }
    
    [self setupEditControlsForOwner];
}

- (void)refreshRankedCatchLabel
{
    rankedCatchLabel.textColor = [UIColor whiteColor];
    rankedCatchLabel.text = [self rankedCatchToString];
    if (selectedCatch.rankedCatch) {
        rankedCatchLabel.backgroundColor = [[ThemeColors yellowColor] colorWithAlphaComponent:1.0f];
    } else {
        rankedCatchLabel.backgroundColor = [[ThemeColors yellowColor] colorWithAlphaComponent:0.5f];
    }
}

- (void)refreshViewForSelectedCatch
{
    [self.caughtByButton setTitle:selectedCatch.user.username forState:UIControlStateNormal];
    [self refreshRankedCatchLabel];
    self.speciesLabel.text = selectedCatch.species;
    self.lengthLabel.text = [self catchLengthToString];
    self.weightLabel.text = [self catchWeightToString];
    self.methodLabel.text = selectedCatch.method;
    self.catchNotesLabel.attributedText = [self buildNotesString];
    [self setupViewOnMapButton];
    if (selectedCatch.photo) {
        PFFile *imageFile = [selectedCatch objectForKey:@"photo"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            UIImage *photo = [UIImage imageWithData:data];
            self.catchImageView.image = photo;
        }];
    } else {
        catchImageView.image = [UIImage imageNamed:@"fish-default-photo.png"];
    }
}

- (void)updateObject
{
    PFQuery *query = [Catch query];
    [query includeKey:@"user"];
    [query getObjectInBackgroundWithId:selectedCatch.objectId block:^(PFObject *object, NSError *error) {
        Catch *catchObject = (Catch *)object;
        selectedCatch = catchObject;
        [self refreshViewForSelectedCatch];
    }];
}

- (void)setupEditControlsForOwner
{
    PFUser *currentUser = [PFUser currentUser];
    if ([currentUser.username isEqualToString:selectedCatch.user.username]) {
        if (editButton == nil) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [btn addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(224.0, 75.0, 60.0, 30.0);
            [btn setTitle:@"Edit" forState:UIControlStateNormal];
            [btn setBackgroundColor:[ThemeColors orangeColor]];
            [btn setTintColor:[UIColor whiteColor]];
            editButton = btn;
            NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
            [[self.tableView cellForRowAtIndexPath:index].contentView addSubview:editButton];
        }
        editButton.hidden = NO;
        if (deleteButton == nil) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [btn addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(36.0, 75.0, 60.0, 30.0);
            [btn setTitle:@"Delete" forState:UIControlStateNormal];
            [btn setBackgroundColor:[ThemeColors redColor]];
            [btn setTintColor:[UIColor whiteColor]];
            deleteButton = btn;
            NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
            [[self.tableView cellForRowAtIndexPath:index].contentView addSubview:deleteButton];
        }
        deleteButton.hidden = NO;
    } else {
        if (editButton != nil) {
            editButton.hidden = YES;
        }
        if (deleteButton != nil) {
            deleteButton.hidden = YES;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && gradient == nil) {
        [self setGradient];
    }
    if (indexPath.row == 2) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"map-pin-area-mini-grey.png"];
        return theCell;
    }
    if (indexPath.row == 3) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"hand-mini.png"];
        return theCell;
    }
    if (indexPath.row == 4) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"weight-mini.png"];
        return theCell;
    }
    if (indexPath.row == 5) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"ruler-mini.png"];
        return theCell;
    }
    if (indexPath.row == 6) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"sticky-note-mini.png"];
        return theCell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)setGradient {
    CAGradientLayer *gradientFill = [CAGradientLayer layer];
    gradientFill.frame = CGRectMake(0, 155, 320, 85);
    gradientFill.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    gradientFill.opacity = 0.5;
    
    gradient = gradientFill;
    
    [self.view.layer insertSublayer:gradient atIndex:1];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:self.view];
    return !CGRectContainsPoint(self.catchImageView.frame, touchLocation);
}

- (NSMutableString *)catchLengthToString {
    NSMutableString *lengthString = [NSMutableString stringWithFormat:@"%d ", selectedCatch.length];
    [lengthString appendString:selectedCatch.lengthMeasurement];
    return lengthString;
}

- (NSMutableString *)catchWeightToString {
    NSMutableString *weightString = [NSMutableString stringWithFormat:@"%d ", selectedCatch.weight];
    [weightString appendString:selectedCatch.weightMeasurement];
    return weightString;
}

- (NSString *)rankedCatchToString {
    if (selectedCatch.rankedCatch) {
        return @"Ranked Catch";
    }
    return @"Unranked Catch";
}

- (NSAttributedString *)buildNotesString {
    if (selectedCatch.notes) {
        NSAttributedString *notes = [[NSAttributedString alloc] initWithString:selectedCatch.notes
                                                                    attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        return notes;
    }
    return [[NSAttributedString alloc] initWithString:@"None" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildSingleTapGestureRecognizer {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapDetected)];
    singleTap.numberOfTapsRequired = 1;
    self.catchImageView.userInteractionEnabled = YES;
    [self.catchImageView addGestureRecognizer:singleTap];
}

- (void)singleTapDetected{
    // Trigger segue to CatchPhotoScrollViewController
    [self performSegueWithIdentifier:@"showCatchPhotoScrollViewFromDetails" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCatchPhotoScrollViewFromDetails"])
    {
        CatchPhotoScrollViewController *cpsvc = [segue destinationViewController];
        cpsvc.selectedCatch = selectedCatch;
        cpsvc.photo = catchImageView.image;
    }
    if ([[segue identifier] isEqualToString:@"showOnMapFromDetails"])
    {
        AddCatchMapLocationViewController *acmlvc = [segue destinationViewController];
        acmlvc.delegate = self;
        acmlvc.locationCoordinate = CLLocationCoordinate2DMake(selectedCatch.location.latitude, selectedCatch.location.longitude);
    }
    if ([[segue identifier] isEqualToString:@"showCatchesFromUser"])
    {
        CatchesTableViewController *ctvc = [segue destinationViewController];
        ctvc.selectedCatch = selectedCatch;
        ctvc.user = selectedCatch.user;
    }
    if ([[segue identifier] isEqualToString:@"showCatchNotesFromDetails"]) {
        AddCatchNotesViewController *acnvc = [segue destinationViewController];
        acnvc.delegate = self;
        acnvc.viewMode = YES;
    }
    if ([[segue identifier] isEqualToString:@"editCatchSegue"]) {
        AddCatchInfoTableViewController *acitvc = [segue destinationViewController];
        acitvc.selectedCatch = selectedCatch;
        acitvc.selectedCatchObjectId = selectedCatch.objectId;
        acitvc.title = @"Edit Catch";
    }
}

- (IBAction)showOnMap:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showOnMapFromDetails" sender:nil];
}

- (IBAction)caughtByButton:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    if ([selectedCatch.user.username isEqualToString:currentUser.username]) {
        [self.tabBarController setSelectedIndex:3];
        [[self.tabBarController.viewControllers objectAtIndex:3] popToRootViewControllerAnimated:YES];
    } else if (fromSelectedCatchUsersCatches) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self performSegueWithIdentifier:@"showCatchesFromUser" sender:nil];
    }
    
}

- (void)changeLocationFieldIconToColor:(NSString *)color {}
- (void)changeNotesFieldIconToColor:(NSString *)color {}

@end
