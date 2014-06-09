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
#import "UserLoginViewController.h"

@interface CatchesTableViewController ()

@end

@implementation CatchesTableViewController

@synthesize selectedCatch,
user,
loggedInUser,
noResultsLabel,
addLabel,
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

    UIFont *boldFont = [UIFont boldSystemFontOfSize:17.0];
    UILabel *noResultsLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 225.0, self.view.frame.size.width, 40.0)];
    noResultsLbl.text = @"No catches found";
    noResultsLbl.font = boldFont;
    noResultsLbl.hidden = YES;
    noResultsLbl.textAlignment = NSTextAlignmentCenter;
    noResultsLabel = noResultsLbl;
    [self.view addSubview:noResultsLabel];
    
    UILabel *addLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 255.0, self.view.frame.size.width, 40.0)];
    addLbl.text = @"Add some catches!";
    addLbl.hidden = YES;
    addLbl.textAlignment = NSTextAlignmentCenter;
    addLabel = addLbl;
    [self.view addSubview:addLabel];
    
    [self updateUserInfoView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController setDelegate:self];
    // Unselect the selected row if any
	NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
	if (selection) {
		[self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    if ([self selectedTabBarIndex] == 3) {
        user = [PFUser currentUser];
    }
    
    // If the current user is equal to the requested user (viewing their own catches)
    if ([[PFUser currentUser].username isEqualToString:user.username]) {
            
        // User is logged in but has not added any catches
        if(self.objects.count == 0) {
            addLabel.hidden = NO;
            noResultsLabel.hidden = NO;
            [[super iconImage] setHidden:NO];
        } else {
            // Reset all buttons
            addLabel.hidden = YES;
            noResultsLabel.hidden = YES;
            [[super iconImage] setHidden:YES];
        }
        
    } else {
        
        // Reset all buttons
        addLabel.hidden = YES;
        noResultsLabel.hidden = YES;
        [[super iconImage] setHidden:YES];
    }
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
        [uInfoView addSubview:uInfoLabel];
        userInfoView = uInfoView;
        userInfoViewLabel = uInfoLabel;
        [self.view addSubview:userInfoView];
    }
    
    userInfoViewLabel.text = user.username;
}

- (void)tabBarController:(UITabBarController *)theTabBarController didSelectViewController:(UIViewController *)viewController {
    NSUInteger indexOfTab = [theTabBarController.viewControllers indexOfObject:viewController];
    selectedTabBarIndex = indexOfTab;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController setDelegate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNoResultsView {
    if ([self.objects count] == 0) {
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
    if (user == nil || selectedTabBarIndex == 3 || self.tabBarController.selectedIndex == 3) {
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
    if ([[segue identifier] isEqualToString:@"userLoginFormSegue"])
    {
        UserLoginViewController *userLoginVC = [segue destinationViewController];
        userLoginVC.delegate = self;
    }
}

@end
