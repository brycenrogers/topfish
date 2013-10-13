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
 
    self.usernameRowCell.detailTextLabel.text = [[PFUser currentUser] username];
    self.emailRowCell.detailTextLabel.text = [[PFUser currentUser] email];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logOut {
    [PFUser logOut];
    
    // Show the login screen
    [self.parentViewController.parentViewController performSegueWithIdentifier:@"userLoginFormSegue" sender:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 2) {
        [self logOut];
    }
}

@end
