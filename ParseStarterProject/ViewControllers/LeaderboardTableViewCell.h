//
//  LeaderboardTableViewCell.h
//  TopFish
//
//  Created by Brycen Rogers on 10/20/13.
//
//

#import <Parse/Parse.h>
#import "Catch.h"

@interface LeaderboardTableViewCell : PFTableViewCell

@property (nonatomic, retain) NSString *placementString;
@property (nonatomic, retain) UILabel *speciesLabel;
@property (nonatomic, retain) UILabel *sizeLabel;

- (void)drawPlacementBadgeWithNumber:(NSString *)placementNumber;

@end
