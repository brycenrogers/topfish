//
//  LeaderboardNavigationController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/3/13.
//
//

#import <UIKit/UIKit.h>
#import "ThemedNavigationController.h"
#import "CatchUpdatedNavigationControllerProtocol.h"

@interface LeaderboardNavigationController : ThemedNavigationController
<CatchUpdatedNavigationControllerProtocol>

@property (nonatomic) BOOL catchUpdated;

- (void)showCatchUpdatedMessage;
- (void)showCatchDeletedMessage;
- (void)showCatchReportedMessage;
- (void)showCatchApprovedMessage;
- (void)showCatchRejectedMessage;

@end
