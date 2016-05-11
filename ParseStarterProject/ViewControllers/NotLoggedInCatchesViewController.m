//
//  NotLoggedInCatchesViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 5/15/14.
//
//

#import "NotLoggedInCatchesViewController.h"
#import "ThemeColors.h"
#import "LoginNavigationController.h"
#import "LoginUserDelegate.h"

@interface NotLoggedInCatchesViewController ()

@end

@implementation NotLoggedInCatchesViewController

@synthesize loginButton, loginLabel;

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
    [self addLoginButtonToView];
    [self addLoginLabelToView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLoginLabelToView
{
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 40)];
    loginLabel.text = @"Login to Add Catches";
    loginLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loginLabel];
}

- (void)addLoginButtonToView
{
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(80, 277, 160, 40);
    [loginButton setTitle:@"Login or Signup" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(clickedLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTintColor:[ThemeColors blueColor]];
    [self.view addSubview:loginButton];
}

- (void)clickedLoginButton
{    
    [self performSegueWithIdentifier:@"showUserLoginSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showUserLoginSegue"])
    {
        LoginNavigationController *loginNC = [segue destinationViewController];
        loginNC.delegate = (UINavigationController<LoginUserDelegate> *)self.navigationController;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
