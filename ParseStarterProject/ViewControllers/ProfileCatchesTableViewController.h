//
//  ProfileCatchesTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 8/11/13.
//
//

#import <UIKit/UIKit.h>

@interface ProfileCatchesTableViewController : UITableViewController

@property (nonatomic) NSMutableArray *catches;
@property (weak, nonatomic) IBOutlet UITableView *catchesTable;

- (void)fetchCatchesData;

@end
