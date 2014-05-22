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
#import "WeightMeasurementOptionsTableViewController.h"
#import "LengthMeasurementOptionsTableViewController.h"
#import "ThemedTableViewController.h"
#import "CatchMapDelegate.h"
#import "LoginUserDelegate.h"

@interface AddCatchInfoTableViewController :
ThemedTableViewController<UITextFieldDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UIAlertViewDelegate,
SpeciesListSelector,
MethodListSelector,
CatchNotesDelegate,
WeightMeasurementSelector,
LengthMeasurementSelector,
CatchMapDelegate,
LoginUserDelegate>
{
    UIToolbar *dismissView;
    UIView *loadingOverlay;
    UIProgressView *uploadProgressView;
    UIImage *defaultFishPhoto;
}
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *choosePhotoButton;
@property (weak, nonatomic) IBOutlet UILabel *selectedLengthMeasurementLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedWeightMeasurementLabel;
@property (weak, nonatomic) IBOutlet UITextField *catchLengthField;
@property (weak, nonatomic) IBOutlet UITextField *catchWeightField;
@property (weak, nonatomic) IBOutlet UISwitch *rankedCatchSwitch;
@property (weak, nonatomic) IBOutlet UILabel *selectedLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedMethodLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedSpeciesLabel;
@property (weak, nonatomic) IBOutlet UILabel *catchNotesLabel;
@property (strong, nonatomic) Catch *selectedCatch;
@property (strong, nonatomic) Catch *selectedCatchQueryObject;
@property (strong, nonatomic) NSString *selectedCatchObjectId;
@property (strong, nonatomic) IBOutlet UIImageView *selectedPhoto;
@property (strong, nonatomic) UIImage *catchPhoto;
@property (nonatomic) CLLocationCoordinate2D catchAnnotationCoordinate;
@property (nonatomic) NSString *notesText;
@property (nonatomic) BOOL photoUpdated;
@property (nonatomic, strong) PFUser *loggedInUser;

- (IBAction)clickTakePhotoButton:(UIButton *)sender;
- (IBAction)clickChoosePhotoButton:(UIButton *)sender;
- (IBAction)selectWeightMeasurement:(UIButton *)sender;
- (IBAction)selectLengthMeasurement:(UIButton *)sender;
- (IBAction)clearNewCatchForm:(UIBarButtonItem *)sender;
- (void)changeSpeciesFieldIconToColor:(NSString *)color;
- (void)changeMethodFieldIconToColor:(NSString *)color;
- (void)changeLocationFieldIconToColor:(NSString *)color;
- (void)changePhotoFieldIconToColor:(NSString *)color;

@end