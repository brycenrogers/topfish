//
//  AddCatchInfoViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import "AddCatchInfoTableViewController.h"
#import "AddCatchNavigationController.h"
#import "CatchAddedViewController.h"
#import "Catch.h"
#import "CatchPhoto.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "AddCatchMapLocationViewController.h"
#import "SpeciesListTableViewController.h"
#import "WeightMeasurementOptionsTableViewController.h"
#import "LengthMeasurementOptionsTableViewController.h"

@interface AddCatchInfoTableViewController ()

@end

@implementation AddCatchInfoTableViewController

@synthesize selectedLengthMeasurementLabel,
selectedWeightMeasurementLabel,
catchLengthField,
catchWeightField,
selectedPhoto,
selectedSpeciesLabel,
selectedMethodLabel,
rankedCatchSwitch,
selectedLocationLabel,
catchNotesLabel,
catchAnnotationCoordinate,
notesText,
selectedCatch,
takePhotoButton,
choosePhotoButton;

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
    catchLengthField.delegate = self;
    catchWeightField.delegate = self;
    catchPhoto = nil;
    rankedCatchSwitch.selected = YES;
    catchAnnotationCoordinate = kCLLocationCoordinate2DInvalid;
    selectedPhoto.contentMode = UIViewContentModeScaleAspectFit;
    defaultFishPhoto = [UIImage imageNamed:@"fish-default-photo.png"];
    selectedPhoto.image = defaultFishPhoto;
    
    // Buttons
    takePhotoButton.layer.borderWidth=1.0f;
    takePhotoButton.layer.borderColor=[[UIColor colorWithRed:(183.0f/255.0f) green:(147.0f/255.0f) blue:(101.0f/255.0f) alpha:0.3f] CGColor];
    takePhotoButton.layer.cornerRadius=6.0f;
    choosePhotoButton.layer.borderWidth=1.0f;
    choosePhotoButton.layer.borderColor=[[UIColor colorWithRed:(183.0f/255.0f) green:(147.0f/255.0f) blue:(101.0f/255.0f) alpha:0.3f] CGColor];
    choosePhotoButton.layer.cornerRadius=6.0f;
    
    [rankedCatchSwitch addTarget:self action:@selector(changeRankedCatchSwitch:) forControlEvents:UIControlEventValueChanged];
    
    [self buildDismissKeyboardAccessoryView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (CLLocationCoordinate2DIsValid(self.catchAnnotationCoordinate)) {
        self.selectedLocationLabel.text = @"Location Selected";
    }
}

- (void)changeRankedCatchSwitch:(id)sender {
    if([sender isOn]){
        [self changeRankedCatchFieldIconToColor:@"blue"];
    } else{
        [self changeRankedCatchFieldIconToColor:@"grey"];
    }
}

- (void)changePhotoFieldIconToColor:(NSString *)color {
    UITableViewCell *theCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    theCell.imageView.image = [UIImage imageNamed:@"camera-mini.png"];
    if ([color isEqualToString:@"blue"]) {
        theCell.imageView.image = [UIImage imageNamed:@"camera-mini-blue.png"];
    }
}

- (void)changeCatchLengthFieldIconToColor:(NSString *)color {
    UITableViewCell *theCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    theCell.imageView.image = [UIImage imageNamed:@"ruler-mini.png"];
    if ([color isEqualToString:@"blue"]) {
        theCell.imageView.image = [UIImage imageNamed:@"ruler-mini-blue.png"];
    }
}

- (void)changeCatchWeightFieldIconToColor:(NSString *)color {
    UITableViewCell *theCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    theCell.imageView.image = [UIImage imageNamed:@"weight-mini.png"];
    if ([color isEqualToString:@"blue"]) {
        theCell.imageView.image = [UIImage imageNamed:@"weight-mini-blue.png"];
    }
}

- (void)changeSpeciesFieldIconToColor:(NSString *)color {
    UITableViewCell *theCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    theCell.imageView.image = [UIImage imageNamed:@"circle-overlapping-mini.png"];
    if ([color isEqualToString:@"blue"]) {
        theCell.imageView.image = [UIImage imageNamed:@"circle-overlapping-mini-blue.png"];
    }
}

- (void)changeMethodFieldIconToColor:(NSString *)color {
    UITableViewCell *theCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    theCell.imageView.image = [UIImage imageNamed:@"hand-mini.png"];
    if ([color isEqualToString:@"blue"]) {
        theCell.imageView.image = [UIImage imageNamed:@"hand-mini-blue.png"];
    }
}

- (void)changeLocationFieldIconToColor:(NSString *)color {
    UITableViewCell *theCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    theCell.imageView.image = [UIImage imageNamed:@"map-pin-area-mini-grey.png"];
    if ([color isEqualToString:@"blue"]) {
        theCell.imageView.image = [UIImage imageNamed:@"map-pin-area-mini-blue.png"];
    }
}

- (void)changeNotesFieldIconToColor:(NSString *)color {
    UITableViewCell *theCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    theCell.imageView.image = [UIImage imageNamed:@"sticky-note-mini.png"];
    if ([color isEqualToString:@"blue"]) {
        theCell.imageView.image = [UIImage imageNamed:@"sticky-note-mini-blue.png"];
    }
}

- (void)changeRankedCatchFieldIconToColor:(NSString *)color {
    UITableViewCell *theCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0]];
    theCell.imageView.image = [UIImage imageNamed:@"trophy-mini-grey.png"];
    if ([color isEqualToString:@"blue"]) {
        theCell.imageView.image = [UIImage imageNamed:@"trophy-mini-blue.png"];
    }
}

- (void)buildDismissKeyboardAccessoryView {
    if (dismissView == nil) {        
        dismissView = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 44.0)];
        
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(removeKeyboard)];
        
        dismissView.items = [NSArray arrayWithObjects:extraSpace, doneButton, nil];
    }
    catchLengthField.inputAccessoryView = dismissView;
    catchWeightField.inputAccessoryView = dismissView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [catchLengthField resignFirstResponder];
    [catchWeightField resignFirstResponder];
}

- (void)removeKeyboard {
    [self.view endEditing:YES];
    if ([catchLengthField.text isEqualToString:@""]) {
        [self changeCatchLengthFieldIconToColor:@"grey"];
    } else {
        [self changeCatchLengthFieldIconToColor:@"blue"];
    }
    if ([catchWeightField.text isEqualToString:@""]) {
        [self changeCatchWeightFieldIconToColor:@"grey"];
    } else {
        [self changeCatchWeightFieldIconToColor:@"blue"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickTakePhotoButton:(UIButton *)sender {
    [self showCameraAction];
}

- (IBAction)clickChoosePhotoButton:(UIButton *)sender {
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (IBAction)selectWeightMeasurement:(UIButton *)sender {
    [self performSegueWithIdentifier:@"selectWeightMeasurementFromAdd" sender:nil];
}

- (IBAction)selectLengthMeasurement:(UIButton *)sender {
    [self performSegueWithIdentifier:@"selectLengthMeasurementFromAdd" sender:nil];
}

- (IBAction)clearNewCatchForm:(UIBarButtonItem *)sender {
    [self clearNewCatchForm];
}

- (IBAction)saveCatch:(UIButton *)sender {
    [self addNewCatch];
}

- (void)selectFishingMethod {
    [self performSegueWithIdentifier:@"selectMethodListFromAdd" sender:nil];
}

- (void)selectSpecies {
    [self performSegueWithIdentifier:@"selectSpeciesListFromAdd" sender:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)addNewCatch {
    if (![self validateForm]) {
        return;
    }
    
    Catch *brandNewCatch = [Catch object];
    brandNewCatch.length = [catchLengthField.text doubleValue];
    brandNewCatch.weight = [catchWeightField.text doubleValue];
    brandNewCatch.lengthMeasurement = self.selectedLengthMeasurementLabel.text;
    brandNewCatch.weightMeasurement = self.selectedWeightMeasurementLabel.text;
    brandNewCatch.method = selectedMethodLabel.text;
    brandNewCatch.notes = catchNotesLabel.text;
    brandNewCatch.rankedCatch = rankedCatchSwitch.on;
    brandNewCatch.user = [PFUser currentUser];
    
    if (![selectedSpeciesLabel.text isEqualToString:@"Select Species"]) {
        brandNewCatch.species = self.selectedSpeciesLabel.text;
    }
    if (![selectedMethodLabel.text isEqualToString:@"Select Method"]) {
        brandNewCatch.method = self.selectedMethodLabel.text;
    }
    
    // Sets a default location coordinate if none was selected
    if (!CLLocationCoordinate2DIsValid(catchAnnotationCoordinate)) {
        catchAnnotationCoordinate = CLLocationCoordinate2DMake(-90.00, 0.0);
    }
    
    brandNewCatch.location = [PFGeoPoint geoPointWithLatitude:catchAnnotationCoordinate.latitude
                                                    longitude:catchAnnotationCoordinate.longitude];
    
    // Update the NavigationController's catchAdded property to YES so it knows to go back to the root view next appearance
    AddCatchNavigationController *parentNC = (AddCatchNavigationController *)[self parentViewController];
    [parentNC setCatchAdded:YES];
        
    if (catchPhoto != nil) {
        NSData *imageData = UIImageJPEGRepresentation(catchPhoto, 0.6);
        PFFile *imageFile = [PFFile fileWithName:
                             [NSString stringWithFormat:@"%@_%f.jpg", brandNewCatch.user.username, [[NSDate date] timeIntervalSince1970]]
                                            data:imageData];
        
        [self buildLoadingView];
        
        
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
            brandNewCatch.photo = imageFile;
            [brandNewCatch saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [loadingOverlay removeFromSuperview];
                if (succeeded) {
                    self.selectedCatch = brandNewCatch;
                    
                    // Move to CatchAddedViewController to show success message
                    [self performSegueWithIdentifier:@"catchAddedVC" sender:nil];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error"
                                                                    message:@"Could not save catch. Network error occured."
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error"
                                                                message:@"Could not save catch. Network error occured."
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } progressBlock:^(int percentDone) {
            [uploadProgressView setProgress:percentDone animated:YES];
        }];
    } else {
        [brandNewCatch saveEventually];
        self.selectedCatch = brandNewCatch;
        
        // Move to CatchAddedViewController to show success message
        [self performSegueWithIdentifier:@"catchAddedVC" sender:nil];
    }
    // Clear the form
    [self clearNewCatchForm];
}

- (void)buildLoadingView {
    UIView *loadingOverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    loadingOverlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:.75];
    loadingOverlay = loadingOverlayView;

    UILabel *uploadingTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 300, 30)];
    uploadingTextLabel.text = @"Uploading Photo and Saving...";
    uploadingTextLabel.textColor = [UIColor whiteColor];
    uploadingTextLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [loadingOverlay addSubview:uploadingTextLabel];
    
    UIProgressView *uploadProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    uploadProgress.frame = CGRectMake(80, 250, uploadProgress.frame.size.width, uploadProgress.frame.size.height);
    uploadProgressView = uploadProgress;
    
    [loadingOverlay addSubview:uploadProgress];
    [self.view.window addSubview:loadingOverlay];
}

- (BOOL)validateForm {
    if (![self validateCatchLength]) {
        [self showAlertForField:catchLengthField
                    withMessage:@"Please enter the length of your catch" andTag:2];
        return NO;
    }
    if (![self validateCatchPhoto]) {
        [self showAlertForField:nil withMessage:@"Ranked Catches must have a photo" andTag:1];
        return NO;
    }
    if (![self validateSpecies]) {
        [self showAlertForField:nil withMessage:@"Please select a species" andTag:3];
        return NO;
    }
    return YES;
}

- (BOOL)validateCatchLength {
    if ([catchLengthField.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (BOOL)validateSpecies {
    if ([selectedSpeciesLabel.text isEqualToString:@"Select Species"]) {
        return NO;
    }
    return YES;
}

- (BOOL)validateCatchPhoto {
    if (rankedCatchSwitch.on) {
        if (catchPhoto == nil) {
            return NO;
        }
    }
    return YES;
}

- (void)clearNewCatchForm {
    catchLengthField.text = @"";
    catchWeightField.text = @"";
    catchPhoto = nil;
    catchNotesLabel.text = @"Add Notes";
    selectedPhoto.image = defaultFishPhoto;
    catchAnnotationCoordinate = kCLLocationCoordinate2DInvalid;
    selectedLocationLabel.text = @"Select Location";
    selectedLocationLabel.textColor = [UIColor blackColor];
    selectedSpeciesLabel.text = @"Select Species";
    selectedMethodLabel.text = @"Select Method";
    
    NSString *grey = @"grey";
    [self changePhotoFieldIconToColor:grey];
    [self changeLocationFieldIconToColor:grey];
    [self changeCatchLengthFieldIconToColor:grey];
    [self changeCatchWeightFieldIconToColor:grey];
    [self changeMethodFieldIconToColor:grey];
    [self changeSpeciesFieldIconToColor:grey];
    [self changeNotesFieldIconToColor:grey];
}

- (void)showAlertForField:(UITextField *)field withMessage:(NSString *)message andTag:(int)tagNum {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    alert.delegate = self;
    alert.tag = tagNum;
    [alert show];
    [field becomeFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (alertView.tag == 2) {
        indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    } else if (alertView.tag == 3) {
        indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    }
    
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}

- (void)showLocationModal {
    [self performSegueWithIdentifier:@"showLocationModal" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showLocationModal"])
    {
        AddCatchMapLocationViewController *parentVC = [segue destinationViewController];
        parentVC.delegate = self;
        if (CLLocationCoordinate2DIsValid(self.catchAnnotationCoordinate)) {
            parentVC.locationCoordinate = CLLocationCoordinate2DMake(self.catchAnnotationCoordinate.latitude, self.catchAnnotationCoordinate.longitude);
        }
        return;
    }
    
    if ([[segue identifier] isEqualToString:@"selectSpeciesListFromAdd"])
    {
        SpeciesListTableViewController *parentVC = [segue destinationViewController];
        parentVC.delegate = self;
        return;
    }
    
    if ([[segue identifier] isEqualToString:@"selectMethodListFromAdd"])
    {
        MethodListTableViewController *parentVC = [segue destinationViewController];
        parentVC.delegate = self;
        return;
    }
    
    if ([[segue identifier] isEqualToString:@"addNote"])
    {
        AddCatchNotesViewController *parentVC = [segue destinationViewController];
        parentVC.delegate = self;
        return;
    }
    
    if ([[segue identifier] isEqualToString:@"catchAddedVC"])
    {
        CatchAddedViewController *cavc = [segue destinationViewController];
        cavc.selectedCatch = self.selectedCatch;
    }
    
    if ([[segue identifier] isEqualToString:@"selectWeightMeasurementFromAdd"])
    {
        WeightMeasurementOptionsTableViewController *wmotvc = [segue destinationViewController];
        wmotvc.delegate = self;
    }
    
    if ([[segue identifier] isEqualToString:@"selectLengthMeasurementFromAdd"])
    {
        LengthMeasurementOptionsTableViewController *lmotvc = [segue destinationViewController];
        lmotvc.delegate = self;
    }
}

- (void)showNotesModal {
    [self performSegueWithIdentifier:@"addNote" sender:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 2) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"camera-mini.png"];
        if (catchPhoto != nil) {
            theCell.imageView.image = [UIImage imageNamed:@"camera-mini-blue.png"];
        }
        return theCell;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"ruler-mini.png"];
        if (![catchLengthField.text isEqualToString:@""]) {
            theCell.imageView.image = [UIImage imageNamed:@"ruler-mini-blue.png"];
        }
        theCell.textLabel.text = @"Length";
        return theCell;
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"weight-mini.png"];
        if (![catchWeightField.text isEqualToString:@""]) {
            theCell.imageView.image = [UIImage imageNamed:@"weight-mini-blue.png"];
        }
        theCell.textLabel.text = @"Weight";
        return theCell;
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"circle-overlapping-mini.png"];
        if (![selectedSpeciesLabel.text isEqualToString:@"Select Species"]) {
            theCell.imageView.image = [UIImage imageNamed:@"circle-overlapping-mini-blue.png"];
        }
        return theCell;
    }
    if (indexPath.section == 0 && indexPath.row == 6) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"hand-mini.png"];
        if (![selectedMethodLabel.text isEqualToString:@"Select Method"]) {
            theCell.imageView.image = [UIImage imageNamed:@"hand-mini-blue.png"];
        }
        return theCell;
    }
    if (indexPath.section == 0 && indexPath.row == 7) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"map-pin-area-mini-grey.png"];
        if (![selectedLocationLabel.text isEqualToString:@"Select Location"]) {
            theCell.imageView.image = [UIImage imageNamed:@"map-pin-area-mini-blue.png"];
        }
        return theCell;
    }
    if (indexPath.section == 0 && indexPath.row == 8) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"sticky-note-mini.png"];
        if (![catchNotesLabel.text isEqualToString:@"Add Notes"]) {
            theCell.imageView.image = [UIImage imageNamed:@"sticky-note-mini-blue.png"];
        }
        return theCell;
    }
    if (indexPath.section == 0 && indexPath.row == 9) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"trophy-mini-grey.png"];
        if (rankedCatchSwitch.on) {
            theCell.imageView.image = [UIImage imageNamed:@"trophy-mini-blue.png"];
        }
        return theCell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    int sec = indexPath.section;
    if (sec == 0 && row == 5) {
        [self selectSpecies];
    }
    if (sec == 0 && row == 6) {
        [self selectFishingMethod];
    }
    if (sec == 0 && row == 7) {
        [self showLocationModal];
    }
    if (sec == 0 && row == 8) {
        [self showNotesModal];
    }
    if (sec == 1 && row == 0) {
        [self addNewCatch];
    }
}

#pragma mark - Camera & Photos

- (BOOL)startMediaBrowserFromViewController: (UIViewController*) controller
                              usingDelegate: (id <UIImagePickerControllerDelegate,
                                              UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //mediaUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = self;
    
    [self presentViewController:mediaUI animated:YES completion:nil];
    return YES;
}

-(void)showCameraAction
{
    UIImagePickerController *imagePickController = [[UIImagePickerController alloc]init];
    imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickController.delegate = self;
    imagePickController.allowsEditing = TRUE;
    [self presentViewController:imagePickController animated:YES completion:nil];
}

-(IBAction)saveImageAction:(id)sender
{
    UIImage *image = self.selectedPhoto.image;
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.selectedPhoto.image = chosenImage;
    catchPhoto = chosenImage;
    
    [self changePhotoFieldIconToColor:@"blue"];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
