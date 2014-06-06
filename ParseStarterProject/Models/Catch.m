//
//  Catch.m
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import "Catch.h"
#import <Parse/PFObject+Subclass.h>
#import "BSVote.h"

@implementation Catch

+ (NSString *)parseClassName {
    return @"Catch";
}

@dynamic length;
@dynamic weight;
@dynamic lengthMeasurement;
@dynamic weightMeasurement;
@dynamic baselineLength;
@dynamic baselineHeight;
@dynamic species;
@dynamic method;
@dynamic notes;
@dynamic rankedCatch;
@dynamic tellMyFriends;
@dynamic user;
@dynamic location;
@dynamic photo;
@dynamic BSCount;

+ (int)getBSCountLimit
{
    return 5;
}

- (BOOL)BSCountLimitReached
{
    if (self.BSCount == [Catch getBSCountLimit]) {
        return YES;
    }
    return NO;
}

- (BOOL)canCastBSVote
{
    // BSCount limit reached for Catch
    if ([self BSCountLimitReached]) {
        // Remove it from the Leaderboard if its ranked
        if (self.rankedCatch) {
            self.rankedCatch = NO;
            [self saveInBackground];
        }
        return NO;
    }
    
    // User is not logged in (must be)
    if ([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        return NO;
    }
    
    // User who owns catch cannot cast BS vote
    if (self.user != [PFUser currentUser]) {
        return YES;
    }
    
    return NO;
}

@end
