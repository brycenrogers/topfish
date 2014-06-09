//
//  ThemedTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 11/3/13.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ThemedPFQueryTableViewController : PFQueryTableViewController

@property (nonatomic, strong) UIImageView *iconImage;

- (void)setSeparatorColor;
- (void)setBackgroundColor;

@end
