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

@synthesize loginLogoutButton;

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
    if ([PFUser currentUser] == nil || [[PFUser currentUser].username isEqualToString:@"notLoggedInUser"]) {
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
    if (user != nil && ![user.username isEqualToString:@"notLoggedInUser"]) {
        [self.usernameRowCell.textLabel setText:username];
        [self.emailRowCell.textLabel setText:email];
    } else {
        self.usernameRowCell.textLabel.text = @"";
        self.emailRowCell.textLabel.text = @"";
    }
}

- (void)logOut {
    [PFUser logOut];
    [self setUsernameAndEmailLabels];
    [self setLoginLogoutButtonLabel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 2 && indexPath.row == 0) {
//        [self logOut];
//    }
}

- (IBAction)loginLogoutButtonClicked:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Login or Signup"]) {
        [self performSegueWithIdentifier:@"showLoginSegue" sender:nil];
    } else {
        [self logOut];
    }
}
@end
