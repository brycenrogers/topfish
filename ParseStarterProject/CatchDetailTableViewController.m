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

@interface CatchDetailTableViewController ()

@end

@implementation CatchDetailTableViewController

@synthesize selectedCatch,
catchImageView,
caughtByLabel,
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
    self.caughtByLabel.text = selectedCatch.user.username;
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
        //UIImageView *newImageView = [[UIImageView alloc] initWithImage:self.catchImageView.image];
        cpsvc.selectedCatch = self.selectedCatch;
        cpsvc.photo = self.catchImageView.image;
    }
}

- (IBAction)showOnMap:(UIButton *)sender {
    NSLog(@"SHO MAP BITCH");
}

@end
