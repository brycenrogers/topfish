//
//  LengthMeasurementOptionsTableViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/21/13.
//
//

#import <UIKit/UIKit.h>

@protocol LengthMeasurementSelector <NSObject>

- (UILabel *)selectedLengthMeasurementLabel;

@end

@interface LengthMeasurementOptionsTableViewController : UITableViewController

@property (nonatomic, assign) id<LengthMeasurementSelector> delegate;

@end
