//
//  ProfileTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import <UIKit/UIKit.h>
#import "ThemedTableViewController.h"
#import "LoginUserDelegate.h"

@interface ProfileTableViewController : ThemedTableViewController<LoginUserDelegate>

@property (strong, nonatomic) IBOutlet UITableViewCell *usernameRowCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *emailRowCell;
@property (strong, nonatomic) IBOutlet UIButton *loginLogoutButton;
@property (strong, nonatomic) PFUser *loggedInUser;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;

- (IBAction)loginLogoutButtonClicked:(UIButton *)sender;

@end
