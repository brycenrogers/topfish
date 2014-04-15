//
//  ThemedTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 11/3/13.
//
//

#import "ThemedTableViewController.h"

@interface ThemedTableViewController ()

@end

@implementation ThemedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorColor:self.tableView.backgroundColor = [UIColor colorWithRed:(183.0f/255.0f) green:(147.0f/255.0f) blue:(101.0f/255.0f) alpha:0.3f]];
    self.tableView.backgroundColor = [UIColor colorWithRed:(239.0f/255.0f) green:(236.0f/255.0f) blue:(225.0f/255.0f) alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
