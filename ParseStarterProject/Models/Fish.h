//
//  Fish.h
//  TopFish
//
//  Created by Brycen Rogers on 9/22/13.
//
//

#import <Foundation/Foundation.h>

@interface Fish : NSObject

@property NSString *species;

+ (Fish *)initFishWithSpecies:(NSString *)speciesName;

@end
