//
//  ThemeColors.m
//  TopFish
//
//  Created by Brycen Rogers on 5/10/14.
//
//

#import "ThemeColors.h"

@implementation ThemeColors

+ (UIColor *)greenColor
{
    return [UIColor colorWithRed:(30.0f/255.0f) green:(146.0f/255.0f) blue:(49.0f/255.0f) alpha:1.0f];
}

+ (UIColor *)blueColor
{
    return [UIColor colorWithRed:(12.0f/255.0f) green:(121.0f/255.0f) blue:(246.0f/255.0f) alpha:1.0f];
}

+ (UIColor *)redColor
{
    return [UIColor colorWithRed:(211.0f/255.0f) green:(20.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
}

+ (UIColor *)orangeColor
{
    return [UIColor colorWithRed:(226.0f/255.0f) green:(104.0f/255.0f) blue:(25.0f/255.0f) alpha:1.0f];
}

+ (UIColor *)yellowColor
{
    return [UIColor colorWithRed:(246.0f/255.0f) green:(177.0f/255.0f) blue:(9.0f/255.0f) alpha:1.0f];
}

+ (UIColor *)backgroundImage
{
    return [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ricepaper_v3.png"]];
}

@end
