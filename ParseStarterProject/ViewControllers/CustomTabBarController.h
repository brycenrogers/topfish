//
//  CustomTabBarController.h
//  TopFish
//
//  Created by Brycen Rogers on 8/24/13.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CustomTabBarController : UITabBarController<PFLogInViewControllerDelegate>

// Create a view controller and setup it's tab bar item with a title and image
- (UIViewController*)viewControllerWithTabTitle:(NSString*)title image:(UIImage*)image;

// Create a custom UIButton and add it to the center of our tab bar
- (void)addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage;

@end