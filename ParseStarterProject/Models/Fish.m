//
//  Fish.m
//  TopFish
//
//  Created by Brycen Rogers on 9/22/13.
//
//

#import "Fish.h"

@implementation Fish

@synthesize species;

+ (Fish *)initFishWithSpecies:(NSString *)speciesName {
    Fish *newFish = [[self alloc] init];
    newFish.species = speciesName;
    return newFish;
}

@end
