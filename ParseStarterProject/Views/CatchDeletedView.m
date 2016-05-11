//
//  CatchDeletedView.m
//  TopFish
//
//  Created by Brycen Rogers on 6/11/14.
//
//

#import "CatchDeletedView.h"
#import "ThemeColors.h"

@implementation CatchDeletedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CatchDeletedView *)getView
{
    CatchDeletedView *voteCastView = [[CatchDeletedView alloc] init];
    voteCastView.backgroundColor = [ThemeColors redColor];
    voteCastView.frame = CGRectMake(0, -64.0, 320.0, 64.0);
    voteCastView.alpha = 0.5;
    UILabel *catchUpdatedLabel = [[UILabel alloc] init];
    catchUpdatedLabel.text = @"Catch Deleted";
    catchUpdatedLabel.frame = CGRectMake(0.0, 10.0, voteCastView.frame.size.width, voteCastView.frame.size.height);
    catchUpdatedLabel.textAlignment = NSTextAlignmentCenter;
    catchUpdatedLabel.textColor = [UIColor whiteColor];
    [voteCastView addSubview:catchUpdatedLabel];
    return voteCastView;
}

+ (void)animateCatchDeletedViewforView:(UIView *)view
{
    CatchDeletedView *cv = [self getView];
    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        cv.frame = CGRectMake(0, 0, 320, 64);
        cv.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            cv.frame = CGRectMake(0, -64, 320, 64);
            cv.alpha = 0.5;
        } completion:^(BOOL finished) {
        }];
    }];
    [view addSubview:cv];
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
