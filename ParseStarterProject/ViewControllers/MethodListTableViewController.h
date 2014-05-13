//
//  MethodListTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 10/12/13.
//
//

#import <UIKit/UIKit.h>
#import "MethodList.h"
#import "ThemedTableViewController.h"

@interface MethodListTableViewController : ThemedTableViewController

@property (nonatomic, strong) NSMutableArray *flyFishingMethodList;
@property (nonatomic, strong) NSMutableArray *spinFishingMethodList;
@property id<MethodListSelector> delegate;

- (IBAction)clearButton:(UIBarButtonItem *)sender;

@end