//
//  UserLoginViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 10/11/13.
//
//

#import "UserLoginViewController.h"
#import "ThemeColors.h"

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController

@synthesize usernameField, passwordField, delegate, logoImageView, keyboardDoneView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [self hideLoadingView];
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [ThemeColors backgroundImage];
    
	// Do any additional setup after loading the view.
    usernameField.delegate = self;
    passwordField.delegate = self;
    delegate = (UINavigationController<LoginUserDelegate> *)self.navigationController.delegate;
    
    // Setup logo image
    logoImageView.image = [UIImage imageNamed:@"topfish-logo.png"];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    logoImageView.alpha = 0.25;
    
    // Add Done button to Keyboard
    usernameField.inputAccessoryView = [self inputAccessoryView];
    passwordField.inputAccessoryView = [self inputAccessoryView];
}

- (UIView *)inputAccessoryView {
    if (!keyboardDoneView) {
        CGRect accessFrame = CGRectMake(0.0, 0.0, 320.0, 45.0);
        keyboardDoneView = [[UIToolbar alloc] initWithFrame:accessFrame];
        keyboardDoneView.barStyle = UIBarStyleDefault;
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonClicked)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [keyboardDoneView setItems:[NSArray arrayWithObjects:flexibleSpace,doneButton,nil]];
    }
    return keyboardDoneView;
}

- (void)doneButtonClicked {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)validateFields {
    if ([self.usernameField.text isEqualToString:@""]) {
        return NO;
    }
    
    if ([self.passwordField.text isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

- (void)showLoginError:(NSString *)title withMessage:(NSString *)message  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)attemptLogin {
    
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [self buildLoadingView];
    
    if (![self validateFields]) {
        [self showLoginError:@"Derp!" withMessage:@"Please enter a Username and Password"];
        [self hideLoadingView];
        return;
    }
    
    [PFUser logInWithUsernameInBackground:self.usernameField.text
                                 password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            delegate.loggedInUser = user;
                                            [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
                                        } else {
                                            // The login failed. Check error to see why.
                                            if (error.code == 101) {
                                                [self showLoginError:@"Whoops!" withMessage:@"Invalid username or password"];
                                            }
                                        }
                                        [self hideLoadingView];
                                    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"Forgot Password"] && buttonIndex == 1) {
        [self buildLoadingView];
        [PFUser requestPasswordResetForEmailInBackground:[[alertView textFieldAtIndex:0] text] block:^(BOOL succeeded, NSError *error) {
            loadingOverlay.hidden = YES;
            if (succeeded) {
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Password Reset Email Sent!"
                                                            message:@"Check your email to setup your shiny new password"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
                [av show];
            } else {
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Oh dang!"
                                                            message:[error.userInfo objectForKey:@"error"]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
                [av show];
            }
        }];
    }
}

// Events

- (IBAction)loginButton:(UIButton *)sender {
    [self attemptLogin];
}

- (IBAction)signupButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showSignup" sender:nil];
}

- (IBAction)forgotPasswordButton:(UIButton *)sender {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Forgot Password"
                                                message:@"Please enter your email address"
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:@"OK", nil];
    
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av textFieldAtIndex:0].delegate = self;
    [av show];
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signupButtonHeader:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"showSignup" sender:nil];
}

- (void)buildLoadingView {
    if (!loadingOverlay) {
        UIView *loadingOverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        loadingOverlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:.75];
        loadingOverlay = loadingOverlayView;
        
        UIActivityIndicatorView *aIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        aIV.frame = CGRectMake(0, 0, loadingOverlay.frame.size.width, loadingOverlay.frame.size.height);
        [aIV startAnimating];
        [loadingOverlay addSubview:aIV];
        
        [self.view.window addSubview:loadingOverlayView];
    } else {
        loadingOverlay.hidden = NO;
    }
}
     
- (void)hideLoadingView {
    if (loadingOverlay) {
        loadingOverlay.hidden = YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self attemptLogin];
    return YES;
}

@end
