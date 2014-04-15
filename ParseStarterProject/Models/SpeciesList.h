//
//  SpeciesList.h
//  TopFish
//
//  Created by Brycen Rogers on 9/22/13.
//
//

#import <Foundation/Foundation.h>

@interface SpeciesList : NSObject

+ (NSMutableArray *)getList;

@end

@protocol SpeciesListSelector <NSObject>

- (UILabel *)selectedSpeciesLabel;
- (void)changeSpeciesFieldIconToColor:(NSString *)color;

@end