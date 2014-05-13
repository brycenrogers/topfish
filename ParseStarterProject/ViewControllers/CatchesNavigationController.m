//
//  CatchesNavigationController.m
//  TopFish
//
//  Created by Brycen Rogers on 10/23/13.
//
//

#import "CatchesNavigationController.h"
#import "CatchUpdatedView.h"

@interface CatchesNavigationController ()

@end

@implementation CatchesNavigationController

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

@end
