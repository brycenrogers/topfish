//
//  CatchApprovedView.m
//  TopFish
//
//  Created by Brycen Rogers on 7/14/14.
//
//

#import "CatchApprovedView.h"
#import "ThemeColors.h"

@implementation CatchApprovedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CatchApprovedView *)getView
{
    CatchApprovedView *approvedView = [[CatchApprovedView alloc] init];
    approvedView.backgroundColor = [ThemeColors greenColor];
    approvedView.frame = CGRectMake(0, -64.0, 320.0, 64.0);
    approvedView.alpha = 0.5;
    UILabel *catchApprovedLabel = [[UILabel alloc] init];
    catchApprovedLabel.text = @"Catch Approved";
    catchApprovedLabel.frame = CGRectMake(0.0, 10.0, approvedView.frame.size.width, approvedView.frame.size.height);
    catchApprovedLabel.textAlignment = NSTextAlignmentCenter;
    catchApprovedLabel.textColor = [UIColor whiteColor];
    [approvedView addSubview:catchApprovedLabel];
    return approvedView;
}

+ (void)animateCatchApprovedViewforView:(UIView *)view
{
    CatchApprovedView *cv = [CatchApprovedView getView];
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
