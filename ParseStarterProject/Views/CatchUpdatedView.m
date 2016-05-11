//
//  CatchUpdatedView.m
//  TopFish
//
//  Created by Brycen Rogers on 5/3/14.
//
//

#import "CatchUpdatedView.h"
#import "ThemeColors.h"

@implementation CatchUpdatedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CatchUpdatedView *)getView
{
    CatchUpdatedView *updatedView = [[CatchUpdatedView alloc] init];
    updatedView.backgroundColor = [ThemeColors orangeColor];
    updatedView.frame = CGRectMake(0, -64.0, 320.0, 64.0);
    updatedView.alpha = 0.5;
    UILabel *catchUpdatedLabel = [[UILabel alloc] init];
    catchUpdatedLabel.text = @"Catch Updated";
    catchUpdatedLabel.frame = CGRectMake(0.0, 10.0, updatedView.frame.size.width, updatedView.frame.size.height);
    catchUpdatedLabel.textAlignment = NSTextAlignmentCenter;
    catchUpdatedLabel.textColor = [UIColor whiteColor];
    [updatedView addSubview:catchUpdatedLabel];
    return updatedView;
}

+ (void)animateCatchUpdatedViewforView:(UIView *)view
{
    CatchUpdatedView *cv = [CatchUpdatedView getView];
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
