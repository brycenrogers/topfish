//
//  SpeciesList.m
//  TopFish
//
//  Created by Brycen Rogers on 9/22/13.
//
//

#import "SpeciesList.h"
#import "Fish.h"

@implementation SpeciesList

// Returns a list of Fish objects with fish.species specified
+ (NSMutableArray *)getList {
    NSArray *list = [[NSMutableArray alloc] initWithObjects:
                     @"Barbel",
                     @"Bass, Australian",
                     @"Bass, Black",
                     @"Bass, Guadalupe",
                     @"Bass, Hybrid Striped",
                     @"Bass, Largemouth",
                     @"Bass, Peacock",
                     @"Bass, Rock",
                     @"Bass, Shoal",
                     @"Bass, Smallmouth",
                     @"Bass, Spotted",
                     @"Bass, Spotted Tail",
                     @"Bass, White",
                     @"Bass, Yellow",
                     @"Bluegill",
                     @"Buffalo, Bigmouth",
                     @"Buffalo, Smallmouth",
                     @"Bullhead, Black",
                     @"Bullhead, Brown",
                     @"Bullhead, Yellow",
                     @"Carp, Common",
                     @"Catfish, Blue",
                     @"Catfish, Channel",
                     @"Catfish, Flathead",
                     @"Char, Arctic",
                     @"Cowcod (Cow Cod)",
                     @"Crappie, Black",
                     @"Crappie, White",
                     @"Dolly Varden",
                     @"Drum, Freshwater",
                     @"Eel, American",
                     @"Eel, Short-finned",
                     @"Flounder, Starry",
                     @"Goldeye",
                     @"Grayling, Arctic",
                     @"Muskellunge (Muskie)",
                     @"Muskellunge (Muskie), Tiger",
                     @"Panfish",
                     @"Perch, European (English) (Redfin)",
                     @"Perch, White",
                     @"Perch, Yellow",
                     @"Pike, Northern",
                     @"Redfish (Red Drum)",
                     @"Rockfish, Bank",
                     @"Rockfish, Black",
                     @"Salmon, Atlantic",
                     @"Salmon, Chinook",
                     @"Salmon, Chum",
                     @"Salmon, Coho",
                     @"Salmon, Kokanee",
                     @"Salmon, Pink",
                     @"Salmon, Sockeye",
                     @"Sauger",
                     @"Saugeye",
                     @"Shad, American",
                     @"Shad, Hickory",
                     @"Shark, Bull",
                     @"Sheephead, California",
                     @"Snapper, Mangrove",
                     @"Snook",
                     @"Splake",
                     @"Steelhead",
                     @"Stingray",
                     @"Sturgeon, Green",
                     @"Sturgeon, Lake",
                     @"Sturgeon, Shovelnose",
                     @"Sturgeon, White",
                     @"Sunfish",
                     @"Taimen",
                     @"Trout, Apache",
                     @"Trout, Brook",
                     @"Trout, Brown",
                     @"Trout, Bull",
                     @"Trout, Cutbow",
                     @"Trout, Cutthroat",
                     @"Trout, Golden",
                     @"Trout, Lake",
                     @"Trout, Rainbow",
                     @"Trout, Tiger",
                     @"Walleye",
                     @"Warmouth",
                     @"Whitefish, Lake",nil];
    
    NSMutableArray *speciesList = [[NSMutableArray alloc] init];
    
    for (id species in list) {
        [speciesList addObject:[Fish initFishWithSpecies:(NSString *)species]];
    }
    
    return speciesList;
}

@end
