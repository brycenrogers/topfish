//
//  ProfileNavigationController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import <UIKit/UIKit.h>
#import "ThemedNavigationController.h"
#import "CatchUpdatedNavigationControllerProtocol.h"

@interface ProfileNavigationController : ThemedNavigationController
<CatchUpdatedNavigationControllerProtocol>

@property (nonatomic) BOOL catchUpdated;

- (void)showCatchUpdatedMessage;
- (void)showCatchDeletedMessage;
- (void)showCatchReportedMessage;

@end
