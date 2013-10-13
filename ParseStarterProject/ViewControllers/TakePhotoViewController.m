//
//  TakePhotoViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 8/24/13.
//
//

#import "TakePhotoViewController.h"

@interface TakePhotoViewController ()

@end

@implementation TakePhotoViewController

@synthesize imageView;
@synthesize saveImageButton;

#pragma mark - Show camera

-(IBAction)showCameraAction:(id)sender
{
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickController.delegate=self;
    imagePickController.allowsEditing=TRUE;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Save photo

-(IBAction)saveImageAction:(id)sender
{
    UIImage *image=imageView.image;
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    saveImageButton.enabled=FALSE;
}

#pragma mark - When finish shoot

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    imageView.image=image;
    saveImageButton.enabled=TRUE;
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
