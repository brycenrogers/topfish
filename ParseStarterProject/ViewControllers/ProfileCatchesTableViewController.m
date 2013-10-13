//
//  ProfileCatchesTableViewController.m
//  TopFish
//
//  Created by Brycen Rogers on 9/4/13.
//
//

#import "ProfileCatchesTableViewController.h"
#import "Catch.h"

@interface ProfileCatchesTableViewController ()

@end

@implementation ProfileCatchesTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForTable {
    PFQuery *query = [Catch query];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    return query;
}

- (PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    if ([self.objects count] == 0) {
        return [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    static NSString *CellIdentifier = @"Cell";
    PFTableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier
                             forIndexPath:indexPath];
    if (nil == cell){
        cell = [[PFTableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[self.objects objectAtIndex:indexPath.row] species];
    
    cell.detailTextLabel.text = [NSString
                                 stringWithFormat:@"Length - %1.2d, Weight - %1.2d",
                                 [[self.objects objectAtIndex:indexPath.row] length],
                                 [[self.objects objectAtIndex:indexPath.row] weight]];
    
    cell.imageView.image = [UIImage imageNamed:@"fish-default-photo.png"];
    PFFile *imageFile = [object objectForKey:@"photo"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        cell.imageView.image = [UIImage imageWithData:data];
    }];
    
    return cell;
}

@end
