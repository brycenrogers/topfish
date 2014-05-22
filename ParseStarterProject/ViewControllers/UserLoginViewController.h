//
//  UserLoginViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 10/11/13.
//
//

#import <Parse/Parse.h>
#import "LoginUserDelegate.h"

@interface UserLoginViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>
{
    UIViewController *signupVC;
    UIView *loadingOverlay;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) id<LoginUserDelegate> delegate;

- (IBAction)loginButton:(UIButton *)sender;
- (IBAction)signupButton:(UIButton *)sender;
- (IBAction)forgotPasswordButton:(UIButton *)sender;
- (IBAction)cancelButton:(UIBarButtonItem *)sender;

@end