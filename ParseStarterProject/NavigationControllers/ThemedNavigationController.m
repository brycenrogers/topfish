//
//  ThemedNavigationController.m
//  TopFish
//
//  Created by Brycen Rogers on 4/11/14.
//
//

#import "ThemedNavigationController.h"
#import "ThemeColors.h"

@interface ThemedNavigationController ()

@end

@implementation ThemedNavigationController

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
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //self.navigationBar.translucent = NO;
    self.view.tintColor = [ThemeColors blueColor];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:(6.0f/255.0f) green:(113.0f/255.0f) blue:(24.0f/255.0f) alpha:1.0f];
    shadow.shadowOffset = CGSizeMake(0, -1);
    
    self.navigationBar.barTintColor = [ThemeColors greenColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                               NSShadowAttributeName: shadow,
                                               NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:20]};
    [self addBottomLineView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)addBottomLineView
{
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 1)];
    bottomLineView.backgroundColor = [UIColor blackColor];
    bottomLineView.alpha = 0.25;
    [self.view addSubview:bottomLineView];
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

@end
