//
//  CatchRejectedView.m
//  TopFish
//
//  Created by Brycen Rogers on 7/14/14.
//
//

#import "CatchRejectedView.h"
#import "ThemeColors.h"

@implementation CatchRejectedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CatchRejectedView *)getView
{
    CatchRejectedView *catchRejectedView = [[CatchRejectedView alloc] init];
    catchRejectedView.backgroundColor = [ThemeColors redColor];
    catchRejectedView.frame = CGRectMake(0, -64.0, 320.0, 64.0);
    catchRejectedView.alpha = 0.5;
    UILabel *catchRejectedLabel = [[UILabel alloc] init];
    catchRejectedLabel.text = @"Catch Rejected & Deleted";
    catchRejectedLabel.frame = CGRectMake(0.0, 10.0, catchRejectedView.frame.size.width, catchRejectedView.frame.size.height);
    catchRejectedLabel.textAlignment = NSTextAlignmentCenter;
    catchRejectedLabel.textColor = [UIColor whiteColor];
    [catchRejectedView addSubview:catchRejectedLabel];
    return catchRejectedView;
}

+ (void)animateCatchRejectedViewforView:(UIView *)view
{
    CatchRejectedView *cv = [self getView];
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
