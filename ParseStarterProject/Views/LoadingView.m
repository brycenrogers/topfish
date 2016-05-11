//
//  LoadingView.m
//  TopFish
//
//  Created by Brycen Rogers on 10/16/13.
//
//

#import "LoadingView.h"

@implementation LoadingView

@synthesize loadingOverlay;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

- (void)showLoadingView {
    if (!self.loadingOverlay) {
        UIView *loadingOverlayView = [[UIView alloc] initWithFrame:self.frame];
        loadingOverlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:.75];
        loadingOverlay = loadingOverlayView;
        
        UIActivityIndicatorView *aIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        aIV.frame = CGRectMake(0, 0, loadingOverlay.frame.size.width, loadingOverlay.frame.size.height);
        [aIV startAnimating];
        [loadingOverlay addSubview:aIV];
        
        [self.window addSubview:loadingOverlayView];
    } else {
        loadingOverlay.hidden = NO;
    }
}

- (void)hideLoadingView {
    if (self.loadingOverlay) {
        self.loadingOverlay.hidden = YES;
    }
}

@end
