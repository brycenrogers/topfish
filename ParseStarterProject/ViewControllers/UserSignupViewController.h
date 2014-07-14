//
//  UserSignupViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 10/11/13.
//
//

#import <Parse/Parse.h>
#import "ThemedViewController.h"

@interface UserSignupViewController : ThemedViewController<UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmField;
@property (strong, nonatomic) UIView *loadingOverlay;
@property (strong, nonatomic) UIToolbar *keyboardDoneView;

- (IBAction)signupButton:(UIButton *)sender;

@end