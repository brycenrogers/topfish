//
//  CatchDetailViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 10/13/13.
//
//

#import "CatchDetailTableViewController.h"
#import "CatchPhotoDetailView.h"
#import <Parse/Parse.h>
#import "Catch.h"
#import "CatchPhotoScrollViewController.h"
#import "AddCatchMapLocationViewController.h"
#import "CatchesTableViewController.h"

@interface CatchDetailTableViewController ()

@end

@implementation CatchDetailTableViewController

@synthesize selectedCatch,
catchImageView,
caughtByButton,
rankedCatchLabel,
viewOnMapButton,
lengthLabel,
weightLabel,
methodLabel,
notesLabel,
gestureRecognizer;

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
    [self.caughtByButton setTitle:selectedCatch.user.username forState:UIControlStateNormal];
    self.speciesLabel.text = selectedCatch.species;
    self.rankedCatchLabel.text = [self rankedCatchToString];
    self.lengthLabel.text = [self catchLengthToString];
    self.weightLabel.text = [self catchWeightToString];
    self.methodLabel.text = selectedCatch.method;
    self.notesLabel.attributedText = [self buildNotesString];
    
    if (selectedCatch.photo) {
        PFFile *imageFile = [selectedCatch objectForKey:@"photo"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            UIImage *photo = [UIImage imageWithData:data];
            self.catchImageView.image = photo;
        }];
    }
    
    [self buildSingleTapGestureRecognizer];
    [self setupViewOnMapButton];
}

- (void)setupViewOnMapButton {
    if (selectedCatch.location.latitude == -90.0 && selectedCatch.location.longitude == 0) {
        [self.viewOnMapButton setEnabled:NO];
        [self.viewOnMapButton setTitle:@"No Location Set" forState:UIControlStateNormal];
    } else {
        [self.viewOnMapButton setEnabled:YES];
        [self.viewOnMapButton setTitle:@"View on Map" forState:UIControlStateNormal];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && gradient == nil) {
        [self setGradient];
    }
    if (indexPath.row == 2) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"map-pin-mini.png"];
        return theCell;
    }
    if (indexPath.row == 3) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"hand-mini.png"];
        return theCell;
    }
    if (indexPath.row == 4) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"weight-mini.png"];
        return theCell;
    }
    if (indexPath.row == 5) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"ruler-mini.png"];
        return theCell;
    }
    if (indexPath.row == 6) {
        UITableViewCell *theCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        theCell.imageView.image = [UIImage imageNamed:@"sticky-note-mini.png"];
        return theCell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)setGradient {
    CAGradientLayer *gradientFill = [CAGradientLayer layer];
    gradientFill.frame = CGRectMake(0, 155, 320, 85);
    gradientFill.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    gradientFill.opacity = 0.5;
    
    gradient = gradientFill;
    
    [self.view.layer insertSublayer:gradient atIndex:1];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:self.view];
    return !CGRectContainsPoint(self.catchImageView.frame, touchLocation);
}

- (NSMutableString *)catchLengthToString {
    NSMutableString *lengthString = [NSMutableString stringWithFormat:@"%d ", selectedCatch.length];
    [lengthString appendString:selectedCatch.lengthMeasurement];
    return lengthString;
}

- (NSMutableString *)catchWeightToString {
    NSMutableString *weightString = [NSMutableString stringWithFormat:@"%d ", selectedCatch.weight];
    [weightString appendString:selectedCatch.weightMeasurement];
    return weightString;
}

- (NSString *)rankedCatchToString {
    if (selectedCatch.rankedCatch) {
        return @"Ranked Catch";
    }
    return @"Unranked Catch";
}

- (NSAttributedString *)buildNotesString {
    if (selectedCatch.notes) {
        NSAttributedString *notes = [[NSAttributedString alloc] initWithString:selectedCatch.notes
                                                                    attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        return notes;
    }
    return [[NSAttributedString alloc] initWithString:@"None" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Adjust the Notes Cell and Label element heights for Catches with Notes
    if (indexPath.section == 3 && indexPath.row == 0 && selectedCatch.notes.length > 20) {
        CGSize constraint = CGSizeMake(180.0f, MAXFLOAT);
        NSAttributedString *attNotes = [[NSAttributedString alloc] initWithString:selectedCatch.notes attributes:@{NSFontAttributeName: self.notesLabel.font}];
        CGRect rect = [attNotes boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        self.notesLabel.frame = CGRectMake(95, 5, 200.0f, rect.size.height);

        // A little extra padding
        return rect.size.height + 10;
    }
    
    // if there are no Notes, or it's a different row, don't override
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)buildSingleTapGestureRecognizer {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapDetected)];
    singleTap.numberOfTapsRequired = 1;
    self.catchImageView.userInteractionEnabled = YES;
    [self.catchImageView addGestureRecognizer:singleTap];
}

- (void)singleTapDetected{
    // Trigger segue to CatchPhotoScrollViewController
    [self performSegueWithIdentifier:@"showCatchPhotoScrollViewFromDetails" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCatchPhotoScrollViewFromDetails"])
    {
        CatchPhotoScrollViewController *cpsvc = [segue destinationViewController];
        cpsvc.selectedCatch = self.selectedCatch;
        cpsvc.photo = self.catchImageView.image;
    }
    if ([[segue identifier] isEqualToString:@"showOnMapFromDetails"])
    {
        AddCatchMapLocationViewController *acmlvc = [segue destinationViewController];
        acmlvc.delegate = self;
        acmlvc.locationCoordinate = CLLocationCoordinate2DMake(self.selectedCatch.location.latitude, self.selectedCatch.location.longitude);
    }
    if ([[segue identifier] isEqualToString:@"shoCatchesFromUser"])
    {
        CatchesTableViewController *ctvc = [segue destinationViewController];
        ctvc.selectedCatch = self.selectedCatch;
    }
}

- (IBAction)showOnMap:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showOnMapFromDetails" sender:nil];
}

- (IBAction)caughtByButton:(id)sender {
    [self performSegueWithIdentifier:@"showCatchesFromUser" sender:nil];
}

- (void)changeLocationFieldIconToColor:(NSString *)color
{
    
}

@end
