//
//  AddCatchNavigationControllerViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/2/13.
//
//

#import "AddCatchNavigationController.h"

@interface AddCatchNavigationController ()

@end

@implementation AddCatchNavigationController

@synthesize catchAdded;

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
    [self setGradient];
}

- (void)setGradient {
    CAGradientLayer *gradientFill = [CAGradientLayer layer];
    gradientFill.frame = CGRectMake(0, 0, 320, 64);
    gradientFill.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:(14.0f/255.0f) green:(99.0f/255.0f) blue:(29.0f/255.0f) alpha:1] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    gradientFill.opacity = 1.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (catchAdded) {
        catchAdded = NO;
        [self popViewControllerAnimated:YES];
        UITableViewController *addCatchInfoTable = [self.viewControllers objectAtIndex:0];
        [addCatchInfoTable.tableView setContentOffset:CGPointZero animated:YES];
    }
}

@end
