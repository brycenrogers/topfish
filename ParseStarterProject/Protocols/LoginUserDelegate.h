//
//  LoginUserDelegate.h
//  TopFish
//
//  Created by Brycen Rogers on 5/13/14.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol LoginUserDelegate <NSObject>

@property (strong, nonatomic) PFUser *loggedInUser;

@end
