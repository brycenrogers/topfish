//
//  LeaderboardTableViewCell.m
//  TopFish
//
//  Created by Brycen Rogers on 10/20/13.
//
//

#import "LeaderboardTableViewCell.h"

@implementation LeaderboardTableViewCell

@synthesize sizeLabel, speciesLabel, placementString;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.speciesLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 190, 30)];
        self.sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 25, 190, 30)];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.speciesLabel];
        [self.contentView addSubview:self.sizeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(30, 0, 88, 60);
}

- (void)setGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, 118, 85);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    gradient.opacity = 0.15;
    
    [self.contentView.layer insertSublayer:gradient atIndex:2];
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
