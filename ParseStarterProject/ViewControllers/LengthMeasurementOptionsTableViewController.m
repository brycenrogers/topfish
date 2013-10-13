//
//  LengthMeasurementOptionsTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/21/13.
//
//

#import "LengthMeasurementOptionsTableViewController.h"
#import "AddCatchInfoTableViewController.h"

@interface LengthMeasurementOptionsTableViewController ()

@end

@implementation LengthMeasurementOptionsTableViewController

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
    UITabBarController *customTabBar = (UITabBarController *)self.presentingViewController;
    UINavigationController *navigationController = (UINavigationController *)[customTabBar.viewControllers objectAtIndex:2];
    parentVC = (AddCatchInfoTableViewController *)[navigationController.viewControllers objectAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    int sec = indexPath.section;
    if (sec == 0 && row == 0) {
        [self selectInches];
    }
    if (sec == 0 && row == 1) {
        [self selectCentimeters];
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)selectInches {
    // Set the selected option to 'inches' for the parent VC
    parentVC.lengthMeasurementField.text = @"in.";
}

- (void)selectCentimeters {
    // Set the selected option to 'centimeters' for the parent VC
    parentVC.lengthMeasurementField.text = @"cm.";
}

@end
