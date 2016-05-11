//
//  BSVote.m
//  TopFish
//
//  Created by Brycen Rogers on 5/26/14.
//
//

#import "BSVote.h"
#import <Parse/PFObject+Subclass.h>

@implementation BSVote

+ (NSString *)parseClassName {
    return @"BSVote";
}

@dynamic catch;
@dynamic user;

@end
