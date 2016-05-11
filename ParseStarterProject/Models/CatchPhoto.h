//
//  CatchPhoto.h
//  TopFish
//
//  Created by Brycen Rogers on 9/2/13.
//
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import "Catch.h"

@interface CatchPhoto : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) PFFile *photo;

@end
