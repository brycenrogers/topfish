//
//  CatchTableViewCell.h
//  TopFish
//
//  Created by Brycen Rogers on 10/26/13.
//
//

#import <Parse/Parse.h>

@interface CatchTableViewCell : PFTableViewCell

@property (nonatomic, retain) UILabel *speciesLabel;
@property (nonatomic, retain) UILabel *sizeLabel;

@end
