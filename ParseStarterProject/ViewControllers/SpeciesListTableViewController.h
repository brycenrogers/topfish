//
//  SpeciesListTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/22/13.
//
//

#import <UIKit/UIKit.h>
#import "AddCatchInfoTableViewController.h"
#import "SpeciesList.h"

@interface SpeciesListTableViewController : UITableViewController

@property NSMutableArray *speciesList;
@property (nonatomic, assign) id<SpeciesListSelector> delegate;

@end