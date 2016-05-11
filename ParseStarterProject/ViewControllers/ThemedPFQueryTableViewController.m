//
//  ThemedTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 11/3/13.
//
//

#import "ThemedPFQueryTableViewController.h"
#import "ThemeColors.h"

@interface ThemedPFQueryTableViewController ()

@end

@implementation ThemedPFQueryTableViewController

@synthesize iconImage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSeparatorColor];
    [self setBackgroundColor];
    self.view.tintColor = [ThemeColors blueColor];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    
    [super willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:0];
    
    // Setup icon image
    UIImage *iconImg = [UIImage imageNamed:@"icon-silhouette.png"];
    iconImage = [UIImageView new];
    iconImage.image = iconImg;
    iconImage.frame = CGRectMake(70, 60, (iconImg.size.width*0.75), (iconImg.size.height*0.75));
    iconImage.alpha = 0.1;
    iconImage.contentMode = UIViewContentModeScaleAspectFit;
    iconImage.hidden = YES;
    [self.view addSubview:iconImage];
}

- (void)setSeparatorColor {
    [self.tableView setSeparatorColor:[UIColor colorWithRed:(183.0f/255.0f)
                                                      green:(147.0f/255.0f)
                                                       blue:(101.0f/255.0f)
                                                      alpha:0.3f]];
}

- (void)setBackgroundColor {
    self.tableView.backgroundColor = [ThemeColors backgroundImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
