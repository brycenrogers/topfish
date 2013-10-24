//
//  CatchDetailViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 10/13/13.
//
//

#import <UIKit/UIKit.h>
#import "Catch.h"

@interface CatchDetailTableViewController : UITableViewController<UIGestureRecognizerDelegate>
{
    CAGradientLayer *gradient;
}

@property (retain, nonatomic) UITapGestureRecognizer *gestureRecognizer;

@property (nonatomic, strong) Catch *selectedCatch;
@property (weak, nonatomic) IBOutlet UIImageView *catchImageView;
@property (weak, nonatomic) IBOutlet UILabel *speciesLabel;
@property (weak, nonatomic) IBOutlet UILabel *caughtByLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankedCatchLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewOnMapButton;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *methodLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

- (IBAction)showOnMap:(UIButton *)sender;

@end