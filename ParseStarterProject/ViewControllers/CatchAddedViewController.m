//
//  CatchAddedViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/2/13.
//
//

#import "CatchAddedViewController.h"

@interface CatchAddedViewController ()



@end

@implementation CatchAddedViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ViewProfileButton:(UIButton *)sender {
    // Switch the tab bar item
    [self.tabBarController setSelectedIndex:3];
    
    // Go to Profile view and transition into Catches segue
    UINavigationController *profileNC = [[self.tabBarController viewControllers] objectAtIndex:3];
    UITableViewController *profileVC = [[profileNC viewControllers] objectAtIndex:0];
    [profileVC performSegueWithIdentifier:@"viewCatchesSegue" sender:nil];
}

- (IBAction)ViewLeaderboardButton:(UIButton *)sender {
    [self.tabBarController setSelectedIndex:0];
}
@end
