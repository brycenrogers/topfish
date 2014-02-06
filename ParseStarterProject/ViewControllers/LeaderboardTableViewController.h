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
#import "ThemedPFQueryTableViewController.h"
#import "FishingFilterProtocol.h"

@interface LeaderboardTableViewController : ThemedPFQueryTableViewController<FishingFilterProtocol>
{
    UIView *loadingOverlay;
    BOOL numberOneSet;
}

@property (nonatomic, strong) Catch *selectedCatch;
@property (nonatomic, strong) NSString *selectedSpeciesFilter;
@property (nonatomic, strong) NSString *selectedMethodFilter;

- (void)updateLeaderboardWithFilter;

@end
