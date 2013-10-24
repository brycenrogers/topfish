	//
//  catchPhotoScrollViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 10/16/13.
//
//

#import "CatchPhotoScrollViewController.h"

@interface CatchPhotoScrollViewController ()

@end

@implementation CatchPhotoScrollViewController

@synthesize catchPhotoScrollView, imageView, photo, selectedCatch;

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
    self.catchPhotoScrollView.contentSize = CGSizeMake(self.photo.size.width, self.photo.size.height);
    self.catchPhotoScrollView.delegate = self;
    self.catchPhotoScrollView.minimumZoomScale = 0.5;
    self.catchPhotoScrollView.maximumZoomScale = 6.0;
    self.catchPhotoScrollView.delegate = self;
    
    self.imageView = [[UIImageView alloc] initWithImage:self.photo];
    [self.catchPhotoScrollView addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
