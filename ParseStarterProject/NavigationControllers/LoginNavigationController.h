//
//  LoginNavigationController.h
//  TopFish
//
//  Created by Brycen Rogers on 5/15/14.
//
//

#import <UIKit/UIKit.h>
#import "ThemedNavigationController.h"
#import "LoginUserDelegate.h"

@interface LoginNavigationController : ThemedNavigationController

@property (nonatomic, weak) id<LoginUserDelegate> delegate;

@end
