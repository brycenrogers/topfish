//
//  CatchReportedView.m
//  TopFish
//
//  Created by Brycen Rogers on 7/12/14.
//
//

#import "CatchReportedView.h"
#import "ThemeColors.h"

@implementation CatchReportedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CatchReportedView *)getView
{
    CatchReportedView *catchReportedView = [[CatchReportedView alloc] init];
    catchReportedView.backgroundColor = [ThemeColors redColor];
    catchReportedView.frame = CGRectMake(0, -64.0, 320.0, 64.0);
    catchReportedView.alpha = 0.5;
    UILabel *catchReportedLabel = [[UILabel alloc] init];
    catchReportedLabel.text = @"Catch Reported!";
    catchReportedLabel.frame = CGRectMake(0.0, 10.0, catchReportedView.frame.size.width, catchReportedView.frame.size.height);
    catchReportedLabel.textAlignment = NSTextAlignmentCenter;
    catchReportedLabel.textColor = [UIColor whiteColor];
    [catchReportedView addSubview:catchReportedLabel];
    return catchReportedView;
}

+ (void)animateCatchReportedViewforView:(UIView *)view
{
    CatchReportedView *cv = [self getView];
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
