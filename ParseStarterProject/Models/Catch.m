//
//  Catch.m
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import "Catch.h"
#import <Parse/PFObject+Subclass.h>

@implementation Catch

+ (NSString *)parseClassName {
    return @"Catch";
}

@dynamic length;
@dynamic weight;
@dynamic lengthMeasurement;
@dynamic weightMeasurement;
@dynamic species;
@dynamic method;
@dynamic notes;
@dynamic rankedCatch;
@dynamic tellMyFriends;
@dynamic user;
@dynamic location;
@dynamic photo;

@end
