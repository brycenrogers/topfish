//
//  WidthMeasurementOptionsViewController.h
//  TopFish
//
//  Created by Brycen Rogers on 9/22/13.
//
//

#import <UIKit/UIKit.h>
#import "ThemedTableViewController.h"

@protocol WeightMeasurementSelector <NSObject>

- (UILabel *)selectedWeightMeasurementLabel;

@end

@interface WeightMeasurementOptionsTableViewController : ThemedTableViewController

@property (nonatomic, assign) id<WeightMeasurementSelector> delegate;

@end