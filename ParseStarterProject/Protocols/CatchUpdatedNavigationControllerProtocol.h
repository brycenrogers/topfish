//
//  CatchUpdatedNavigationControllerProtocol.h
//  TopFish
//
//  Created by Brycen Rogers on 4/30/14.
//
//

#import <Foundation/Foundation.h>

@protocol CatchUpdatedNavigationControllerProtocol <NSObject>

@property (nonatomic) BOOL catchUpdated;

- (void)showCatchUpdatedMessage;
- (void)showCatchDeletedMessage;
- (void)showCatchReportedMessage;

@end
