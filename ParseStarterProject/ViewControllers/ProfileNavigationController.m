//
//  ProfileNavigationController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import "ProfileNavigationController.h"
#import "CatchUpdatedView.h"
#import "CatchDeletedView.h"
#import "CatchReportedView.h"

@interface ProfileNavigationController ()

@end

@implementation ProfileNavigationController

@synthesize catchUpdated;

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

- (void)showCatchUpdatedMessage
{
    [CatchUpdatedView animateCatchUpdatedViewforView:self.view];
}

- (void)showCatchDeletedMessage
{
    [CatchDeletedView animateCatchDeletedViewforView:self.view];
}

- (void)showCatchReportedMessage
{
    [CatchReportedView animateCatchReportedViewforView:self.view];
}

@end
