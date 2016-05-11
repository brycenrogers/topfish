//
//  AddCatchNavigationControllerViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/2/13.
//
//

#import <UIKit/UIKit.h>
#import "ThemedNavigationController.h"
#import "CatchUpdatedNavigationControllerProtocol.h"

@interface AddCatchNavigationController : ThemedNavigationController
<CatchUpdatedNavigationControllerProtocol>

@property BOOL catchAdded;
@property (nonatomic) BOOL catchUpdated;

- (void)showCatchUpdatedMessage;
- (void)showCatchDeletedMessage;
- (void)showCatchReportedMessage;
- (void)showCatchApprovedMessage;
- (void)showCatchRejectedMessage;

@end
