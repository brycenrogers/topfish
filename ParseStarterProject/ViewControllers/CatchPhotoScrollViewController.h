//
//  catchPhotoScrollViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 10/16/13.
//
//

#import <UIKit/UIKit.h>
#import "Catch.h"

@interface CatchPhotoScrollViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *catchPhotoScrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *photo;
@property (weak, nonatomic) Catch *selectedCatch;

@end
