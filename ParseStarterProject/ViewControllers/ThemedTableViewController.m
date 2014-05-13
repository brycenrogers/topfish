//
//  ThemedTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 11/3/13.
//
//

#import "ThemedTableViewController.h"
#import "ThemeColors.h"

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
    [self setSeparatorColor];
    [self setBackgroundColor];
    self.view.tintColor = [ThemeColors blueColor];
}

- (void)setSeparatorColor {
    [self.tableView setSeparatorColor:[UIColor colorWithRed:(183.0f/255.0f) green:(147.0f/255.0f) blue:(101.0f/255.0f) alpha:0.3f]];
}

- (void)setBackgroundColor {
    self.tableView.backgroundColor = [ThemeColors backgroundImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
