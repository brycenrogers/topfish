//
//  AddCatchInfoViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import <UIKit/UIKit.h>
#import "Catch.h"
#import "CatchMapAnnotation.h"
#import "SpeciesList.h"
#import "MethodListTableViewController.h"
#import "AddCatchNotesViewController.h"

@interface AddCatchInfoTableViewController :
UITableViewController<UITextFieldDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
SpeciesListSelector,
MethodListSelector,
CatchNotesDelegate>
{
    UIToolbar *dismissView;
    UIImage *catchPhoto;
    UIView *loadingOverlay;
    UIProgressView *uploadProgressView;
    UIImage *defaultFishPhoto;
}

@property (weak, nonatomic) IBOutlet UITextField *lengthMeasurementField;
@property (weak, nonatomic) IBOutlet UITextField *weightMeasurementField;
@property (weak, nonatomic) IBOutlet UITextField *catchLengthField;
@property (weak, nonatomic) IBOutlet UITextField *catchWeightField;
@property (weak, nonatomic) IBOutlet UIImageView *selectedPhoto;
@property (weak, nonatomic) IBOutlet UISwitch *rankedCatchSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *tellMyFriendsSwitch;
@property (weak, nonatomic) IBOutlet UILabel *selectedLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedMethodLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedSpeciesLabel;
@property (weak, nonatomic) IBOutlet UILabel *catchNotesLabel;

@property (nonatomic) CLLocationCoordinate2D catchAnnotationCoordinate;
@property (nonatomic) NSString *notesText;

@property (nonatomic, strong) Catch *selectedCatch;

- (IBAction)selectWeightMeasurement:(UIButton *)sender;
- (IBAction)selectLengthMeasurement:(UIButton *)sender;
- (IBAction)clearNewCatchForm:(UIBarButtonItem *)sender;

@end