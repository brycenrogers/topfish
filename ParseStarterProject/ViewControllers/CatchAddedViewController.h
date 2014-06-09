//
//  CatchAddedViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/2/13.
//
//

#import <UIKit/UIKit.h>
#import "Catch.h"
#import <Parse/Parse.h>
#import "ThemedViewController.h"

@interface CatchAddedViewController : ThemedViewController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) Catch *selectedCatch;
@property (strong, nonatomic) IBOutlet UILabel *speciesLabel;
@property (strong, nonatomic) IBOutlet PFImageView *catchImageView;

- (IBAction)viewCatchButton:(UIButton *)sender;
- (IBAction)addAnotherButton:(UIButton *)sender;

@end
