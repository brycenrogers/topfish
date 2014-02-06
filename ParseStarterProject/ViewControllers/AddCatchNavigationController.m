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
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:(6.0f/255.0f) green:(113.0f/255.0f) blue:(24.0f/255.0f) alpha:1.0f];
    shadow.shadowOffset = CGSizeMake(0, -1);
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:(22.0f/255.0f) green:(159.0f/255.0f) blue:(46.0f/255.0f) alpha:0.75f];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                               NSShadowAttributeName: shadow,
                                               NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:20]};
    [self setGradient];
}

- (void)setGradient {
    CAGradientLayer *gradientFill = [CAGradientLayer layer];
    gradientFill.frame = CGRectMake(0, 0, 320, 64);
    gradientFill.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:(14.0f/255.0f) green:(99.0f/255.0f) blue:(29.0f/255.0f) alpha:1] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    gradientFill.opacity = 1.0;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
