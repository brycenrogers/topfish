//
//  WidthMeasurementOptionsViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/22/13.
//
//

#import "WeightMeasurementOptionsTableViewController.h"
#import "AddCatchInfoTableViewController.h"

@interface WeightMeasurementOptionsTableViewController ()

@end

@implementation WeightMeasurementOptionsTableViewController

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
        [self selectGrams];
    }
    if (sec == 0 && row == 1) {
        [self selectOunces];
    }
    if (sec == 0 && row == 2) {
        [self selectPounds];
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)selectGrams {
    // Set the selected option to 'inches' for the parent VC
    parentVC.weightMeasurementField.text = @"g.";
}

- (void)selectOunces {
    // Set the selected option to 'centimeters' for the parent VC
    parentVC.weightMeasurementField.text = @"oz.";
}

- (void)selectPounds {
    // Set the selected option to 'centimeters' for the parent VC
    parentVC.weightMeasurementField.text = @"lbs.";
}

@end
