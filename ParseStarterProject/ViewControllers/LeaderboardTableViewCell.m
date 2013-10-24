//
//  LeaderboardTableViewCell.m
//  TopFish
//
//  Created by Brycen Rogers on 10/20/13.
//
//

#import "LeaderboardTableViewCell.h"

@implementation LeaderboardTableViewCell

@synthesize sizeLabel, speciesLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.speciesLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 220, 30)];
        self.sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 220, 30)];
        
        [self.contentView addSubview:self.speciesLabel];
        [self.contentView addSubview:self.sizeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
