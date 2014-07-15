//
//  CatchesMapNavigationController.m
//  TopFish
//
//  Created by Brycen Rogers on 5/25/14.
//
//

#import "CatchesMapNavigationController.h"
#import "CatchUpdatedView.h"
#import "CatchDeletedView.h"
#import "CatchReportedView.h"
#import "CatchApprovedView.h"
#import "CatchRejectedView.h"

@interface CatchesMapNavigationController ()

@end

@implementation CatchesMapNavigationController

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

- (void)showCatchUpdatedMessage
{
    [CatchUpdatedView animateCatchUpdatedViewforView:self.view];
}

- (void)showCatchDeletedMessage
{
    [CatchDeletedView animateCatchDeletedViewforView:self.view];
}

- (void)showCatchReportedMessage
{
    [CatchReportedView animateCatchReportedViewforView:self.view];
}

- (void)showCatchApprovedMessage
{
    [CatchApprovedView animateCatchApprovedViewforView:self.view];
}

- (void)showCatchRejectedMessage
{
    [CatchRejectedView animateCatchRejectedViewforView:self.view];
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
