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
    if (parentVC.notesText == nil || [parentVC.notesText isEqualToString:@""]) {
        return;
    }
    textView.text = parentVC.notesText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(UIBarButtonItem *)sender {
    if (![textView.text isEqualToString:@""]) {
        parentVC.notesText = textView.text;
        parentVC.notesLabel.text = textView.text;
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
@end
