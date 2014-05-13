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

@interface CatchesTableViewController : ThemedPFQueryTableViewController
<UITabBarControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) Catch *selectedCatch;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) UILabel *noResultsLabel;
@property (nonatomic, strong) UILabel *addLabel;
@property (nonatomic, strong) UILabel *loginLabel;
@property (nonatomic, weak) UIButton *loginButton;
@property (nonatomic) NSUInteger selectedTabBarIndex;
@property (nonatomic, strong) UIView *userInfoView;
@property (nonatomic, strong) UILabel *userInfoViewLabel;

- (void)clickLoginButton:(UIButton *)sender;

@end