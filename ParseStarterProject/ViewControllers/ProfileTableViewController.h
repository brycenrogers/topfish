//
//  ProfileTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import <UIKit/UIKit.h>
#import "ThemedTableViewController.h"

@interface ProfileTableViewController : ThemedTableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *usernameRowCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *emailRowCell;

@end
