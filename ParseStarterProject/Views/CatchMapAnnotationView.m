//
//  CatchMapAnnotationView.m
//  TopFish
//
//  Created by Brycen Rogers on 5/18/14.
//
//

#import "CatchMapAnnotationView.h"

@implementation CatchMapAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self showDetails];
    }
    return self;
}

- (void)showDetails
{
    UILabel *lbl = [UILabel new];
    lbl.text = @"Test";
    [self addSubview:lbl];
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
