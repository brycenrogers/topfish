//
//  AddCatchNotesViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/2/13.
//
//

#import <UIKit/UIKit.h>

@protocol CatchNotesDelegate <NSObject>

- (UILabel *)catchNotesLabel;

- (void)changeNotesFieldIconToColor:(NSString *)color;

@end

@interface AddCatchNotesViewController : UIViewController
{
    UIToolbar *dismissView;
}

@property id<CatchNotesDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
