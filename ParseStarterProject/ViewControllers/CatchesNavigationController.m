//
//  CatchesNavigationController.m
//  TopFish
//
//  Created by Brycen Rogers on 10/23/13.
//
//

#import "CatchesNavigationController.h"
#import "CatchUpdatedView.h"
#import "NotLoggedInCatchesViewController.h"
#import "CatchesTableViewController.h"
#import "CatchDeletedView.h"

@interface CatchesNavigationController ()

@end

@implementation CatchesNavigationController

@synthesize catchUpdated, loggedInUser, doNotUpdateView;

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

- (void)viewWillAppear:(BOOL)animated
{
    if (doNotUpdateView) {
        doNotUpdateView = NO;
        return;
    }
    if ([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self setViewControllers:@[[self.storyboard instantiateViewControllerWithIdentifier:@"NotLoggedInCatchesVC"]] animated:YES];
    } else {
        [self setViewControllers:@[[self.storyboard instantiateViewControllerWithIdentifier:@"CatchesTVC"]] animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showCatchUpdatedMessage
{
    [CatchUpdatedView animateCatchUpdatedViewforView:self.view];
}

- (void)showCatchDeletedMessage
{
    [CatchDeletedView animateCatchDeletedViewforView:self.view];
}

@end
