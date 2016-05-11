//
//  AllMethodSwitch.m
//  TopFish
//
//  Created by Brycen Rogers on 2/5/14.
//
//

#import "AllMethodsSwitch.h"

@implementation AllMethodsSwitch

@synthesize selectedMethodLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)switched {
    if (self.on) {
        self.selectedMethodLabel.text = @"Select Method";
        self.selectedMethodLabel.textColor = [UIColor grayColor];
    } else {
        self.selectedMethodLabel.textColor = [UIColor blackColor];
    }
}

@end
