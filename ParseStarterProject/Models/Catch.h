//
//  Catch.h
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import <Parse/Parse.h>

@interface Catch : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property int length;
@property int weight;
@property (retain) NSString *lengthMeasurement;
@property (retain) NSString *weightMeasurement;
@property int baselineLength;
@property int baselineHeight;
@property (retain) NSString *species;
@property (retain) NSString *method;
@property (retain) NSString *notes;
@property BOOL rankedCatch;
@property BOOL tellMyFriends;
@property (retain) PFUser *user;
@property (retain) PFGeoPoint *location;
@property (retain) PFFile *photo;
@property int BSCount;

- (BOOL)BSCountLimitReached;
- (BOOL)canCastBSVote;

+ (int)getBSCountLimit;

@end
