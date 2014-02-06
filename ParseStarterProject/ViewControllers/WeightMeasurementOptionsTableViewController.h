//
//  WidthMeasurementOptionsViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/22/13.
//
//

#import <UIKit/UIKit.h>

@protocol WeightMeasurementSelector <NSObject>

- (UILabel *)selectedWeightMeasurementLabel;

@end

@interface WeightMeasurementOptionsTableViewController : UITableViewController

@property (nonatomic, assign) id<WeightMeasurementSelector> delegate;

@end