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

@interface AddCatchInfoTableViewController ()

@end

@implementation AddCatchInfoTableViewController

@synthesize lengthMeasurementField,
weightMeasurementField,
catchLengthField,
catchWeightField,
selectedPhoto,
selectedSpeciesLabel,
selectedMethodLabel,
rankedCatchSwitch,
tellMyFriendsSwitch,
selectedLocationLabel,
catchNotesLabel,
catchAnnotationCoordinate,
notesText;

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
    tellMyFriendsSwitch.selected = YES;
    catchAnnotationCoordinate = kCLLocationCoordinate2DInvalid;
    selectedPhoto.contentMode = UIViewContentModeScaleAspectFit;
    defaultFishPhoto = [UIImage imageNamed:@"fish-default-photo.png"];
    selectedPhoto.image = defaultFishPhoto;
    [self buildDismissKeyboardAccessoryView];
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

- (void)removeKeyboard {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectWeightMeasurement:(UIButton *)sender {
    
}

- (IBAction)selectLengthMeasurement:(UIButton *)sender {
    
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
    brandNewCatch.method = selectedMethodLabel.text;
    brandNewCatch.species = selectedSpeciesLabel.text;
    brandNewCatch.notes = notesText;
    brandNewCatch.rankedCatch = rankedCatchSwitch.on;
    brandNewCatch.tellMyFriends = tellMyFriendsSwitch.on;
    brandNewCatch.user = [PFUser currentUser];
    
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
            if (!succeeded) {
                // Handle upload error
            }            
            brandNewCatch.photo = imageFile;
            [brandNewCatch saveEventually];
            [loadingOverlay removeFromSuperview];
            
            // Move to CatchAddedViewController to show success message
            [self performSegueWithIdentifier:@"catchAddedVC" sender:nil];
            
        } progressBlock:^(int percentDone) {
            [uploadProgressView setProgress:percentDone animated:YES];
        }];
    } else {
        [brandNewCatch saveEventually];
        
        // Move to CatchAddedViewController to show success message
        [self performSegueWithIdentifier:@"catchAddedVC" sender:nil];
    }
    // Clear the form
    [self clearNewCatchForm];
}

- (void)buildLoadingView {
    UIView *loadingOverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
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
                    withMessage:@"Please enter the length of your catch"];
        //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:3] atScrollPosition:nil animated:YES];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
        
        return NO;
    }
    if (![self validateCatchPhoto]) {
        [self showAlertForField:nil withMessage:@"Ranked Catches must have a photo"];
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
    selectedPhoto.image = defaultFishPhoto;
    catchAnnotationCoordinate = kCLLocationCoordinate2DInvalid;
    selectedLocationLabel.text = @"No Location Selected";
}

- (void)showAlertForField:(UITextField *)field withMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
    [field becomeFirstResponder];
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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    int sec = indexPath.section;
    if (sec == 0 && row == 1) {
        [self showCameraAction];
    }
    if (sec == 0 && row == 2) {
        [self startMediaBrowserFromViewController:self usingDelegate:self];
    }
    if (sec == 3 && row == 0) {
        [self selectFishingMethod];
    }
    if (sec == 4 && row == 1) {
        [self showLocationModal];
    }
    if (sec == 2 && row == 0) {
        [self selectSpecies];
    }
    if (sec == 7 && row == 0) {
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
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
