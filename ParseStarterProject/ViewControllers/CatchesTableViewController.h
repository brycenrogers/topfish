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

@property (nonatomic, strong) Catch *selectedCatch;

@end