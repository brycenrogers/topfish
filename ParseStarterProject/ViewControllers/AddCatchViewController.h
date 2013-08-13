//
//  AddCatchViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import <UIKit/UIKit.h>
#import "AddCatchInfoTableViewController.h"

@interface AddCatchViewController : UIViewController

@property (nonatomic, retain) AddCatchInfoTableViewController *addCatchInfo;

- (IBAction)startWithInfoButton:(UIButton *)sender;

@end
