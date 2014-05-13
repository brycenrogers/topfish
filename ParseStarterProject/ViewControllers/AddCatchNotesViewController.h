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

@interface AddCatchNotesViewController : UIViewController<UITextFieldDelegate>
{
    UIToolbar *dismissView;
}

@property id<CatchNotesDelegate> delegate;
@property (strong, nonatomic) UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UIToolbar *doneButtonToolBar;
@property (nonatomic) BOOL viewMode;

@end
