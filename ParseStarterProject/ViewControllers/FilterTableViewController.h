//
//  FilterTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 10/12/13.
//
//

#import <UIKit/UIKit.h>
#import "SpeciesList.h"
#import "MethodList.h"

@interface FilterTableViewController : UITableViewController
<SpeciesListSelector, MethodListSelector>

@property id delegate;
@property (weak, nonatomic) IBOutlet UILabel *selectedSpeciesLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedMethodLabel;

@end
