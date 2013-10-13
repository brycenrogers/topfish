//
//  UserSignupViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 10/11/13.
//
//

#import "UserSignupViewController.h"

@interface UserSignupViewController ()

@end

@implementation UserSignupViewController

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
    [self.usernameField becomeFirstResponder];
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

- (NSString *)validationErrors {
    NSMutableArray *errors = [[NSMutableArray alloc] init];
    
    if ([self.usernameField.text isEqualToString:@""]) {
        [errors addObject:@"Username required"];
    }
    
    if ([self.emailField.text isEqualToString:@""]) {
        [errors addObject:@"Email address required"];
    }
    
    if ([self.passwordField.text isEqualToString:@""]) {
        [errors addObject:@"Password required"];
    }
    
    if ([self.passwordConfirmField.text isEqualToString:@""]) {
        [errors addObject:@"Confirm password required"];
    }
    
    if (![self.passwordField.text isEqualToString:self.passwordConfirmField.text]) {
        [errors addObject:@"Passwords do not match"];
    }
    
    NSString *errorString = @"";
    
    if ([errors count] > 0) {
        errorString = [errors componentsJoinedByString:@"\n"];
    }
    
    return errorString;
}

- (void)showSignupError:(NSString *)title withMessage:(NSString *)message  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)attemptSignup {
    
    NSString *errors = [self validationErrors];
    
    if (![errors isEqualToString:@""]) {
        [self showSignupError:@"Signup Error" withMessage:errors];
        return;
    }
    
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text;
    user.password = self.passwordField.text;
    user.email = self.emailField.text;
    
    // other fields can be set just like with PFObject
    //user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            [self showSignupError:@"Signup Error" withMessage:errorString];
        }
    }];
}

// Events

- (IBAction)signupButton:(UIButton *)sender {
    [self attemptSignup];
}

@end
