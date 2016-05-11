//
//  CatchPhotoDetailView.m
//  TopFish
//
//  Created by Brycen Rogers on 10/13/13.
//
//

#import "CatchPhotoDetailView.h"

@implementation CatchPhotoDetailView

@synthesize selectedCatch;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor whiteColor] setFill];
    UIRectFill(CGRectInset(self.bounds, 0, 0));
    [self addImageSubview];
}

- (void)addImageSubview {
    UIImage *defaultCatchPhoto = [UIImage imageNamed:@"fish-default-photo.png"];
    self.catchPhoto = defaultCatchPhoto;
    self.catchPhotoView = [[UIImageView alloc] initWithImage:self.catchPhoto];
    
    self.catchPhotoView.frame = CGRectMake(100, 10, 100, 100);
    
    if (selectedCatch) {
        PFFile *imageFile = [selectedCatch objectForKey:@"photo"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            self.catchPhoto = [UIImage imageWithData:data];
            self.catchPhotoView.image = self.catchPhoto;
            self.catchPhotoView.frame = CGRectMake(64, 10, 173, 130);
        }];
    }
    
    //catchPhotoView.image = selectedCatch.photo;
    //catchPhotoView.frame = CGRectMake(10, 10, 173, 130);
    
    [self addSubview:self.catchPhotoView];
}

@end
