//
//  UserLoginViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 10/11/13.
//
//

#import <Parse/Parse.h>

@interface UserLoginViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>
{
    UIViewController *signupVC;
    UIView *loadingOverlay;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginButton:(UIButton *)sender;
- (IBAction)signupButton:(UIButton *)sender;
- (IBAction)forgotPasswordButton:(UIButton *)sender;
- (IBAction)cancelButton:(UIBarButtonItem *)sender;

@end