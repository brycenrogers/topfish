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
        
        [self.contentView addSubview:self.speciesLabel];
        [self.contentView addSubview:self.sizeLabel];
        [self addNumberOneBadgeView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, 320, 170);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)addNumberOneBadgeView {
    UIView *numOneView = [[UIView alloc] initWithFrame:CGRectMake(150, 5, 30, 30)];
    numOneView.backgroundColor = [UIColor redColor];
    self.numberOneView = numOneView;
    [self.contentView addSubview:self.numberOneView];
}

- (void)buildNumberOneBadge {
    // General Declarations
    
}

@end
