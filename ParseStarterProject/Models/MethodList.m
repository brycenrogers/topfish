//
//  MethodList.m
//  TopFish
//
//  Created by Brycen Rogers on 10/13/13.
//
//

#import "MethodList.h"

@implementation MethodList

// Returns a list of Fish objects with fish.species specified
+ (NSMutableArray *)getFlyFishingList {
    NSMutableArray *list = [[NSMutableArray alloc] initWithObjects:
                     @"Back Cast",
                     @"Forward Cast",
                     @"Tight Loop & Open Loop",
                     @"Roll Cast",nil];
    
    return list;
}

// Returns a list of Fish objects with fish.species specified
+ (NSMutableArray *)getSpinFishingList {
    NSMutableArray *list = [[NSMutableArray alloc] initWithObjects:
                            @"Bait Casting",
                            @"Bottom Bouncing",
                            @"Chumming",
                            @"Drift Fishing",
                            @"Jigging",
                            @"Jig and Worm",
                            @"Live Lining",
                            @"Spoons",
                            @"Spin Casting",
                            @"Still Fishing",
                            @"Surface Poppers",
                            @"Trolling",nil];
    
    return list;
}

@end
