//
//  CatchAddedViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/2/13.
//
//

#import "CatchAddedViewController.h"
#import "CatchDetailTableViewController.h"

@interface CatchAddedViewController ()

@end

@implementation CatchAddedViewController

@synthesize selectedCatch, speciesLabel, catchImageView;

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
    [self buildSingleTapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    speciesLabel.text = selectedCatch.species;
    
    catchImageView.image = [UIImage imageNamed:@"fish-default-photo.png"]; // placeholder image
    catchImageView.file = selectedCatch.photo;
    [catchImageView loadInBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAnotherButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)viewCatchButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"viewCatchDetailsFromAddCatch" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"viewCatchDetailsFromAddCatch"])
    {
        CatchDetailTableViewController *cdtvc = [segue destinationViewController];
        cdtvc.selectedCatch = selectedCatch;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:self.view];
    return !CGRectContainsPoint(self.catchImageView.frame, touchLocation);
}

- (void)buildSingleTapGestureRecognizer {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapDetected)];
    singleTap.numberOfTapsRequired = 1;
    self.catchImageView.userInteractionEnabled = YES;
    [self.catchImageView addGestureRecognizer:singleTap];
}

- (void)singleTapDetected{
    // Trigger segue to CatchPhotoScrollViewController
    [self performSegueWithIdentifier:@"viewCatchDetailsFromAddCatch" sender:nil];
}

@end
