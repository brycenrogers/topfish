//
//  ProfileCatchesTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import "CatchesTableViewController.h"
#import "Catch.h"
#import "CatchDetailTableViewController.h"
#import "CatchTableViewCell.h"
#import "ThemeColors.h"

@interface CatchesTableViewController ()

@end

@implementation CatchesTableViewController

@synthesize selectedCatch,
user,
noResultsLabel,
addLabel,
loginButton,
loginLabel,
selectedTabBarIndex,
userInfoView,
userInfoViewLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.parseClassName = @"Catch";
        self.textKey = @"species";
        self.imageKey = @"photo";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tableView registerClass:[CatchTableViewCell class] forCellReuseIdentifier:@"CatchesCell"];
    
    UILabel *noResultsLbl = [[UILabel alloc] initWithFrame:CGRectMake(85.0, 200.0, 180.0, 40.0)];
    noResultsLbl.text = @"No catches found";
    noResultsLbl.hidden = YES;
    noResultsLabel = noResultsLbl;
    [self.view addSubview:noResultsLabel];
    
    UILabel *addLbl = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 230.0, 180.0, 40.0)];
    addLbl.text = @"Add some catches!";
    addLbl.hidden = YES;
    addLabel = addLbl;
    [self.view addSubview:addLabel];
    
    UILabel *loginLbl = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 200.0, 240.0, 40.0)];
    loginLbl.text = @"Login to Add Catches!";
    loginLbl.hidden = YES;
    loginLabel = loginLbl;
    [self.view addSubview:loginLabel];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginBtn setTitle:@"Login or Signup" forState:UIControlStateNormal];
    [loginBtn addTarget:self
                 action:@selector(clickLoginButton:)
       forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setFrame:CGRectMake(80.0, 250.0, 150.0, 40.0)];
    [loginBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    loginBtn.hidden = YES;
    loginButton = loginBtn;
    [self.view addSubview:loginButton];

    [self updateUserInfoView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController setDelegate:self];
    
    // Check for login
    if ([self.tabBarController selectedIndex] == 3) {
        user = [PFUser currentUser];
    }
    
    if (user == nil || [user.username isEqualToString:@"notLoggedInUser"]) {
        
        if ([PFUser currentUser].username != user.username && [PFUser currentUser] != nil) {
            user = [PFUser currentUser];
            loginButton.hidden = YES;
            loginLabel.hidden = YES;
        } else {
            loginButton.hidden = NO;
            loginLabel.hidden = NO;
        }
        
    } else {
        loginButton.hidden = YES;
        loginLabel.hidden = YES;
        if ([PFUser currentUser].username != user.username && [PFUser currentUser] != nil) {
            [self updateUserInfoView];
        } else {
            userInfoView = nil;
        }
    }

    [self loadObjects];
}

- (void)updateUserInfoView
{
    if (userInfoView == nil) {
        UIView *uInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
        uInfoView.backgroundColor = [UIColor clearColor];
        UILabel *uInfoLabel = [UILabel new];
        uInfoLabel.text = user.username;
        uInfoLabel.textColor = [ThemeColors greenColor];
        uInfoLabel.frame = CGRectMake(0, 5, self.view.frame.size.width, 25);
        uInfoLabel.textAlignment = NSTextAlignmentCenter;
        //    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 34, self.view.frame.size.width, 1)];
        //    bottomLineView.backgroundColor = [UIColor blackColor];
        //    bottomLineView.alpha = 0.25;
        //    [uInfoView addSubview:bottomLineView];
        [uInfoView addSubview:uInfoLabel];
        userInfoView = uInfoView;
        userInfoViewLabel = uInfoLabel;
        [self.view addSubview:userInfoView];
    }
    
    if (user == nil || [user.username isEqualToString:@"notLoggedInUser"]) {
        userInfoViewLabel.text = nil;
    } else {
        userInfoViewLabel.text = user.username;
    }
}

- (void)tabBarController:(UITabBarController *)theTabBarController didSelectViewController:(UIViewController *)viewController {
    NSUInteger indexOfTab = [theTabBarController.viewControllers indexOfObject:viewController];
    selectedTabBarIndex = indexOfTab;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController setDelegate:nil];
    userInfoView.alpha = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    [self loadNoResultsView];
    if (userInfoView != nil && userInfoView.alpha != 1) {
        [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            userInfoView.alpha = 1;
        } completion:nil];
    }
}

- (void)loadNoResultsView {
    if ([self.objects count] == 0 && loginLabel.hidden == YES) {
        noResultsLabel.hidden = NO;
        if ([PFUser currentUser].username == user.username) {
            addLabel.hidden = NO;
        } else {
            addLabel.hidden = YES;
        }
    } else {
        noResultsLabel.hidden = YES;
        addLabel.hidden = YES;
    }
}

- (PFQuery *)queryForTable {
    [self updateUserInfoView];
    PFUser *currentUser = [PFUser currentUser];
//    if (currentUser == nil && user == nil) {
//        PFQuery *userQuery = [PFUser query];
//        [userQuery whereKey:@"username" equalTo:@"notLoggedInUser"];
//        [userQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//            if (!error) {
//                user = (PFUser *)object;
//            }
//        }];
//    }
    if (user == nil || (currentUser.username != user.username &&
                        selectedTabBarIndex == 3 &&
                        ![user.username isEqualToString:@"notLoggedInUser"])) {
        user = [PFUser currentUser];
    }
    PFQuery *query = [Catch query];
    [query whereKey:@"user" equalTo:user];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"user"];
    return query;
}

- (PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    CatchTableViewCell *cell = [tableView
                                      dequeueReusableCellWithIdentifier:@"CatchesCell"
                                      forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CatchTableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:@"CatchesCell"];
    }
    
    PFFile *imageFile = object[@"photo"];
    cell.imageView.image = [UIImage imageNamed:@"fish-default-photo.png"];
    cell.imageView.file = imageFile;
    
    NSAttributedString *speciesString = [[NSAttributedString alloc] initWithString:object[@"species"] attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                                                                   NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:16.0]}];
    cell.speciesLabel.attributedText = speciesString;
    
    NSString *sizeString = [NSString
                            stringWithFormat:@"Length - %1@ %1@, Weight - %1@ %1@",
                            object[@"length"],
                            object[@"lengthMeasurement"],
                            object[@"weight"],
                            object[@"weightMeasurement"]];
    NSAttributedString *sizeStringAttributed = [[NSAttributedString alloc] initWithString:sizeString attributes:@{NSForegroundColorAttributeName: [UIColor grayColor],
                                                                                                                  NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12.0]}];
    cell.sizeLabel.attributedText = sizeStringAttributed;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.objects.count && self.paginationEnabled) {
        // Load More Cell
        return [self loadNextPage];
    }
    
    selectedCatch = [self.objects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showCatchDetailFromProfile" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCatchDetailFromProfile"])
    {
        CatchDetailTableViewController *catchDetailVC = [segue destinationViewController];
        catchDetailVC.selectedCatch = selectedCatch;
        if ([selectedCatch.user.username isEqualToString:user.username]) {
            catchDetailVC.fromSelectedCatchUsersCatches = YES;
        } else {
            catchDetailVC.fromSelectedCatchUsersCatches = NO;
        }
    }
}

- (void)clickLoginButton:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"userLoginFormSegue" sender:nil];
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    if (userInfoView != nil && userInfoView.alpha != 0) {
//        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//            userInfoView.alpha = 0;
//        } completion:nil];
//    }
//}
//
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
//{
//    if (userInfoView != nil && userInfoView.alpha != 1) {
//        [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//            userInfoView.alpha = 1;
//        } completion:nil];
//    }
//}
//
//-(void)scrollViewDidScroll: (UIScrollView*)scrollView
//{
//    float scrollViewHeight = scrollView.frame.size.height;
//    float scrollContentSizeHeight = scrollView.contentSize.height;
//    float scrollOffset = scrollView.contentOffset.y;
//    
//    if (scrollOffset == 0)
//    {
//        // then we are at the top
//        if (userInfoView != nil && userInfoView.alpha != 1) {
//            [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                userInfoView.alpha = 1;
//            } completion:nil];
//        }
//    }
//    else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
//    {
//        // then we are at the end
//    }
//}


@end
