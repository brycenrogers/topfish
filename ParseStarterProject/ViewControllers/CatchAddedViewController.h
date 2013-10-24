//
//  CatchAddedViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/2/13.
//
//

#import <UIKit/UIKit.h>
#import "Catch.h"

@interface CatchAddedViewController : UIViewController

@property (nonatomic, strong) Catch *selectedCatch;

- (IBAction)ViewProfileButton:(UIButton *)sender;
- (IBAction)ViewLeaderboardButton:(UIButton *)sender;
- (IBAction)viewCatchButton:(UIButton *)sender;

@end
