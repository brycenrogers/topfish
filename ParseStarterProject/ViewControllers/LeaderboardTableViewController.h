//
//  LeaderboardTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import <Parse/Parse.h>
#import "Catch.h"
#import "LoadingView.h"

@interface LeaderboardTableViewController : PFQueryTableViewController
{
    UIView *loadingOverlay;
    BOOL numberOneSet;
}

@property (nonatomic, strong) Catch *selectedCatch;
@property (nonatomic, weak) NSString *selectedSpeciesFilter;
@property (nonatomic, weak) NSString *selectedMethodFilter;

@end
