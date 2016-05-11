//
//  UserFlaggedNotification.h
//  TopFish
//
//  Created by Brycen Rogers on 7/12/14.
//
//

#import <Parse/Parse.h>
#import "Catch.h"

@interface UserReportedNotification : PFObject<PFSubclassing>

@property (retain) PFUser *userWhoReported;
@property (retain) PFUser *user;
@property (retain) Catch *reportedCatch;

+ (NSString *)parseClassName;

+ (BOOL)canReportCatch:(Catch *)reportedCatch;
+ (BOOL)canViewReportedCatches;

+ (NSDictionary *)reportedCatchEmailInfo:(Catch *)reportedCatch;
+ (NSDictionary *)reportedUserEmailInfo:(PFUser *)reportedUser;

@end
