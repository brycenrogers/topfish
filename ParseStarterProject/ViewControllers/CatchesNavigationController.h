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

@interface CatchesNavigationController : ThemedNavigationController
<CatchUpdatedNavigationControllerProtocol>

@property (nonatomic) BOOL catchUpdated;

- (void)showCatchUpdatedMessage;

@end
