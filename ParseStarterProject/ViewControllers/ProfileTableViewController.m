//
//  ProfileTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import "ProfileTableViewController.h"
#import <Parse/Parse.h>
#import "UserReportedNotification.h"

@interface ProfileTableViewController ()

@end

@implementation ProfileTableViewController

@synthesize loginLogoutButton,
loggedInUser,
usernameRowCell,
emailRowCell,
usernameLabel,
emailLabel,
reportedCatchesButton;

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
    usernameLabel.text = [[PFUser currentUser] username];
    emailLabel.text = [[PFUser currentUser] email];
    [loginLogoutButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUsernameAndEmailLabels];
    [self setLoginLogoutButtonLabel];
    
    NSIndexPath *usernameRowIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *emailRowIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[usernameRowIndexPath, emailRowIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
    [self updateReportedButtonVisibility];
}

- (void)updateReportedButtonVisibility
{
    if ([UserReportedNotification canViewReportedCatches]) {
        self.navigationItem.rightBarButtonItem = reportedCatchesButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLoginLogoutButtonLabel {
    if ([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        [loginLogoutButton setTitle:@"Login or Signup" forState:UIControlStateNormal];
    } else {
        [loginLogoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    }
}

- (void)setUsernameAndEmailLabels
{
    PFUser *user = [PFUser currentUser];
    NSString *username = user.username;
    NSString *email = user.email;
    if (![PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        usernameLabel.text = username;
        emailLabel.text = email;
    } else {
        usernameLabel.text = @"";
        emailLabel.text = @"";
    }
}

- (void)logOut {
    [PFUser logOut];
    [self setUsernameAndEmailLabels];
    [self setLoginLogoutButtonLabel];
    [self updateReportedButtonVisibility];
}

- (IBAction)loginLogoutButtonClicked:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Login or Signup"]) {
        [self performSegueWithIdentifier:@"showLoginSegue" sender:nil];
    } else {
        [self logOut];
    }
}
@end
