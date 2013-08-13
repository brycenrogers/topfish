//
//  AddCatchInfoViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import <UIKit/UIKit.h>
#import "EAActionSheetPicker.h"

@interface AddCatchInfoTableViewController : UITableViewController<UITextFieldDelegate>
{
    EAActionSheetPicker *lengthPicker;
    EAActionSheetPicker *weightPicker;
}
@property (weak, nonatomic) IBOutlet UITextField *lengthMeasurementField;
@property (weak, nonatomic) IBOutlet UITextField *weightMeasurementField;
@property (weak, nonatomic) IBOutlet UITextField *catchNameField;
@property (weak, nonatomic) IBOutlet UITextField *catchLengthField;
@property (weak, nonatomic) IBOutlet UITextField *catchWeightField;

- (IBAction)selectWeightMeasurement:(UIButton *)sender;
- (IBAction)selectLengthMeasurement:(UIButton *)sender;
- (IBAction)saveNewCatch:(UIBarButtonItem *)sender;
- (IBAction)cancelNewCatch:(UIBarButtonItem *)sender;
- (IBAction)topSaveNewCatch:(id)sender;

@end