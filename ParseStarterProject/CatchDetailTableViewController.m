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
#import "BSVote.h"
#import "UserReportedNotification.h"

@interface CatchDetailTableViewController ()

@end

@implementation CatchDetailTableViewController

@synthesize selectedCatch,
selectedCatchBSVotes,
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
catchNotesLabel,
callBSButton,
reportButton;

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
    alert.tag = 1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1 && buttonIndex == 1) {
        UINavigationController<CatchUpdatedNavigationControllerProtocol> *parentNC = (UINavigationController<CatchUpdatedNavigationControllerProtocol> *)self.navigationController;
        parentNC.catchUpdated = YES;
        [selectedCatch deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [parentNC showCatchDeletedMessage];
            }
        }];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (alertView.tag == 2 && buttonIndex == 1) {
        [self castBSVote];
        return;
    }
    if (alertView.tag == 3 && buttonIndex == 1) {
        [self reportContent];
        return;
    }
    if (alertView.tag == 4 && buttonIndex == 1) {
        [self approveReportedCatch];
        return;
    }
    if (alertView.tag == 5 && buttonIndex == 1) {
        [self rejectReportedCatch];
        return;
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

- (void)viewDidAppear:(BOOL)animated {
    // Get BS Votes if current user is not anonymous
    if (![PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        PFQuery *query = [BSVote query];
        [query whereKey:@"catch" equalTo:selectedCatch];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                selectedCatchBSVotes = [NSMutableArray arrayWithArray:objects];
            }
        }];
    }
}

- (void)refreshRankedCatchLabel
{
    rankedCatchLabel.frame = CGRectMake(95, 75, 130, 30);
    rankedCatchLabel.textColor = [UIColor whiteColor];
    rankedCatchLabel.text = [self rankedCatchToString];
    rankedCatchLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
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
    
    // If the catch has been reported, show "Reported" view
    if (selectedCatch[@"reported"] == [NSNumber numberWithBool:YES]) {
        UIView *reportedView = [[UIView alloc] initWithFrame:CGRectMake(0, (catchImageView.frame.size.height - 40.0), self.view.frame.size.width, 40)];
        reportedView.backgroundColor = [ThemeColors orangeColor];
        
        UILabel *reportedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, reportedView.frame.size.width, reportedView.frame.size.height)];
        reportedLabel.textAlignment = NSTextAlignmentCenter;
        NSAttributedString *reportedString = [[NSAttributedString alloc] initWithString:@"Reported for content!"
                                                                             attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                                                                              NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:16.0]}];
        reportedLabel.attributedText = reportedString;
        [reportedView addSubview:reportedLabel];
        [catchImageView addSubview:reportedView];
        
        // If the user is mod, show the 'Allow' and 'Reject' buttons
        if ([UserReportedNotification canViewReportedCatches]) {
            
            UIButton *approveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [approveBtn addTarget:self action:@selector(approveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            approveBtn.frame = CGRectMake(0, (catchImageView.frame.size.height - 40.0), 70.0, 40.0);
            [approveBtn setTitle:@"Approve" forState:UIControlStateNormal];
            [approveBtn setBackgroundColor:[ThemeColors greenColor]];
            [approveBtn setTintColor:[UIColor whiteColor]];
            [catchImageView addSubview:approveBtn];
        
            UIButton *rejectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [rejectBtn addTarget:self action:@selector(rejectButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            rejectBtn.frame = CGRectMake((reportedView.frame.size.width - 70.0), (catchImageView.frame.size.height - 40.0), 70.0, 40.0);
            [rejectBtn setTitle:@"Reject" forState:UIControlStateNormal];
            [rejectBtn setBackgroundColor:[ThemeColors redColor]];
            [rejectBtn setTintColor:[UIColor whiteColor]];
            [catchImageView addSubview:rejectBtn];
        }
    }
}

- (void)approveReportedCatch
{
    if ([UserReportedNotification canViewReportedCatches]) {
        // Reset Catch by setting "reported" value to NO and show message
        selectedCatch.reported = NO;
        [selectedCatch saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UINavigationController<CatchUpdatedNavigationControllerProtocol> *navController = (UINavigationController<CatchUpdatedNavigationControllerProtocol> *)self.navigationController;
                [navController showCatchApprovedMessage];
                [navController popViewControllerAnimated:YES];
            }
        }];
    }
}

- (void)rejectReportedCatch
{
    if ([UserReportedNotification canViewReportedCatches]) {
        // Delete Catch and show message
        [selectedCatch deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UINavigationController<CatchUpdatedNavigationControllerProtocol> *navController = (UINavigationController<CatchUpdatedNavigationControllerProtocol> *)self.navigationController;
                [navController showCatchRejectedMessage];
                [navController popViewControllerAnimated:YES];
            }
        }];
    }
}

- (void)approveButtonClicked
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Approve Content"
                                                    message:@"Only Approve a Reported catch if you are sure it is appropriate and non-offensive. Are you sure?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Approve", nil];
    alert.tag = 4;
    [alert show];
}

- (void)rejectButtonClicked
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reject Content"
                                                    message:@"Rejected Catches are deemed inappropriate and are permanently deleted from the app. Are you sure?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Reject", nil];
    alert.tag = 5;
    [alert show];
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
            btn.frame = CGRectMake(228.0, 75.0, 30.0, 30.0);
            [btn setImage:[UIImage imageNamed:@"pen-mini-white.png"] forState:UIControlStateNormal];
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
            btn.frame = CGRectMake(62.0, 75.0, 30.0, 30.0);
            [btn setImage:[UIImage imageNamed:@"multiply-symbol-mini-white.png"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[ThemeColors redColor]];
            [btn setTintColor:[UIColor whiteColor]];
            deleteButton = btn;
            NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
            [[self.tableView cellForRowAtIndexPath:index].contentView addSubview:deleteButton];
        }
        deleteButton.hidden = NO;
        callBSButton.hidden = YES;
        reportButton.hidden = YES;
    } else {
        if (editButton != nil) {
            editButton.hidden = YES;
        }
        if (deleteButton != nil) {
            deleteButton.hidden = YES;
        }
        callBSButton.hidden = NO;
        reportButton.hidden = NO;
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
        if ([catchNotesLabel.text isEqualToString:@"None"]) {
            theCell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            theCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
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
    
    [catchImageView.layer insertSublayer:gradient atIndex:0];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:self.view];
    return !CGRectContainsPoint(self.catchImageView.frame, touchLocation);
}

- (NSMutableString *)catchLengthToString {
    NSMutableString *lengthString = [NSMutableString stringWithFormat:@"%.02f ", selectedCatch.length];
    [lengthString appendString:selectedCatch.lengthMeasurement];
    return lengthString;
}

- (NSMutableString *)catchWeightToString {
    NSMutableString *weightString = [NSMutableString stringWithFormat:@"%.02f ", selectedCatch.weight];
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
        return;
    }
    if ([[segue identifier] isEqualToString:@"showOnMapFromDetails"])
    {
        AddCatchMapLocationViewController *acmlvc = [segue destinationViewController];
        acmlvc.delegate = self;
        acmlvc.locationCoordinate = CLLocationCoordinate2DMake(selectedCatch.location.latitude, selectedCatch.location.longitude);
        return;
    }
    if ([[segue identifier] isEqualToString:@"showCatchesFromUser"])
    {
        CatchesTableViewController *ctvc = [segue destinationViewController];
        ctvc.selectedCatch = selectedCatch;
        ctvc.user = selectedCatch.user;
        return;
    }
    if ([[segue identifier] isEqualToString:@"showCatchNotesFromDetails"]) {
        AddCatchNotesViewController *acnvc = [segue destinationViewController];
        acnvc.delegate = self;
        acnvc.viewMode = YES;
        return;
    }
    if ([[segue identifier] isEqualToString:@"editCatchSegue"]) {
        AddCatchInfoTableViewController *acitvc = [segue destinationViewController];
        acitvc.selectedCatch = selectedCatch;
        acitvc.selectedCatchObjectId = selectedCatch.objectId;
        acitvc.title = @"Edit Catch";
        return;
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

- (IBAction)pressCallBSButton:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call BS on this Catch!"
                                                    message:@"If a catch receives enough BS calls, it will be removed from the Leaderboards. Are you sure you want to call BS on this catch?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes, Call BS!", nil];
    alert.tag = 2;
    [alert show];
}

- (IBAction)pressReportButton:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Report Content"
                                                    message:@"You may report content if it contains inappropriate photos or notes. Content that is reported will be reviewed and removed within 24 hours if deemed inappropriate."
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Report Content", nil];
    alert.tag = 3;
    [alert show];
}

- (void)reportContent
{
    // Validate that user can report catch
    if ([UserReportedNotification canReportCatch:selectedCatch]) {
        
        // User's catch goes into "reported" mode
        selectedCatch.reported = YES;
        [selectedCatch saveInBackground];
        
        // Add UserReportedNotification for user
        UserReportedNotification *ufn = [UserReportedNotification object];
        Catch *catch = selectedCatch;
        PFUser *currentUser = [PFUser currentUser];
        PFUser *catchUser = selectedCatch.user;
        ufn.reportedCatch = catch;
        ufn.userWhoReported = currentUser;
        ufn.user = catchUser;
        [ufn.ACL setPublicWriteAccess:YES];
        [ufn.ACL setPublicReadAccess:YES];
        
        // Save Notification
        UINavigationController<CatchUpdatedNavigationControllerProtocol> *parentNC = (UINavigationController<CatchUpdatedNavigationControllerProtocol> *)self.navigationController;
        [ufn saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
                [PFCloud callFunctionInBackground:@"sendMail"
                                   withParameters:[UserReportedNotification reportedCatchEmailInfo:catch]
                                            block:^(id object, NSError *error) {
                                                if (!error) {
                                                    NSLog(@"Reported Catch Email Sent");
                                                }
                }];
                
                // Show "Catch Reported" message
                [parentNC showCatchReportedMessage];
            }
        }];
        
        // Return to previous view
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)castBSVote
{
    BOOL alreadyVoted = NO;
    // Check to see if they own any of the BS Votes for the Catch
    if (selectedCatchBSVotes != nil && [selectedCatchBSVotes count] != 0) {
        for (BSVote *vote in selectedCatchBSVotes) {
            if ([vote.user.objectId isEqualToString:[PFUser currentUser].objectId]) {
                alreadyVoted = YES;
                
                [self showAlreadyVotedAlert];
            }
        }
    }
    if (!alreadyVoted) {
        if ([selectedCatch canCastBSVote]) {
            // Create a BS Vote
            selectedCatch.BSCount++;
            BSVote *newBSVote = [[BSVote alloc] init];
            newBSVote.user = [PFUser currentUser];
            newBSVote.catch = selectedCatch;
            [newBSVote saveInBackground];
            [selectedCatchBSVotes addObject:newBSVote];
            [self showCastBSVoteMessage];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"You cannot call BS on this catch"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            alert.tag = 50;
            [alert show];
        }
    }
}

- (void)showAlreadyVotedAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"You already called BS on this catch!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    alert.tag = 3;
    [alert show];
}

// BS Vote cast animation

- (void)showCastBSVoteMessage
{
    [self animateBSVoteCastView:self.navigationController.view];
}

- (UIView *)getBSVoteCastView
{
    UIView *voteCastView = [[UIView alloc] init];
    voteCastView.backgroundColor = [ThemeColors redColor];
    voteCastView.frame = CGRectMake(0, -64.0, 320.0, 64.0);
    voteCastView.alpha = 0.5;
    UILabel *catchUpdatedLabel = [[UILabel alloc] init];
    catchUpdatedLabel.text = @"You called BS!";
    catchUpdatedLabel.frame = CGRectMake(0.0, 10.0, voteCastView.frame.size.width, voteCastView.frame.size.height);
    catchUpdatedLabel.textAlignment = NSTextAlignmentCenter;
    catchUpdatedLabel.textColor = [UIColor whiteColor];
    [voteCastView addSubview:catchUpdatedLabel];
    return voteCastView;
}

- (void)animateBSVoteCastView:(UIView *)view
{
    UIView *cv = [self getBSVoteCastView];
    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        cv.frame = CGRectMake(0, 0, 320, 64);
        cv.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            cv.frame = CGRectMake(0, -64, 320, 64);
            cv.alpha = 0.5;
        } completion:^(BOOL finished) {
        }];
    }];
    [view addSubview:cv];
}

@end
