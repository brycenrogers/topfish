//
//  LengthMeasurementOptionsTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/21/13.
//
//

#import "LengthMeasurementOptionsTableViewController.h"

@interface LengthMeasurementOptionsTableViewController ()

@end

@implementation LengthMeasurementOptionsTableViewController

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
        self.delegate.selectedLengthMeasurementLabel.text = @"in.";
    }
    if (sec == 0 && row == 1) {
        self.delegate.selectedLengthMeasurementLabel.text = @"cm.";
    }
    [self.navigationController popToViewController:(UIViewController *)self.delegate animated:YES];
}

@end
