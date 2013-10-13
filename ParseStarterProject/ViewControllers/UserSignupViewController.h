//
//  UserSignupViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 10/11/13.
//
//

#import <Parse/Parse.h>

@interface UserSignupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmField;

- (IBAction)signupButton:(UIButton *)sender;

@end