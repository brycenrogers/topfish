//
//  CustomTabBarController.m
//  TopFish
//
//  Created by Brycen Rogers on 8/24/13.
//
//

#import "CustomTabBarController.h"
#import "AddCatchInfoTableViewController.h"
#import "LeaderboardNavigationController.h"
#import "ThemeColors.h"
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tabBar.selectedImageTintColor = [ThemeColors greenColor];
    self.viewControllers = [NSArray arrayWithObjects:
                            [self viewControllerWithTabTitle:@"Leaderboard" image:[UIImage imageNamed:@"trophy-mini.png"]],
                            [self viewControllerWithTabTitle:@"Map" image:[UIImage imageNamed:@"map-pin-area-mini.png"]],
                            [self viewControllerWithTabTitle:@"Add Catch" image:nil],
                            [self viewControllerWithTabTitle:@"Catches" image:[UIImage imageNamed:@"shopping-bag-mini.png"]],
                            [self viewControllerWithTabTitle:@"Profile" image:[UIImage imageNamed:@"man-mini.png"]],
                            nil];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"add-catch-button-green.png"] highlightImage:nil];
    self.selectedViewController = [self.viewControllers objectAtIndex:0];
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
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"MapNC"];
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
    button.frame = CGRectMake(0.0, -2.0, buttonImage.size.width, buttonImage.size.height);
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

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    if ([item.title isEqualToString:@"Leaderboard"]) {
//        NSArray *vcArray = [self viewControllers];
//        LeaderboardNavigationController *lbnc = (LeaderboardNavigationController *)[vcArray objectAtIndex:0];
//        [lbnc popToRootViewControllerAnimated:YES];
//    }
}

- (BOOL)shouldAutorotate
{
    return UIInterfaceOrientationMaskPortrait;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
