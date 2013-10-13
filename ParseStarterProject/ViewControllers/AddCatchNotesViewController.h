//
//  AddCatchNotesViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/2/13.
//
//

#import <UIKit/UIKit.h>
#import "AddCatchInfoTableViewController.h"

@protocol CatchNotesDelegate <NSObject>

- (UILabel *)catchNotesLabel;

@end

@interface AddCatchNotesViewController : UIViewController
{
    UIToolbar *dismissView;
}

@property id<CatchNotesDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
