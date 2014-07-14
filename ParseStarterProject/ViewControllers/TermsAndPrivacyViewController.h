//
//  TermsAndPrivacyViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 7/13/14.
//
//

#import <UIKit/UIKit.h>

@interface TermsAndPrivacyViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

- (IBAction)doneButtonClicked:(UIBarButtonItem *)sender;

@end
