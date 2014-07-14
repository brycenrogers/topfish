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
@dynamic score;
@dynamic species;
@dynamic method;
@dynamic notes;
@dynamic rankedCatch;
@dynamic tellMyFriends;
@dynamic user;
@dynamic location;
@dynamic photo;
@dynamic BSCount;
@dynamic reported;

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
    if (![self.user.objectId isEqualToString:[PFUser currentUser].objectId]) {
        return YES;
    }
    
    return NO;
}

+ (int)computeScoreForLength:(float)length
           lengthMeasurement:(NSString *)lengthMeasurement
                      weight:(float)weight
           weightMeasurement:(NSString *)weightMeasurement
{
    // Find Baseline measurements
    //
    // Baseline Length = cm
    // Baseline Weight = g
    
    float baselineLength = length;
    float baselineWeight = weight;
    
    if (![lengthMeasurement isEqualToString:@"in."]) {
        
        // Convert measurement to centimeters
        if ([lengthMeasurement isEqualToString:@"cm."]) {
            baselineLength = length / 2.54; // 2.54 cm in 1 inch
        }
    }
    
    if (![weightMeasurement isEqualToString:@"lbs."]) {
        
        // Convert measurement to grams
        if ([weightMeasurement isEqualToString:@"oz."]) {
            baselineWeight = weight / 16.0;
        } else if ([weightMeasurement isEqualToString:@"g."]) {
            baselineWeight = weight / 453.592;
        }
    }
    
    if (baselineWeight == 0) {
        baselineWeight = 1;
    }
    
    if (baselineLength == 0) {
        baselineLength = 1;
    }
    
    // Now that baselines are set, calculate score
    // score = (baseline length * 5) + (baseline weight * 2) * 0.01
    
    float score = ((baselineLength * 5.0) + (baselineWeight * 2.0));
    
    float scoreTruncated = [[NSString stringWithFormat:@"%.3f",score]floatValue];
    
    return scoreTruncated;
}

@end
