//
//  LoadingView.h
//  TopFish
//
//  Created by Brycen Rogers on 10/16/13.
//
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property (nonatomic, strong) UIView *loadingOverlay;

- (void)showLoadingView;
- (void)hideLoadingView;

@end
