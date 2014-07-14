//
//  ReportedCatchesViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 7/13/14.
//
//

#import <Parse/Parse.h>
#import "ThemedPFQueryTableViewController.h"
#import "Catch.h"

@interface ReportedCatchesViewController : ThemedPFQueryTableViewController<UITabBarControllerDelegate>

@property (strong, nonatomic) Catch *selectedCatch;

@end
