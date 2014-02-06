//
//  WidthMeasurementOptionsViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/22/13.
//
//

#import "WeightMeasurementOptionsTableViewController.h"

@interface WeightMeasurementOptionsTableViewController ()

@end

@implementation WeightMeasurementOptionsTableViewController

@synthesize delegate;

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
        self.delegate.selectedWeightMeasurementLabel.text = @"g.";
    }
    if (sec == 0 && row == 1) {
        self.delegate.selectedWeightMeasurementLabel.text = @"oz.";
    }
    if (sec == 0 && row == 2) {
        self.delegate.selectedWeightMeasurementLabel.text = @"lbs.";
    }
    [self.navigationController popToViewController:(UIViewController *)self.delegate animated:YES];
}

@end
