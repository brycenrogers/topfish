//
//  ProfileViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import "ProfileViewController.h"
#import "ProfileCatchesTableViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize emailAddressLabel, catchesTableContainer;

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
    [self fetchProfileData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchProfileData {
    self.emailAddressLabel.text = [[PFUser currentUser] email];
}

- (IBAction)refreshProfile:(UIBarButtonItem *)sender {
    [self fetchProfileData];
    ProfileCatchesTableViewController *myChildViewController = (ProfileCatchesTableViewController *)[self.childViewControllers objectAtIndex:0];
    [myChildViewController fetchCatchesData];
}
@end
