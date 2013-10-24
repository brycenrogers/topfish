//
//  CustomTabBarController.m
//  TopFish
//
//  Created by Brycen Rogers on 8/24/13.
//
//

#import "CustomTabBarController.h"
#import "AddCatchInfoTableViewController.h"
#import <Parse/Parse.h>

@interface CustomTabBarController ()
@end

@implementation CustomTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Check for login
    if ([PFUser currentUser] == nil) {
        [self performSegueWithIdentifier:@"userLoginFormSegue" sender:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.viewControllers = [NSArray arrayWithObjects:
                            [self viewControllerWithTabTitle:@"Leaderboard" image:[UIImage imageNamed:@""]],
                            [self viewControllerWithTabTitle:@"Map" image:[UIImage imageNamed:@""]],
                            [self viewControllerWithTabTitle:@"Add Catch" image:[UIImage imageNamed:nil]],
                            [self viewControllerWithTabTitle:@"Catches" image:[UIImage imageNamed:@""]],
                            [self viewControllerWithTabTitle:@"Profile" image:[UIImage imageNamed:@""]],
                            nil];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"capture-button.png"] highlightImage:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController*)viewControllerWithTabTitle:(NSString*)title image:(UIImage*)image
{
    UIStoryboard *storyboard = self.storyboard;
    UIViewController *viewController = nil;
    
    if ([title isEqual: @"Leaderboard"]) {
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"LeaderboardNC"];
    }
    
    if ([title isEqual: @"Map"]) {
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"MapVC"];
    }
    
    if ([title isEqual: @"Add Catch"]) {
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"AddCatchNC"];
    }
    
    if ([title isEqual: @"Catches"]) {
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"CatchesNC"];
    }
    
    if ([title isEqual: @"Profile"]) {
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"ProfileNC"];
    }
    
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
    return viewController;
}

- (void)addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    [button addTarget:self action:@selector(showAddCatchInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)showAddCatchInfo
{
    UINavigationController *addCatchNC = [self.viewControllers objectAtIndex:2];
    UITableViewController *addCatchTVC = [addCatchNC.viewControllers objectAtIndex:0];
    [addCatchNC popToRootViewControllerAnimated:YES];
    [addCatchTVC.tableView setContentOffset:CGPointZero animated:YES];
    [self setSelectedViewController:addCatchNC];
}

@end
