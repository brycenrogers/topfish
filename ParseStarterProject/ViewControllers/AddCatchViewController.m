//
//  AddCatchViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 8/10/13.
//
//

#import "AddCatchViewController.h"

@interface AddCatchViewController ()

@end

@implementation AddCatchViewController

@synthesize addCatchInfo;

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWithInfoButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"addCatchInfo" sender:sender];
}
@end
