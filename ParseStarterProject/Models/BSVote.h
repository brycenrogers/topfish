//
//  BSVote.h
//  TopFish
//
//  Created by Brycen Rogers on 5/26/14.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Catch.h"

@interface BSVote : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) Catch *catch;
@property (retain) PFUser *user;

@end
