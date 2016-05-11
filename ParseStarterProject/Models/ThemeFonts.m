//
//  ThemeFonts.m
//  TopFish
//
//  Created by Brycen Rogers on 6/7/14.
//
//

#import "ThemeFonts.h"

@implementation ThemeFonts

+ (UIFont *)dynamicFontBody
{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

+ (UIFont *)dynamicFontHeadline
{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

+ (UIFont *)dynamicFontSubheadline
{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
}

@end
