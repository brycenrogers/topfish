//
//  CatchTableViewCell.m
//  TopFish
//
//  Created by Brycen Rogers on 10/26/13.
//
//

#import "CatchTableViewCell.h"

@implementation CatchTableViewCell

@synthesize speciesLabel, sizeLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.speciesLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 220, 30)];
        self.sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 220, 30)];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.speciesLabel];
        [self.contentView addSubview:self.sizeLabel];
        
        [self setGradient];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, 88, 60);
}

- (void)setGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, 88, 85);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    gradient.opacity = 0.15;
    
    [self.contentView.layer insertSublayer:gradient atIndex:3];
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
