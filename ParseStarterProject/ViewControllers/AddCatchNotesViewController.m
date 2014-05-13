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

@synthesize textView, viewMode, doneButton, doneButtonToolBar;

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
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, (self.view.frame.size.width - 20), (self.view.frame.size.height - 30))];
    textView.font = [UIFont fontWithName:@"ArialMT" size:16.0f];
    [self.view addSubview:textView];
    
    if (!viewMode) {
        [textView becomeFirstResponder];
//        dismissView = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 44.0)];
//        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButton:)];
//        dismissView.items = [NSArray arrayWithObjects:extraSpace, doneBtn, nil];
//        textView.inputAccessoryView = dismissView;
    }
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWasShown:)
     name:UIKeyboardWillShowNotification
     object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Setup view mode if needed
    if (viewMode) {
        textView.editable = NO;
    } else {
        textView.editable = YES;
    }
    
    if (self.delegate.catchNotesLabel.text == nil ||
        [self.delegate.catchNotesLabel.text isEqualToString:@""] ||
        [self.delegate.catchNotesLabel.text isEqualToString:@"Add Notes"]) {
        return;
    }
    textView.text = self.delegate.catchNotesLabel.text;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if(!viewMode) {
        if ([textView.text isEqualToString:@""]) {
            self.delegate.catchNotesLabel.text = @"Add Notes";
            [self.delegate changeNotesFieldIconToColor:@"grey"];
        } else {
            self.delegate.catchNotesLabel.text = textView.text;
            [self.delegate changeNotesFieldIconToColor:@"blue"];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(UIBarButtonItem *)sender {
    if ([textView.text isEqualToString:@""]) {
        self.delegate.catchNotesLabel.text = @"Add Notes";
        [self.delegate changeNotesFieldIconToColor:@"grey"];
    } else {
        self.delegate.catchNotesLabel.text = textView.text;
        [self.delegate changeNotesFieldIconToColor:@"blue"];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    CGRect viewFrame = textView.frame;
    CGFloat textEndCord = CGRectGetMaxY(textView.frame);
    CGFloat kbStartCord = textEndCord - ([[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue]).size.height;
    viewFrame.size.height = kbStartCord;
    textView.frame = viewFrame;
}

@end
