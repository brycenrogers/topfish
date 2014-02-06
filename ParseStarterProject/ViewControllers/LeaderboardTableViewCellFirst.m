//
//  LeaderboardTableViewCellFirst.m
//  TopFish
//
//  Created by Brycen Rogers on 10/20/13.
//
//

#import "LeaderboardTableViewCellFirst.h"
#import "Catch.h"
#import <QuartzCore/QuartzCore.h>

@implementation LeaderboardTableViewCellFirst

@synthesize numberOneView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.speciesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 115, 300, 30)];
        self.sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 135, 300, 30)];
        
        self.speciesLabel.shadowColor = [UIColor blackColor];
        self.sizeLabel.shadowColor = [UIColor blackColor];
        
        [self.contentView insertSubview:self.speciesLabel atIndex:3];
        [self.contentView insertSubview:self.sizeLabel atIndex:3];
        
        [self addNumberOneBadgeView];
        [self setGradient];
    }
    return self;
}

- (void)drawPlacementBadge {
    return;
}

- (void)setGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 85, 320, 85);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    gradient.opacity = 0.5;
    
    [self.contentView.layer insertSublayer:gradient atIndex:1];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, 320, 170);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)addNumberOneBadgeView {
    UIImageView *numOneView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 114)];
    numOneView.image = [UIImage imageNamed:@"first-place-badge.png"];
    self.numberOneView = numOneView;
    [self.contentView addSubview:self.numberOneView];
}

- (void)buildNumberOneBadge {
    // General Declarations
    
}

@end
