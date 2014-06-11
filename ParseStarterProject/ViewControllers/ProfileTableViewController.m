//
//  ProfileTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import "ProfileTableViewController.h"
#import <Parse/Parse.h>

@interface ProfileTableViewController ()

@end

@implementation ProfileTableViewController

@synthesize loginLogoutButton, loggedInUser, usernameRowCell, emailRowCell;

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
    self.usernameRowCell.textLabel.text = [[PFUser currentUser] username];
    self.emailRowCell.textLabel.text = [[PFUser currentUser] email];
    [loginLogoutButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUsernameAndEmailLabels];
    [self setLoginLogoutButtonLabel];
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
        usernameRowCell.textLabel.text = username;
        emailRowCell.textLabel.text = email;
    } else {
        usernameRowCell.textLabel.text = @"";
        emailRowCell.textLabel.text = @"";
    }
}

- (void)logOut {
    [PFUser logOut];
    [self setUsernameAndEmailLabels];
    [self setLoginLogoutButtonLabel];
}

- (IBAction)loginLogoutButtonClicked:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Login or Signup"]) {
        [self performSegueWithIdentifier:@"showLoginSegue" sender:nil];
    } else {
        [self logOut];
    }
}
@end
