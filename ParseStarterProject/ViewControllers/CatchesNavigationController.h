//
//  CatchesNavigationController.h
//  TopFish
//
//  Created by Brycen Rogers on 10/23/13.
//
//

#import <UIKit/UIKit.h>
#import "ThemedNavigationController.h"
#import "CatchUpdatedNavigationControllerProtocol.h"
#import "LoginUserDelegate.h"

@interface CatchesNavigationController : ThemedNavigationController
<CatchUpdatedNavigationControllerProtocol, LoginUserDelegate>

@property (nonatomic) BOOL catchUpdated;
@property (nonatomic, strong) PFUser *loggedInUser;
@property (nonatomic) BOOL doNotUpdateView;

- (void)showCatchUpdatedMessage;
- (void)showCatchDeletedMessage;
- (void)showCatchReportedMessage;
- (void)showCatchApprovedMessage;
- (void)showCatchRejectedMessage;

@end
