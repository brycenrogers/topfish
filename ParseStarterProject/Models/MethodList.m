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
                     @"Nymphing (Dead Drift)",
                     @"Nymphing (Active Retrieve)",
                     @"Streamer",
                     @"Surface / Dry Fly",nil];
    
    return list;
}

// Returns a list of Fish objects with fish.species specified
+ (NSMutableArray *)getSpinFishingList {
    NSMutableArray *list = [[NSMutableArray alloc] initWithObjects:
                            @"Still Fishing",
                            @"Trolling",
                            @"Casting",
                            @"Jigging",nil];
    
    return list;
}

@end
