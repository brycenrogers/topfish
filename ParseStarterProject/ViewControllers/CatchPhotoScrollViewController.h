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

@property (retain, nonatomic) IBOutlet UIScrollView *catchPhotoScrollView;
@property (retain, nonatomic) UIImageView *imageView;
@property (retain, nonatomic) UIImage *photo;
@property (retain, nonatomic) Catch *selectedCatch;

@end
