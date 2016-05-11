//
//  TermsAndPrivacyViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 7/13/14.
//
//

#import "TermsAndPrivacyViewController.h"

@interface TermsAndPrivacyViewController ()

@end

@implementation TermsAndPrivacyViewController

@synthesize webView, doneButton, doneToolbar;

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
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://topfishapp.com/terms_and_privacy.html"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
