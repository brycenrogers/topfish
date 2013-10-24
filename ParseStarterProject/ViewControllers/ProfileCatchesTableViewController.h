//
//  ProfileCatchesTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import <Parse/Parse.h>
#import "Catch.h"

@interface ProfileCatchesTableViewController : PFQueryTableViewController
{
    Catch *selectedCatch;
}

@end
