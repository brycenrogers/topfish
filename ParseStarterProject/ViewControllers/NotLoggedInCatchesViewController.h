//
//  NotLoggedInCatchesViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 5/15/14.
//
//

#import <UIKit/UIKit.h>
#import "ThemedViewController.h"
#import "LoginUserDelegate.h"

@interface NotLoggedInCatchesViewController : ThemedViewController<LoginUserDelegate>

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UILabel *loginLabel;
@property (nonatomic, strong) PFUser *loggedInUser;

@end
