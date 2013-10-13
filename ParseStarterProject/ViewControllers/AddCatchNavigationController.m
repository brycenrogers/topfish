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
