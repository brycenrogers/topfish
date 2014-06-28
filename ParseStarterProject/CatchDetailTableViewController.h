//
//  CatchDetailViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 10/13/13.
//
//

#import <UIKit/UIKit.h>
#import "Catch.h"
#import "ThemedTableViewController.h"
#import "CatchMapDelegate.h"
#import "AddCatchNotesViewController.h"

@interface CatchDetailTableViewController : ThemedTableViewController
<UIGestureRecognizerDelegate,
CatchMapDelegate,
CatchNotesDelegate>
{
    CAGradientLayer *gradient;
}

@property (retain, nonatomic) UITapGestureRecognizer *gestureRecognizer;

@property (nonatomic, strong) Catch *selectedCatch;
@property (strong, nonatomic) NSMutableArray *selectedCatchBSVotes;
@property (weak, nonatomic) IBOutlet UIImageView *catchImageView;
@property (weak, nonatomic) IBOutlet UILabel *speciesLabel;
@property (weak, nonatomic) IBOutlet UIButton *caughtByButton;
@property (weak, nonatomic) IBOutlet UILabel *rankedCatchLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewOnMapButton;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *methodLabel;
@property (weak, nonatomic) UIButton *editButton;
@property (weak, nonatomic) UIButton *deleteButton;
@property (nonatomic) BOOL fromSelectedCatchUsersCatches;
@property (weak, nonatomic) IBOutlet UILabel *catchNotesLabel;
@property (nonatomic) CLLocationCoordinate2D catchAnnotationCoordinate;
@property (weak, nonatomic) IBOutlet UIButton *callBSButton;
@property (strong, nonatomic) IBOutlet UIButton *flagButton;

- (void)changeNotesFieldIconToColor:(NSString *)color;
- (IBAction)pressCallBSButton:(UIButton *)sender;
- (IBAction)pressFlagButton:(UIButton *)sender;

@end