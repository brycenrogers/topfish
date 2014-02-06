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
#import "AllMethodsSwitch.h"
#import "FishingFilterProtocol.h"

@interface FilterTableViewController : UITableViewController
<SpeciesListSelector, MethodListSelector>

@property id<FishingFilterProtocol> delegate;
@property (weak, nonatomic) IBOutlet UILabel *selectedSpeciesLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedMethodLabel;
@property (weak, nonatomic) IBOutlet UISwitch *allMethodsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *allSpeciesSwitch;

@end
