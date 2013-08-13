//
//  AddCatchInfoViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import "AddCatchInfoTableViewController.h"
#import "EAActionSheetPicker.h"
#import "Catch.h"
#import <QuartzCore/QuartzCore.h>

@interface AddCatchInfoTableViewController ()
@end

@implementation AddCatchInfoTableViewController

@synthesize lengthMeasurementField, weightMeasurementField, catchNameField, catchLengthField, catchWeightField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupPickers];
    catchNameField.delegate = self;
    catchLengthField.delegate = self;
    catchWeightField.delegate = self;
}

- (void)setupPickers {
    NSArray *lengthMeasurements = [[NSArray alloc]
                                   initWithObjects:@"in.", @"cm.", nil];
    EAActionSheetPicker *lengthActionPicker = [[EAActionSheetPicker alloc]
                                               initWithOptions:lengthMeasurements];
    
    lengthActionPicker.textField = self.lengthMeasurementField;
    lengthPicker = lengthActionPicker;
    
    NSArray *weightMeasurements = [[NSArray alloc]
                                   initWithObjects:@"lbs.", @"g.", @"kg.", @"oz.", nil];
    EAActionSheetPicker *weightActionPicker = [[EAActionSheetPicker alloc]
                                               initWithOptions:weightMeasurements];
    
    weightActionPicker.textField = self.weightMeasurementField;
    weightPicker = weightActionPicker;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectWeightMeasurement:(UIButton *)sender {
    [weightPicker showInView:self.view];
}

- (IBAction)selectLengthMeasurement:(UIButton *)sender {
    [lengthPicker showInView:self.view];
}

- (IBAction)saveNewCatch:(UIBarButtonItem *)sender {
    [self addNewCatch];
}

- (IBAction)cancelNewCatch:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)topSaveNewCatch:(id)sender {
    [self addNewCatch];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)addNewCatch {
    if ([self validateForm]) {
        Catch *brandNewCatch = [Catch object];
        brandNewCatch.name = catchNameField.text;
        brandNewCatch.length = [catchLengthField.text doubleValue];
        brandNewCatch.weight = [catchWeightField.text doubleValue];
        brandNewCatch.user = [PFUser currentUser];
        [brandNewCatch save];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (BOOL)validateForm {
    if ([catchNameField.text isEqualToString:@""]) {
        catchNameField.layer.borderWidth = 1.0f;
        catchNameField.layer.borderColor = [[UIColor redColor] CGColor];
        catchNameField.layer.cornerRadius = 5;
        catchNameField.clipsToBounds = YES;
        return NO;
    }
    if ([catchLengthField.text isEqualToString:@""]) {
        catchLengthField.layer.borderWidth = 1.0f;
        catchLengthField.layer.borderColor = [[UIColor redColor] CGColor];
        catchLengthField.layer.cornerRadius = 5;
        catchLengthField.clipsToBounds = YES;
        return NO;
    }
    if ([catchWeightField.text isEqualToString:@""]) {
        catchWeightField.layer.borderWidth = 1.0f;
        catchWeightField.layer.borderColor = [[UIColor redColor] CGColor];
        catchWeightField.layer.cornerRadius = 5;
        catchWeightField.clipsToBounds = YES;
        return NO;
    }
    return YES;
}

@end
