//
//  CatchPhotoDetailView.h
//  TopFish
//
//  Created by Brycen Rogers on 10/13/13.
//
//

#import <UIKit/UIKit.h>
#import "Catch.h"

@interface CatchPhotoDetailView : UIView

@property (nonatomic, strong) Catch *selectedCatch;
@property (nonatomic, strong) UIImage *catchPhoto;
@property (nonatomic, strong) UIImageView *catchPhotoView;

@end