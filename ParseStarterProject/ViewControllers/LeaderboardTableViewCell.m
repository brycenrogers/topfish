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
        
        self.speciesLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 200, 30)];
        self.sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 25, 200, 30)];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.speciesLabel];
        [self.contentView addSubview:self.sizeLabel];
        
        self.backgroundColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:0.5f];
        
        //[self setGradient];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(20, 0, 88, 60);
}

- (void)setGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, 108, 85);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    gradient.opacity = 0.15;
    
    [self.contentView.layer insertSublayer:gradient atIndex:3];
}

- (void)drawPlacementBadgeWithNumber:(NSString *)placementNumber {
    
    UIView *badge = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 61)];
    badge.tag = 1;
    badge.backgroundColor = [UIColor whiteColor];
    
    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(2, 28, 15, 10)];
    NSAttributedString *num = [[NSAttributedString alloc] initWithString:placementNumber
                                                              attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Arial" size:12.0]}];

    number.attributedText = num;
    number.textAlignment = NSTextAlignmentCenter;
    
    [badge addSubview:number];
    [self.contentView insertSubview:badge atIndex:1];
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
