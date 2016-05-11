//
//  CatchesMapNavigationController.h
//  TopFish
//
//  Created by Brycen Rogers on 5/25/14.
//
//

#import <UIKit/UIKit.h>
#import "ThemedNavigationController.h"
#import "CatchUpdatedNavigationControllerProtocol.h"

@interface CatchesMapNavigationController : ThemedNavigationController<CatchUpdatedNavigationControllerProtocol>

@property (nonatomic) BOOL catchUpdated;

- (void)showCatchUpdatedMessage;
- (void)showCatchDeletedMessage;
- (void)showCatchReportedMessage;
- (void)showCatchApprovedMessage;
- (void)showCatchRejectedMessage;

@end
