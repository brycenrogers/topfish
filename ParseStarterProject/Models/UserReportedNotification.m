//
//  UserFlaggedNotification.m
//  TopFish
//
//  Created by Brycen Rogers on 7/12/14.
//
//

#import "UserReportedNotification.h"
#import <Parse/PFObject+Subclass.h>

@implementation UserReportedNotification

+ (NSString *)parseClassName {
    return @"UserReportedNotification";
}

@dynamic userWhoReported;
@dynamic user;
@dynamic reportedCatch;

+ (BOOL)canReportCatch:(Catch *)reportedCatch
{
    // If current user is anonymous, they cannot report a catch
    if ([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        return NO;
    }
    // Users cannot report their own catches
    PFUser *currentUser = [PFUser currentUser];
    if ([currentUser.username isEqualToString:reportedCatch.user.username]) {
        return NO;
    }
    return YES;
}

+ (BOOL)canViewReportedCatches
{
    // Anonymous users can't view them
    if ([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        return NO;
    }
    // Only specific users can edit catches
    PFUser *currentUser = [PFUser currentUser];
    if ([currentUser.objectId isEqualToString:@"w3y3hJZpxJ"]) {
        return YES;
    }
    return NO;
}

+ (NSDictionary *)reportedCatchEmailInfo:(Catch *)reportedCatch
{
    NSString *bodyText = [NSString stringWithFormat:@"Catch ID: %@", reportedCatch.objectId];
    
    NSDictionary *emailInfo = @{@"toEmail": @"brycenrogers@gmail.com",
                                @"toName": @"Brycen Rogers",
                                @"fromEmail": @"report@topfishapp.com",
                                @"fromName": @"TopFish Reported Catch",
                                @"subject": @"TopFish Inappropriate Catch Reported",
                                @"text": bodyText};
    
    return emailInfo;
}

@end
