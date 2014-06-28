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

@property float length;
@property float weight;
@property (retain) NSString *lengthMeasurement;
@property (retain) NSString *weightMeasurement;
@property float score;
@property (retain) NSString *species;
@property (retain) NSString *method;
@property (retain) NSString *notes;
@property BOOL rankedCatch;
@property BOOL tellMyFriends;
@property (retain) PFUser *user;
@property (retain) PFGeoPoint *location;
@property (retain) PFFile *photo;
@property int BSCount;
@property BOOL flagged;

- (BOOL)BSCountLimitReached;
- (BOOL)canCastBSVote;

+ (int)getBSCountLimit;
+ (int)computeScoreForLength:(float)length
           lengthMeasurement:(NSString *)lengthMeasurement
                      weight:(float)weight
           weightMeasurement:(NSString *)weightMeasurement;

@end
