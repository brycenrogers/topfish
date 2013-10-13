//
//  TakePhotoViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 8/24/13.
//
//

#import <UIKit/UIKit.h>

@interface TakePhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,retain)IBOutlet UIImageView *imageView;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *saveImageButton;

-(IBAction)showCameraAction:(id)sender;
-(IBAction)saveImageAction:(id)sender;

@end
