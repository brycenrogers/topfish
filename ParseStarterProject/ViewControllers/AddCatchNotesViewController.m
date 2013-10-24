//
//  AddCatchNotesViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/2/13.
//
//

#import "AddCatchNotesViewController.h"
#import "AddCatchInfoTableViewController.h"

@interface AddCatchNotesViewController ()

@end

@implementation AddCatchNotesViewController

@synthesize textView;

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
    [textView becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.delegate.catchNotesLabel.text == nil ||
        [self.delegate.catchNotesLabel.text isEqualToString:@""] ||
        [self.delegate.catchNotesLabel.text isEqualToString:@"Add Notes"]) {
        return;
    }
    textView.text = self.delegate.catchNotesLabel.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(UIBarButtonItem *)sender {
    if (![textView.text isEqualToString:@""]) {
        self.delegate.catchNotesLabel.text = textView.text;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
