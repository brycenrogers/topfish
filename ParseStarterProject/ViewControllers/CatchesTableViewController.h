//
//  ProfileCatchesTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import <Parse/Parse.h>
#import "Catch.h"
#import "ThemedPFQueryTableViewController.h"
#import "LoginUserDelegate.h"

@interface CatchesTableViewController : ThemedPFQueryTableViewController
<UITabBarControllerDelegate, UIScrollViewDelegate, LoginUserDelegate>

@property (nonatomic, strong) Catch *selectedCatch;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) PFUser *loggedInUser;
@property (nonatomic, strong) UILabel *noResultsLabel;
@property (nonatomic, strong) UILabel *addLabel;
@property (nonatomic) NSUInteger selectedTabBarIndex;
@property (nonatomic, strong) UIView *userInfoView;
@property (nonatomic, strong) UILabel *userInfoViewLabel;

@end